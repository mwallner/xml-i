
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
					$currentSize += 200 # Approximate size per node
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

		Write-Host "Generated $FilePath ($((Get-Item $FilePath).Length / 1MB) MB)"
	}
	$outputDir = (Get-Item 'test').FullName
	if (-not (Test-Path $outputDir)) {
		New-Item -ItemType Directory -Path $outputDir | Out-Null
	}

	Generate-TestXml -FilePath "$outputDir/small.xml" -MinSizeMB 1
	Generate-TestXml -FilePath "$outputDir/mid.xml" -MinSizeMB 10
	Generate-TestXml -FilePath "$outputDir/large.xml" -MinSizeMB 100
	Generate-TestXml -FilePath "$outputDir/huge.xml" -MinSizeMB 500
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

	$apps += App 'Rust' 'target/release/xml-i'
	$apps += App 'C++' 'alien/bin/xml-i-cpp'
	$apps += App '.NET' 'alien/bin/dotnet/xml-i-dotnet'
	$apps += App 'pwsh' 'alien/pwsh/src/CountXmlNodes.ps1'

	$xmlFiles = Get-ChildItem 'test' -Filter '*.xml' -File | Sort-Object Length
	foreach ($app in $apps) {
		Write-Host "Running $($app.Title)..." -ForegroundColor Magenta
		foreach ($xmlFile in $xmlFiles) {
			Write-Host "  -> $($xmlFile.Name)"
			$startTime = Get-Date
			Exec {
				if ($app.Title -eq 'pwsh') {
					Exec {
						& pwsh -File $app.Executable -XmlFilePath $xmlFile | Out-Null
					}
				}
				else {
					Exec {
						& $app.Executable $xmlFile | Out-Null
					}
				}
			}
			$endTime = Get-Date
			$duration = ($endTime - $startTime).TotalSeconds
			$app.Results += [pscustomobject]@{
				Me   = $app
				File = $xmlFile
				Time = $duration
			}
		}
	}

	$xmlFiles | ForEach-Object {
		Write-Host "$($_.Name) ... $($(Get-Item $_).Length / 1MB) MB" -ForegroundColor Yellow
	}

	$apps.Results | Sort-Object -Property Time | ForEach-Object {
		Write-Host "$($_.Me.Title) - $($_.File.Name): $($_.Time) seconds"
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
