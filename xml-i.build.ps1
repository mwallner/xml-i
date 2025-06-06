
$global:configs = @{}

function New-AppDecl {
	param (
		[Parameter(Mandatory)]
		[string]
		$Name,

		[Parameter(Mandatory)]
		[string]
		$Description,

		[Parameter(Mandatory)]
		[string]
		$Origin,

		[Parameter(Mandatory = $false)]
		[scriptblock]
		$Meta,

		[Parameter(Mandatory )]
		[scriptblock]
		$Builder,

		[Parameter(Mandatory )]
		[Hashtable]
		$Tester
	)
	if ($global:configs.ContainsKey($Name)) {
		throw "App declaration for '$($Name)' already exists."
	}
	Write-Host " + $Name ($Origin)" -ForegroundColor Green
	$global:configs[$Name] = @{
		Name        = $Name
		Description = $Description
		Origin      = $Origin
		Meta        = $Meta
		Builder     = $Builder
		Tester      = $Tester
	}
}

function Invoke-AppBenchmark {
	param($app, $testXml, $outFileBase, $counter)
	if (-not $app.Tester) {
		Write-Host " No tester defined for $($app.Name). Skipping benchmark." -ForegroundColor Yellow
		return
	}

	Write-Host ('  -> {0} ({1:N2} MB)' -f $testXml.Name, $($testXml.Length / 1MB))
	$outFileName = Join-Path $outFileBase "tmp/$($app.Name)-$counter.out"
	$app.OutFiles += $outFileName
	Push-Location $app.Origin
	try {
		$appArgs = $app.Tester.ArgumentList
		$appArgs += $testXml.FullName
		$testrun = Measure-Command {
			$proc = Start-Process -FilePath $app.Tester.Executable -ArgumentList $appArgs -PassThru -NoNewWindow -WorkingDirectory (Get-Location) -RedirectStandardOutput $outFileName
			$maxMem = 0
			while (-not $proc.HasExited) {
				try {
					$mem = $proc.WorkingSet64 / 1MB
					if ($mem -gt $maxMem) { $maxMem = $mem }
				}
				catch {}
				Start-Sleep -Milliseconds 0
				$proc.Refresh()
			}
			# One last check after exit
			try {
				$mem = $proc.WorkingSet64 / 1MB
				if ($mem -gt $maxMem) { $maxMem = $mem }
			}
			catch {}
		}
		$app.Results[$testXml.Name] = @{
			Me           = $app
			File         = $testXml
			Milliseconds = $testrun.TotalMilliseconds
			MaxMemMB     = $maxMem
		}
		Write-Host (' ... ok ({0:N2} sec)' -f $testrun.TotalSeconds) -ForegroundColor Green
	}
	catch {
		Write-Host " Error benchmarking $($app.Name): $_ / $($testXml.Name)" -ForegroundColor Red
		Get-Error
	}
	finally {
		Pop-Location
	}
}

function Write-BenchmarkResults {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Configs,

		[Parameter(Mandatory)]
		[string]$MarkdownFilePath
	)


	function FormatSection($name, $command) {
		"***$name***"
		'```'
		"$($(& $command) | ForEach-Object { $_; "`n" })"
		'```'
		''
	}

	$mdResult = @()
	$mdResult += "# Benchmark Results $(Get-Date)"
	$mdResult += ''
	$mdResult += '## System Information'
	$mdResult += ''

	$appList = $Configs.GetEnumerator() | ForEach-Object {
		$_.Value
	}
	$appList.Results.Values | Group-Object { $_.File.Name } | ForEach-Object {
		$group = $_
		$pos = 1

		$groupSize = $group.Group[0].File.Length

		$mdResult += '## {0} ({1:N2} MB)' -f $group.Name, ($groupSize / 1MB)
		$mdResult += ''
		$mdResult += '| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |'
		$mdResult += '|------|---------------------------|------------|-------------------|--------------|'
		$group.Group | Sort-Object -Property Milliseconds | ForEach-Object {
			$tp = $groupSize / 1MB / $_.Milliseconds
			$mdResult += '| {0,-4} | {1,-25} | {3,-10:N3} | {4,-17:N3} | {5,-12:N2} |' -f $pos, $_.Me.Name, $_.File.Name, ($_.Milliseconds / 1000), $tp, $_.MaxMemMB
			$pos++
		}
		$mdResult += ''
	}

	$mdResult | Out-File -FilePath $MarkdownFilePath -Encoding UTF8
	Write-Host "Benchmark results written to $MarkdownFilePath." -ForegroundColor Green
}

Task ReadConfigs {
	$global:configs = @{}
	Get-ChildItem -Recurse -Filter '*.bc.ps1' | ForEach-Object {
		$scriptPath = $_.FullName
		if (Test-Path $scriptPath) {
			. $scriptPath
		}
		else {
			Write-Host "Warning: Script '$scriptPath' not found."
		}
	}
	Write-Host "Loaded $($global:configs.Count) application configurations."
}

Task Build ReadConfigs, {
	$global:configs.GetEnumerator() | ForEach-Object {
		$app = $_.Value
		if ($app.Builder) {
			Write-Host "Building $($app.Name)..."
			Push-Location $app.Origin
			try {
				Exec {
					& $app.Builder
				}
			}
			catch {
				Write-Host "Error building $($app.Name): $_" -ForegroundColor Red
			}
			finally {
				Pop-Location
			}
		}
		else {
			Write-Host "No builder defined for $($app.Name). Skipping build."
		}
	}
}

Task Benchmark ReadConfigs, {
	# $testXmls = @((Get-Item ./test/small.xml).FullName , (Get-Item test/mid.xml).FullName)
	$testXmls = Get-ChildItem 'test' -Filter '*.xml'
	$outFileBase = (Get-Item 'test').FullName

	$global:configs.GetEnumerator() | ForEach-Object {
		$app = $_.Value
		$app.Results = @{}
		$app.OutFiles = @()
		$i = 0

		Write-Host " Benchmarking $($app.Name)..." -ForegroundColor Magenta
		foreach ($testXml in $testXmls) {
			Invoke-AppBenchmark -app $app -testXml $testXml -outFileBase $outFileBase -counter $i
			$i++
		}
	}

	Write-Host "Benchmarking completed for $($global:configs.Count) applications." -ForegroundColor Green
	Write-BenchmarkResults -Configs $global:configs -MarkdownFilePath (Join-Path $outFileBase 'benchmark_results.md')
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
