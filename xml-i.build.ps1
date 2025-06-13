param(
	[Parameter(Mandatory = $false)]
	[string]
	$AppFilter = $null,

	[Parameter(Mandatory = $false)]
	[string]
	$TestFileFilter = $null,

	[Parameter(Mandatory = $false)]
	[switch]
	$Quick
)

. (Join-Path $PSScriptRoot 'xml-i.reporting.ps1')

$global:outFileBase = (Get-Item 'test').FullName
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
		$ParserType,

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
		ParserType  = $ParserType
		Origin      = $Origin
		Meta        = $Meta
		Builder     = $Builder
		Tester      = $Tester
	}
}

function Invoke-AppBenchmark {
	param($app, $testXml, $counter)
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
		$timeBegin = Get-Date
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
		$timeDuration = (Get-Date) - $timeBegin
		$app.Results[$testXml.Name] = @{
			Me           = $app
			File         = $testXml
			Success      = $true
			Content      = Get-Content -Path $outFileName
			Milliseconds = $timeDuration.TotalMilliseconds
			MaxMemMB     = $maxMem
		}
		Write-Host (' ... ok ({0:N2} sec)' -f $timeDuration.TotalSeconds) -ForegroundColor Green
	}
	catch {
		$app.Results[$testXml.Name] = @{
			Me      = $app
			File    = $testXml
			Success = $false
		}
		Write-Host " Error benchmarking $($app.Name): $_ / $($testXml.Name)" -ForegroundColor Red
		Get-Error
	}
	finally {
		Pop-Location
	}
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

		if ($AppFilter -and $app.Name -notlike "*$AppFilter*") {
			Write-Host "Skipping $($app.Name) due to filter." -ForegroundColor Yellow
			return
		}

		if ($app.Builder) {
			Write-Host "Building $($app.Name)..."
			Push-Location $app.Origin
			try {
				exec {
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

	if (-not $testXmls) {
		Write-Host "No test XML files found in 'test' directory." -ForegroundColor Red
		Write-Host "Run target 'MakeTestData to generate some sample files!" -ForegroundColor Red
		return
	}

	if (Test-Path "$outFileBase/tmp") {
		Remove-Item -Path "$outFileBase/tmp" -Recurse -Force
	}
	New-Item -ItemType Directory -Path "$outFileBase/tmp" | Out-Null
	
	# Sort apps: Rust* first, then the rest
	$sortedApps = $global:configs.GetEnumerator() | Sort-Object { if ($_.Key -match [regex]::Escape('Rust (quick-xml)')) { 0 } else { 1 } }, { $_.Key }

	$baseline = $null

	$sortedApps | ForEach-Object {
		$app = $_.Value
		$app.Results = @{}
		$app.OutFiles = @()
		$i = 0

		if ($AppFilter -and $app.Name -notlike "*$AppFilter*") {
			Write-Host "Skipping $($app.Name) due to filter." -ForegroundColor Yellow
			return
		}

		Write-Host ' ==================================== ' -ForegroundColor Blue
		$app.MetaInfo = if ($app.Meta) {
			$app.Meta.Invoke()
		}
		else {	''	}

		if ($PSVersionTable.Platform -eq 'Unix') {
			Write-Host 'Dropping caches 4 fair benchmarking... ' -ForegroundColor Magenta
			if (Test-Path '/proc/sys/vm/drop_caches' ) {
				sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
			}
			else {
				Write-Host 'Warning: /proc/sys/vm/drop_caches not found. Skipping cache drop.' -ForegroundColor Yellow
			}
			sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
		}
		if (-Not $Quick) {
			Write-Host 'Waiting 10 seconds for caches to settle... & the system cool down' -ForegroundColor Magenta
			Start-Sleep -Seconds 10
		}

		Write-Host " Benchmarking $($app.Name)..." -ForegroundColor Blue
		Write-Host ' ==================================== ' -ForegroundColor Blue

		foreach ($testXml in $testXmls) {

			if ($TestFileFilter -and $testXml.Name -notlike "*$TestFileFilter*") {
				Write-Host "  Skipping $($testXml.Name) due to filter." -ForegroundColor Yellow
				continue
			}

			Invoke-AppBenchmark -app $app -testXml $testXml -counter $i
			$i++
		}
		
		if (-Not $baseline) {
			# Set the first app as baseline
			$baseline = $app
			Write-Host "Setting $($app.Name) as baseline." -ForegroundColor Cyan
		}
		else {
			# Compare with baseline
			Write-Host "Comparing $($app.Name) with baseline $($baseline.Name)..." -ForegroundColor Cyan
			$app.BaselineResults = @{}
			foreach ($testXml in $testXmls) {
				$base = $baseline.Results[$testXml.Name]
				$test = $app.Results[$testXml.Name]
				if (-Not $test.Success) {
					Write-Host "  Skipping $($testXml.Name) for $($app.Name) due to previous failure." -ForegroundColor Yellow
					continue
				}
				$a = $base.Content | Sort-Object
				$b = $test.Content | Sort-Object
				if (Compare-Object -ReferenceObject $a -DifferenceObject $b -SyncWindow 0 -IncludeEqual | Where-Object { $_.SideIndicator -ne '==' }) {
					Write-Host "  Differences found in $($testXml.Name) for $($app.Name) vs baseline." -ForegroundColor Red
				}
				else {
					Write-Host "  No differences in $($testXml.Name) for $($app.Name) vs baseline." -ForegroundColor Green
				}
			}	
		}

	}

	Write-Host "Benchmarking completed for $($global:configs.Count) applications." -ForegroundColor Green
	$exportConfigs = @{}
	foreach ($key in $global:configs.Keys) {
		$app = $global:configs[$key].PSObject.Copy()
		$app.Remove('Builder')
		$app.Remove('Tester')
		$app.Remove('Meta')
		if ($app.Results) {
			foreach ($testXml in $app.Results.Keys) {
				$app.Results[$testXml].File = @{
					Name   = $app.Results[$testXml].File.Name
					Length = $app.Results[$testXml].File.Length
				}
				$app.Results[$testXml].Me = @{
					Name   = $app.Results[$testXml].Me.Name
					Origin = $app.Results[$testXml].Me.Origin
				}
			}
		}
		$exportConfigs[$key] = $app
	}
	@{
		BenchmarkDate    = (Get-Date)
		BenchmarkResults = $exportConfigs 
	}	| ConvertTo-Json -Depth 5 | Set-Content -Path (Join-Path $outFileBase 'benchmark_result.json') -Encoding UTF8
}

Task GenerateBenchmarkResults {
	$outFileBase = 'test'
	$cfg = Get-Content -Path (Join-Path $outFileBase 'benchmark_result.json') | ConvertFrom-Json -AsHashtable
	Write-BenchmarkResultsMarkdown -Results $cfg -MarkdownFilePath (Join-Path $outFileBase 'benchmark_results.md')
	Write-BenchmarkSVG -Results $cfg.BenchmarkResults -SvgFilePath (Join-Path $outFileBase 'benchmark_tp.svg')
	Write-BenchmarkLineSVG -Results $cfg.BenchmarkResults -SvgFilePath (Join-Path $outFileBase 'benchmark_tp_line.svg')
	Write-BenchmarkXYSVG -Results $cfg.BenchmarkResults -SvgFilePath (Join-Path $outFileBase 'benchmark_xy.svg')
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

	Generate-TestXml -FilePath "$outputDir/micro.xml" -MinSizeMB 0.5
	Generate-TestXml -FilePath "$outputDir/tiny.xml" -MinSizeMB 0.8
	Generate-TestXml -FilePath "$outputDir/small.xml" -MinSizeMB 2
	Generate-TestXml -FilePath "$outputDir/mid.xml" -MinSizeMB 10
	Generate-TestXml -FilePath "$outputDir/large.xml" -MinSizeMB 100
	Generate-TestXml -FilePath "$outputDir/huge.xml" -MinSizeMB 500
	Generate-TestXml -FilePath "$outputDir/giant.xml" -MinSizeMB 1500
	Generate-TestXml -FilePath "$outputDir/behemoth.xml" -MinSizeMB 2500
}
