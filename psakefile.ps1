
Task default -depends Help

Task Help {
	Write-Host 'Available tasks:'
	Write-Host '  Build - Build all projects'
	Write-Host '  Clean - Clean build artifacts'
	Write-Host '  Benchmark - Run benchmarks'
	Write-Host '  MakeTestData - Generate test XML files'
}

Task Build -depends BuildRust, BuildCpp, BuildNET , BuildJava, FetchXSLTDependencies 

Task MakeTestData {
	Write-Host 'Generating test XML files...'

	function Generate-TestXml {
		param (
			[string]$FilePath,
			[int]$MinSizeMB
		)

		$random = [System.Random]::new()
		$textOptions = @('foo', 'far', 'baz', 'faz')
		$guid = [guid]::NewGuid

		$writerSettings = New-Object System.Xml.XmlWriterSettings
		$writerSettings.Indent = $true
		$writerSettings.CloseOutput = $true

		$sizeBytes = $MinSizeMB * 1MB
		$currentSize = 0

		$writer = [System.Xml.XmlWriter]::Create($FilePath, $writerSettings)
		try {
			$writer.WriteStartDocument()
			$writer.WriteStartElement('start')
			do {
				# Write <boings> or <blips> randomly
				$parentNode = if ($random.Next(2) -eq 0) { 'boings' } else { 'blips' }
				$writer.WriteStartElement($parentNode)

				# Write child nodes
				for ($i = 0; $i -lt 1000; $i++) {
					$childNode = if ($parentNode -eq 'boings') { 'boing' } else { 'blip' }
					$writer.WriteStartElement($childNode)

					# Add random attributes
					$attrCount = $random.Next(1, 11)
					for ($j = 1; $j -le $attrCount; $j++) {
						$writer.WriteAttributeString("a_$j", [guid]::NewGuid().ToString())
					}

					# Add random text content
					$writer.WriteString($textOptions[$random.Next($textOptions.Length)])
					$writer.WriteEndElement() # Close <boing> or <blip>

					# Update size estimate
					$currentSize += 200 # Approximate size per node
					if ($currentSize -ge $sizeBytes) { break }
				}

				$writer.WriteEndElement() # Close <boings> or <blips>
			} while ($currentSize -lt $sizeBytes) 

			$writer.WriteEndElement() # Close <start>
			$writer.WriteEndDocument()
		}
		finally {
			$writer.Close()
		}

		Write-Host "Generated $FilePath ($((Get-Item $FilePath).Length / 1MB) MB)"
	}
	$outputDir = (Get-Item 'test').FullName
	if (-not (Test-Path $outputDir)) {
		New-Item -ItemType Directory -Path $outputDir | Out-Null
	}

	Generate-TestXml -FilePath "$outputDir/tiny.xml" -MinSizeMB 0.5
	Generate-TestXml -FilePath "$outputDir/small.xml" -MinSizeMB 1
	Generate-TestXml -FilePath "$outputDir/mid.xml" -MinSizeMB 10
	Generate-TestXml -FilePath "$outputDir/large.xml" -MinSizeMB 100
	Generate-TestXml -FilePath "$outputDir/huge.xml" -MinSizeMB 500
	Generate-TestXml -FilePath "$outputDir/giant.xml" -MinSizeMB 2000
}

Task Benchmark {
	Write-Host 'Running benchmarks...'
	$apps = @()

	function App($title, $executable) {
		@{
			Title      = $title
			Executable = $executable
			Results    = @()
		}
	}


	$tempDir = Join-Path (Get-Item 'test').FullName 'tmp'
	if (-not (Test-Path $tempDir)) {
		New-Item -ItemType Directory -Path $tempDir | Out-Null
	}

	function AppFile ($app) {
		Join-Path $tempDir "$($app.Title).outlog"
	}

	$apps += App 'Rust' 'target/release/xml-i'
	$apps += App 'C++ (xerces)' 'alien/bin/xml-i-xerces'
	$apps += App 'C++ (libxml2 - sax)' 'alien/bin/xml-i-libxml2'
	$apps += App 'C++ (libxml2 - reader)' 'alien/bin/xml-i-libxml2-xmlreader'
	$apps += App 'C++ (pugixml)' 'alien/bin/xml-i-pugixml'
	$apps += App '.NET' 'alien/bin/dotnet/xml-i-dotnet'
	$apps += App 'pwsh' 'alien/pwsh/src/CountXmlNodes.ps1'
	$apps += App 'python' 'alien/python/src/CountXmlNodes.py'
	$apps += App 'java' 'alien/java/src/CountXMLNodes'
	$apps += App 'xsl - saxon-he-12.7' 'alien/xslt/src/CountXmlNodes.xsl'

	$xmlFiles = Get-ChildItem 'test' -Filter '*.xml' -File | Sort-Object Length
	foreach ($app in $apps) {
		Write-Host "Running $($app.Title)..." -ForegroundColor Magenta
		foreach ($xmlFile in $xmlFiles) {
			Write-Host "  -> $($xmlFile.Name)" -NoNewline
			Write-Host (' | {0:N2} MB ... ' -f ($xmlFile.Length / 1MB)) -NoNewline
			$startTime = Get-Date
			if ($app.Title -eq 'pwsh') {
				Exec {
					& pwsh -File $app.Executable -XmlFilePath $xmlFile | Out-File (AppFile $app)
				}
			}
			elseif ($app.Title -eq 'python') {
				Exec {
					& python $app.Executable $xmlFile | Out-File (AppFile $app)
				}
			}
			elseif ($app.Title -eq 'java') {
				Exec {
					& java -cp './alien/java/src/.' 'CountXMLNodes' $xmlFile | Out-File (AppFile $app)
				}
			}
			elseif ($app.Title -eq 'xsl - saxon-he-12.7') {
				Exec {
					& java -jar './alien/xslt/saxon/saxon-he-12.7.jar' -s:$xmlFile.FullName -xsl:"$($app.Executable)" | Out-File (AppFile $app)
				}
			}
			else {
				Exec {
					& $app.Executable $xmlFile | Out-File (AppFile $app)
				}
			}
			$endTime = Get-Date
			$duration = ($endTime - $startTime).TotalSeconds
			Write-Host " | $($duration) sec "
			$app.Results += [pscustomobject]@{
				Me   = $app
				File = $xmlFile
				Time = $duration
			}
		}
	}

	<#
	$xmlFiles | ForEach-Object {
		Write-Host "$($_.Name) " -ForegroundColor Yellow -NoNewline
		Write-Host (' | {0:N2} MB ... ' -f ($_.Length / 1MB))
	}
	#>

	Write-Host ''

	# Group results by File.Name
	$apps.Results | Group-Object { $_.File.Name } | ForEach-Object {
		$group = $_
		$pos = 1

		'Benchmark Results: {0} {1:N2} MB ...' -f $group.Name, ($group.Group[0].File.Length / 1MB) | Write-Host -ForegroundColor Cyan
		Write-Host '---------------------------------------------'
		'{0,-6} {1,-25} {2,-10}' -f 'Rank', 'Application', 'Time (s)' | Write-Host -ForegroundColor Green
		Write-Host '---------------------------------------------'

		# Sort each group by Time and rank them
		$group.Group | Sort-Object -Property Time | ForEach-Object {
			# Determine the color based on the rank
			$color = switch ($pos) {
				1 { 'Green' }
				2 { 'Yellow' }
				3 { 'Yellow' }
				default { 'Red' }
			}

			'{0,-6} {1,-25} {3,-10:N3}' -f $pos, $_.Me.Title, $_.File.Name, $_.Time | Write-Host -ForegroundColor $color
			$pos++
		}

		Write-Host '---------------------------------------------'
		Write-Host ''
	}

}

Task Clean {
	Write-Host 'Cleaning build artifacts...'
	Remove-Item -Recurse -Force alien/bin -ErrorAction SilentlyContinue
	Remove-Item -Force alien/C++/src/*.o -ErrorAction SilentlyContinue
	Remove-Item -Recurse -Force target -ErrorAction SilentlyContinue
}

Task BuildRust {
	Write-Host 'Building Rust application...'

	Exec {
		& cargo build --release
	}
}

Task BuildCpp {
	Write-Host 'Building C++ applications...'
	$CXX = 'g++'
	$CXXFLAGS = @('-std=c++20', '-O3', '-Wall', '-Wextra', '-pedantic', '-DNDEBUG')


	Push-Location 'alien'
	try {
		if (-not (Test-Path 'bin')) {
			New-Item -ItemType Directory -Path 'bin' | Out-Null
		}

		# Xerces-C++ build configuration
		$XERCESC_INC = '/usr/include/xercesc'
		$XERCESC_LIB = '/usr/lib'
		$XERCESC_SRC = 'C++/src/main_xerces.cpp'
		$XERCESC_OBJ = $XERCESC_SRC -replace '\.cpp$', '.o'
		$XERCESC_TARGET = 'bin/xml-i-xerces'

		# Build main_xerces.cpp
		Write-Host 'Building main_xerces.cpp with Xerces-C++...'
		Exec {
			& $CXX @($CXXFLAGS) "-I$XERCESC_INC" '-c' $XERCESC_SRC '-o' $XERCESC_OBJ
		}
		Exec {
			& $CXX @($CXXFLAGS) "-I$XERCESC_INC" "-L$XERCESC_LIB" '-lxerces-c' '-o' $XERCESC_TARGET $XERCESC_OBJ
		}

		# libxml2 build configuration
		$LIBXML2_INC = '/usr/include/libxml2'
		$LIBXML2_LIB = '/usr/lib'
		$LIBXML2_SRC = 'C++/src/main_libxml2.cpp'
		$LIBXML2_OBJ = $LIBXML2_SRC -replace '\.cpp$', '.o'
		$LIBXML2_TARGET = 'bin/xml-i-libxml2'

		# libxml2 xmlreader build configuration
		$LIBXML2_XMLREADER_SRC = 'C++/src/main_libxml2_xmlreader.cpp'
		$LIBXML2_XMLREADER_OBJ = $LIBXML2_XMLREADER_SRC -replace '\.cpp$', '.o'
		$LIBXML2_XMLREADER_TARGET = 'bin/xml-i-libxml2-xmlreader'

		# Build main_libxml2.cpp
		Write-Host 'Building main_libxml2.cpp with libxml2...'
		Exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" '-c' $LIBXML2_SRC '-o' $LIBXML2_OBJ
		}
		Exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" "-L$LIBXML2_LIB" '-lxml2' '-o' $LIBXML2_TARGET $LIBXML2_OBJ
		}

		# Build main_libxml2_xmlreader.cpp
		Write-Host 'Building main_libxml2_xmlreader.cpp with libxml2 xmlreader...'
		Exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" '-c' $LIBXML2_XMLREADER_SRC '-o' $LIBXML2_XMLREADER_OBJ
		}
		Exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" "-L$LIBXML2_LIB" '-lxml2' '-o' $LIBXML2_XMLREADER_TARGET $LIBXML2_XMLREADER_OBJ
		}

		# pugixml build configuration
		$PUGIXML_SRC = 'C++/src/main_pugixml.cpp'
		$PUGIXML_OBJ = $PUGIXML_SRC -replace '\.cpp$', '.o'
		$PUGIXML_TARGET = 'bin/xml-i-pugixml'

		# Build main_pugixml.cpp
		Write-Host 'Building main_pugixml.cpp with pugixml...'
		Exec {
			& $CXX @($CXXFLAGS) '-c' $PUGIXML_SRC '-o' $PUGIXML_OBJ
		}
		Exec {
			& $CXX @($CXXFLAGS) '-lpugixml' '-o' $PUGIXML_TARGET $PUGIXML_OBJ
		}

		<#
		# Build main_xsde.cpp
		Write-Host 'Building main_xsde.cpp with libxsde...'
		Exec {
			& $CXX @($CXXFLAGS) -I.../src_xsde/libxsde '-c' 'C++/src_xsde/scheme-pskel.cxx' 'C++/src/main_xsde.cpp'
		}
		Exec {
			& $CXX @($CXXFLAGS) '-o' 'bin/xml-i-xsde' 'C++/src/main_xsde.o' 'C++/src_xsde/scheme-pskel.o' .../src_xsde/libxsde/libxsde.a
		}
		#>
	}
	finally {
		Pop-Location
	}
}

Task BuildNET {
	Write-Host 'Building .NET application...'
	$DOTNET_SRC = 'NET/src'
	$DOTNET_TARGET = 'bin/dotnet'

	Push-Location 'alien'
	try {
		Exec {
			& dotnet publish $DOTNET_SRC -c Release -o $DOTNET_TARGET
		}
	}
	finally { Pop-Location }
}

Task BuildJava {
	Write-Host 'Building java application...'
	$JAVA_SRC = 'alien/java/src'

	Push-Location $JAVA_SRC
	try {
		Exec {
			javac 'CountXMLNodes.java'
		}
	}
 finally { Pop-Location }
}

Task FetchXSLTDependencies {	
	Write-Host 'Fetching XSLT dependencies...'

	Push-Location 'alien/xslt'
	try {
		$saxonZipFile = 'SaxonHE12-7J.zip'
		$saxonHE12DownloadUrl = 'https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-7/SaxonHE12-7J.zip'
		if (-Not (Test-Path $saxonZipFile)) {
			Write-Host "Downloading Saxon-HE from $saxonHE12DownloadUrl"
			Invoke-WebRequest -Uri $saxonHE12DownloadUrl -OutFile $saxonZipFile
		}
		else {
			Write-Host 'Saxon-HE already downloaded.'
		}
		if (-Not (Test-Path 'saxon')) {
			Write-Host 'Extracting Saxon-HE...'
			Expand-Archive -Path $saxonZipFile -DestinationPath 'saxon' -Force
		}
		else {
			Write-Host 'Saxon-HE already extracted.'
		}	

	}
	finally {
		Pop-Location
	}
}
