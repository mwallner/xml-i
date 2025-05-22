
Task default -depends Help

Task Help {
	Write-Host 'Available tasks:'
	Write-Host '  Build - Build all projects'
	Write-Host '  Clean - Clean build artifacts'
	Write-Host '  Benchmark - Run benchmarks'
	Write-Host '  MakeTestData - Generate test XML files'
}

Task Build -depends BuildRust, BuildCpp, BuildNET {
}

Task MakeTestData {
	Write-Host 'Generating test XML files...'

	function Generate-TestXml {
		param (
			[string]$FilePath,
			[int]$SizeMB
		)

		$random = [System.Random]::new()
		$textOptions = @('foo', 'far', 'baz', 'faz')
		$guid = [guid]::NewGuid

		$writerSettings = New-Object System.Xml.XmlWriterSettings
		$writerSettings.Indent = $true
		$writerSettings.CloseOutput = $true

		$sizeBytes = $SizeMB * 1MB
		$currentSize = 0

		$writer = [System.Xml.XmlWriter]::Create($FilePath, $writerSettings)
		try {
			$writer.WriteStartDocument()
			$writer.WriteStartElement('start')

			while ($currentSize -lt $sizeBytes) {
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
					$currentSize += 100 # Approximate size per node
					if ($currentSize -ge $sizeBytes) { break }
				}

				$writer.WriteEndElement() # Close <boings> or <blips>
			}

			$writer.WriteEndElement() # Close <start>
			$writer.WriteEndDocument()
		}
		finally {
			$writer.Close()
		}

		Write-Host "Generated $FilePath ($SizeMB MB)"
	}
	$outputDir = (Get-Item 'test').FullName
	if (-not (Test-Path $outputDir)) {
		New-Item -ItemType Directory -Path $outputDir | Out-Null
	}

	Generate-TestXml -FilePath "$outputDir/small.xml" -SizeMB 1
	Generate-TestXml -FilePath "$outputDir/mid.xml" -SizeMB 10
	Generate-TestXml -FilePath "$outputDir/large.xml" -SizeMB 100
}

Task Benchmark {
	$apps = @{}
	function Add-App($title, $executable) {
		$apps[$title] = @{
			Title      = $title
			Executable = $executable
			Results    = @()
		}	
	}

	Add-App 'Rust' 'target/release/xml-i'
	Add-App 'C++' 'alien/bin/xml-i-cpp'
	Add-App '.NET' 'alien/bin/dotnet/xml-i-dotnet'
	Add-App 'pwsh' 'alien/pwsh/src/CountXmlNodes.ps1'

	$xmlFiles = @('test/small.xml', 'test/mid.xml', 'test/large.xml')
	foreach ($app in $apps.GetEnumerator()) {
		foreach ($xmlFile in $xmlFiles) {
			$startTime = Get-Date
			Write-Host "Running $($app.Value.Title) on $xmlFile..."
			Exec {
				if ($app.Value.Title -eq 'pwsh') {
					Exec {
						& pwsh -File $app.Value.Executable -XmlFilePath $xmlFile | Out-Null
					}
				}
				else {
					Exec {
						& $app.Value.Executable $xmlFile | Out-Null
					}
				}
			}
			$endTime = Get-Date
			$duration = ($endTime - $startTime).TotalSeconds
			$app.Value.Results += [pscustomobject]@{
				File = $xmlFile
				Time = $duration
			}
		}
	}

	$apps.GetEnumerator() | ForEach-Object {
		$results = $_.Value.Results
		Write-Host "Results for $($_.Value.Title):"
		foreach ($result in $results) {
			Write-Host "  $($result.File): $($result.Time) seconds"
		}
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
	Write-Host 'Building C++ application...'
	$CXX = 'g++'
	$CXXFLAGS = @('-std=c++20', '-O3', '-Wall', '-Wextra', '-pedantic')
	$XERCESC_INC = '/usr/include/xercesc'
	$XERCESC_LIB = '/usr/lib'
	$CPP_SRCS = 'C++/src/main.cpp'
	$CPP_OBJS = $CPP_SRCS -replace '\.cpp$', '.o'
	$CPP_TARGET = 'bin/xml-i-cpp'

	Push-Location 'alien'
	try {
		if (-not (Test-Path 'bin')) {
			New-Item -ItemType Directory -Path 'bin' | Out-Null
		}

		Exec {
			& $CXX @($CXXFLAGS) "-I$XERCESC_INC" '-c' $CPP_SRCS '-o' $CPP_OBJS
		}

		Exec {
			& $CXX @($CXXFLAGS) "-I$XERCESC_INC" "-L$XERCESC_LIB" '-lxerces-c' '-o' $CPP_TARGET $CPP_OBJS
		}
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
