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

function Write-BenchmarkResultsMarkdown {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Configs,

		[Parameter(Mandatory)]
		[string]$MarkdownFilePath
	)


	function FormatSection($app) {
		if ($app.Name -And $app.Description -And $app.Meta) {
			''
			"### $($app.Name)"
			$meta = $app.Meta.Invoke()
			$metaInfo = $meta
			''
			$app.Description
			''
			if ($metainfo) {
				'```'
				$metaInfo
				'```'
			}
			''
			'| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |'
			'|---------------------------|------------|-------------------|--------------|'
			$app.Results.Values | Where-Object Success | Sort-Object Milliseconds -Descending | ForEach-Object {
				$fileSizeMB = $_.File.Length / 1MB
				$tp = $fileSizeMB / ($_.Milliseconds / 1000)
				'| {0,-25} | {1,-10:N3} | {2,-17:N3} | {3,-12:N2} |' -f $_.File.Name, ($_.Milliseconds / 1000), $tp, $_.MaxMemMB
			}

		}
	}

	$mdResult = @()
	$mdResult += "# Benchmark Results $(Get-Date)"
	$mdResult += ''
	if ($AppFilter) {
		$mdResult += "AppFilter: ``$AppFilter``"
		$mdResult += ''
	}
	if ($TestFileFilter) {
		$mdResult += "TestFileFilter: ``$TestFileFilter``"
		$mdResult += ''
	}
	$mdResult += '## System Information'
	$mdResult += '```'
	$mdResult += "Hostname: $(hostname)"
	$mdResult += "Kernel: $(uname -srmo)"
	$mdResult += "Distro: $(cat /etc/os-release | grep '^PRETTY_NAME=' | cut -d= -f2- | tr -d '\"')"
	$mdResult += "CPU: $(lscpu | grep 'Model name' | head -1 | sed 's/Model name:[ \t]*//')"
	$mdResult += "Disk: $(lsblk -d -o MODEL | sed -n '2p' | xargs)"
	$mdResult += "Memory: $(free -h | grep Mem: | awk '{print $2}')"
	$mdResult += '```'

	$mdResult += ''
	$mdResult += '## Overall Results'
	$mdResult += ''
	$mdResult += '![benchmark results](benchmark_tp_line.svg)'
	$mdResult += ''

	$appList = $Configs.GetEnumerator() | ForEach-Object {
		$_.Value
	}
	$appList.Results.Values | Sort-Object { $_.File.Length } -Descending | Group-Object { $_.File.Name } | ForEach-Object {
		$group = $_
		$pos = 1

		$groupSize = $group.Group[0].File.Length
		$groupSizeMB = [math]::Round($groupSize / 1MB, 2)
		if ($groupSizeMB -eq 0) {
			$groupSizeKB = [math]::Round($groupSize / 1KB, 1)
			$sizeLabel = "$groupSizeKB KB"
		}
		else {
			$sizeLabel = "$groupSizeMB MB"
		}
    
		$mdResult += ''
		$mdResult += '### {0} ({1})' -f $group.Name, $sizeLabel
		$mdResult += ''
		$mdResult += '| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |'
		$mdResult += '|------|---------------------------|------------|-------------------|--------------|'
		$group.Group | Where-Object Success | Sort-Object -Property Milliseconds | ForEach-Object {
			$tp = $groupSize / 1MB / ($_.Milliseconds / 1000)
			$mdResult += '| {0,-4} | {1,-25} | {3,-10:N3} | {4,-17:N3} | {5,-12:N2} |' -f $pos, $_.Me.Name, $_.File.Name, ($_.Milliseconds / 1000), $tp, $_.MaxMemMB
			$pos++
		}
		$mdResult += ''
	}

	$mdResult += ''
	$mdResult += '## App - Results'
	$mdResult += ''

	$Configs.Values | Sort-Object Name | ForEach-Object {
		$app = $_
		if ($AppFilter -and $app.Name -notlike "*$AppFilter*") {
			Write-Host "Skipping $($app.Name) due to filter." -ForegroundColor Yellow
			return
		}
		$mdResult += FormatSection $app
	}

	$mdResult | Out-File -FilePath $MarkdownFilePath -Encoding UTF8
	Write-Host "Benchmark results written to $MarkdownFilePath." -ForegroundColor Green
}

function Write-BenchmarkLineSVG {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Configs,

		[Parameter(Mandatory)]
		[string]$SvgFilePath
	)

	# Gather all test files and apps
	$testFiles = @()
	$apps = @()
	foreach ($app in $Configs.Values) {
		$apps += $app.Name
		foreach ($result in $app.Results.Values) {
			if ($testFiles -notcontains $result.File) {
				$testFiles += $result.File
			}
		}
	}
	$testFiles = $testFiles | Sort-Object { $_.Length } -Descending
	$apps = $apps | Sort-Object

	# Build throughput table: $table[app][file] = throughput
	$table = @{}
	foreach ($app in $Configs.Values) {
		$row = @{}
		foreach ($result in $app.Results.Values) {
			$tp = [math]::Round(($result.File.Length / 1MB) / ($result.Milliseconds / 1000), 2)
			$row[$result.File.Name] = $tp
		}
		$table[$app.Name] = $row
	}

	# SVG layout
	$width = 900
	$height = 500
	$marginLeft = 100
	$marginBottom = 60
	$marginTop = 80
	$marginRight = 40
	$plotWidth = $width - $marginLeft - $marginRight
	$plotHeight = $height - $marginTop - $marginBottom

	# Find max throughput for scaling
	$maxTp = ($table.Values | ForEach-Object { $_.Values } | ForEach-Object { $_ } | Measure-Object -Maximum).Maximum
	if (-not $maxTp) { $maxTp = 1 }

	# Colors for lines
	$colors = @('#4e79a7', '#f28e2b', '#e15759', '#76b7b2', '#59a14f', '#edc949', '#af7aa1', '#ff9da7', '#9c755f', '#bab0ab')

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='$width' height='$height' style='background-color:#fff'>"
	$svg += '<style> .label { font: 13px sans-serif; } .legend { font: 13px sans-serif; } .axis { stroke: #333; stroke-width: 1; } .chart-title { font: bold 20px sans-serif; } </style>'

	# Add chart title
	$svg += "<text x='$([int]($width/2))' y='30' text-anchor='middle' class='chart-title'>Max. Throughput (top 10)</text>"

	# Add Y axis label
	$svg += "<text x='$([int]($marginLeft)-55)' y='$([int]($marginTop + $plotHeight/2))' text-anchor='middle' class='label' font-size='16px' transform='rotate(-90 $([int]($marginLeft)-55),$([int]($marginTop + $plotHeight/2)))'>MB/sec</text>"

	# Axes
	$svg += "<line x1='$marginLeft' y1='$marginTop' x2='$marginLeft' y2='$($height-$marginBottom)' class='axis'/>"
	$svg += "<line x1='$marginLeft' y1='$($height-$marginBottom)' x2='$($width-$marginRight)' y2='$($height-$marginBottom)' class='axis'/>"

	# Y-axis labels and grid
	$yTicks = 6
	for ($i = 0; $i -le $yTicks; $i++) {
		$yVal = [math]::Round($maxTp * ($i / $yTicks), 1)
		$y = $marginTop + $plotHeight - [math]::Round($plotHeight * ($i / $yTicks))
		$svg += "<text x='$($marginLeft-10)' y='$([int]$y+5)' text-anchor='end' class='label'>$yVal</text>"
		if ($i -ne 0 -and $i -ne $yTicks) {
			$svg += "<line x1='$marginLeft' y1='$y' x2='$($width-$marginRight)' y2='$y' stroke='#ccc' stroke-dasharray='2,2'/>"
		}
	}

	# X-axis labels (with file size)
	$n = $testFiles.Count
	for ($i = 0; $i -lt $n; $i++) {
		$x = $marginLeft + [math]::Round($plotWidth * $i / [math]::Max($n - 1, 1))
		$fileName = $testFiles[$i].Name
		$fileSizeBytes = $testFiles[$i].Length
		# Find the file size from any app's results
		
		if ($fileSizeBytes -ne $null) {
			$fileSizeMB = [math]::Round($fileSizeBytes / 1MB, 2)
			if ($fileSizeMB -eq 0) {
				$fileSizeKB = [math]::Round($fileSizeBytes / 1KB, 1)
				$sizeLabel = "$fileSizeKB KB"
			}
			else {
				$sizeLabel = "$fileSizeMB MB"
			}
		}
		else {
			$sizeLabel = ''
		}
		$svg += "<text x='$x' y='$($height-$marginBottom+20)' text-anchor='middle' class='label'>$fileName</text>"
		$svg += "<text x='$x' y='$($height-$marginBottom+36)' text-anchor='middle' class='label' font-size='11px'>$sizeLabel</text>"
	}

	# Compute average throughput per app for legend ordering
	$avgThroughput = @{}
	foreach ($app in $apps) {
		$sum = 0
		$count = 0
		foreach ($file in $testFiles) {
			$tp = $table[$app][$file.Name]
			if ($tp -ne $null) {
				$sum += $tp
				$count++
			}
		}
		$avgThroughput[$app] = if ($count -gt 0) { $sum / $count } else { 0 }
	}
	# Order apps by average throughput descending
	$appsSorted = $apps | Sort-Object { - $avgThroughput[$_] }


	$numberToDisplay = 10
	if ($appsSorted.Count -gt $numberToDisplay) {
		$appsSorted = $appsSorted[0..($numberToDisplay - 1)]
	}

	# Draw lines for each app, in sorted order
	for ($a = 0; $a -lt $appsSorted.Count; $a++) {
		$app = $appsSorted[$a]
		$color = $colors[$a % $colors.Count]
		$points = @()
		for ($i = 0; $i -lt $n; $i++) {
			$tp = $table[$app][$testFiles[$i].Name]
			$x = $marginLeft + [math]::Round($plotWidth * $i / [math]::Max($n - 1, 1))
			$y = $marginTop + $plotHeight - [math]::Round($plotHeight * $tp / $maxTp)
			$points += "$x,$y"
		}
		$svg += "<polyline fill='none' stroke='$color' stroke-width='2' points='" + ($points -join ' ') + "'/>"
		# Draw points with tooltips
		for ($i = 0; $i -lt $n; $i++) {
			$tp = $table[$app][$testFiles[$i].Name]
			$x = $marginLeft + [math]::Round($plotWidth * $i / [math]::Max($n - 1, 1))
			$y = $marginTop + $plotHeight - [math]::Round($plotHeight * $tp / $maxTp)
			$tooltip = "$app / $($testFiles[$i].Name): $tp MB/s"
			$svg += "<circle cx='$x' cy='$y' r='4' fill='$color'><title>$tooltip</title></circle>"
		}
	}

	# Legend (wrap every 5 entries), now ordered by performance
	$legendPerRow = 5
	$legendSpacingX = 160
	$legendSpacingY = 18
	for ($a = 0; $a -lt $appsSorted.Count; $a++) {
		$app = $appsSorted[$a]
		$color = $colors[$a % $colors.Count]
		$row = [math]::Floor($a / $legendPerRow)
		$col = $a % $legendPerRow
		$lx = $marginLeft + $col * $legendSpacingX
		$legendTop = 45  # space for title at y=30, then legend starts at y=45
		$ly = $legendTop + $row * $legendSpacingY
		$svg += "<rect x='$lx' y='$ly' width='18' height='10' fill='$color'/>"
		$svg += "<text x='$($lx+24)' y='$($ly+10)' class='legend'>$app</text>"
	}

	$svg += '</svg>'
	$svgContent = $svg -join "`n"
	Set-Content -Path $SvgFilePath -Value $svgContent -Encoding UTF8
	Write-Host "SVG line chart written to $SvgFilePath" -ForegroundColor Green
}

function Write-BenchmarkSVG {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Configs,

		[Parameter(Mandatory)]
		[string]$SvgFilePath
	)

	# Gather data: { TestFile => [ { AppName, Throughput } ] }
	$data = @{}
	foreach ($app in $Configs.Values) {
		foreach ($result in $app.Results.Values) {
			$file = $result.File.Name
			$tp = [math]::Round(($result.File.Length / 1MB) / ($result.Milliseconds / 1000), 2)
			if (-not $data.ContainsKey($file)) { $data[$file] = @() }
			$data[$file] += [PSCustomObject]@{
				AppName    = $app.Name
				Throughput = $tp
				FileSize   = $result.File.Length
			}
		}
	}

	# Find the largest file by size
	$largestFile = $null
	$largestSize = 0
	foreach ($file in $data.Keys) {
		$size = $data[$file][0].FileSize
		if ($size -gt $largestSize) {
			$largestSize = $size
			$largestFile = $file
		}
	}

	if (-not $largestFile) {
		Write-Host 'No files found for SVG generation.' -ForegroundColor Red
		return
	}

	# SVG layout parameters
	$barHeight = 24
	$barGap = 8
	$leftMargin = 160
	$topMargin = 40
	$barWidthMax = 400
	$colors = @('#4e79a7', '#f28e2b', '#e15759', '#76b7b2', '#59a14f', '#edc949', '#af7aa1', '#ff9da7', '#9c755f', '#bab0ab')

	# Calculate required SVG height
	$numBars = $Configs.Count
	$svgHeight = $topMargin + $numBars * ($barHeight + $barGap) + 20

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='900' height='$svgHeight' style='background-color:#fff'>"
	$svg += '<style> .label { font: 14px sans-serif; } .title { font: bold 18px sans-serif; } </style>'

	$yOffset = $topMargin
	$yOffset = $topMargin

	# Build a list of all apps, filling in throughput=0 if missing
	$allApps = @()
	foreach ($app in $Configs.Values) {
		$result = $null
		if ($data[$largestFile]) {
			$result = $data[$largestFile] | Where-Object { $_.AppName -eq $app.Name }
		}
		if ($result) {
			$allApps += [PSCustomObject]@{
				AppName    = $app.Name
				Throughput = $result.Throughput
			}
		}
		else {
			$allApps += [PSCustomObject]@{
				AppName    = $app.Name
				Throughput = 0
			}
		}
	}
	$apps = $allApps | Sort-Object -Property Throughput -Descending
	$maxTp = ($apps | Measure-Object -Property Throughput -Maximum).Maximum
	$title = '{0} ({1:N2} MB)' -f $largestFile, ($largestSize / 1MB)
	$svg += "<text x='10' y='$($yOffset-16)' class='title'>$title</text>"

	$i = 0
	foreach ($app in $apps) {
		$barLen = if ($maxTp -eq 0) { 0 } else { [math]::Round($barWidthMax * $app.Throughput / $maxTp) }
		$color = $colors[$i % $colors.Count]
		$y = $yOffset + $i * ($barHeight + $barGap)
		$svg += "<rect x='$leftMargin' y='$y' width='$barLen' height='$barHeight' fill='$color' />"
		$svg += "<text x='10' y='$([int]($y+$barHeight*0.7))' class='label'>$($app.AppName)</text>"
		$svg += "<text x='$([int]($leftMargin+$barLen+8))' y='$([int]($y+$barHeight*0.7))' class='label'>" +
            ($(if ($app.Throughput -eq 0) { 'N/A' } else { "$($app.Throughput) MB/s" })) + '</text>'
		$i++
	}

	$svg += '</svg>'
	$svgContent = $svg -join "`n"
	Set-Content -Path $SvgFilePath -Value $svgContent -Encoding UTF8
	Write-Host "SVG throughput chart written to $SvgFilePath (largest file: $largestFile)" -ForegroundColor Green
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
	$sortedApps = $global:configs.GetEnumerator() | Sort-Object { if ($_.Value.Name -like '(quick-xml)') { 0 } else { 1 } }, { $_.Value.Name }

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

		Write-Host 'Dropping caches 4 fair benchmarking... ' -ForegroundColor Magenta
		sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
		if (-Not $Quick) {
			Write-Host 'Waiting 10 seconds for caches to settle... (and let the system cool down)' -ForegroundColor Magenta
			Start-Sleep -Seconds 10
		}

		Write-Host " Benchmarking $($app.Name)..." -ForegroundColor Magenta
		foreach ($testXml in $testXmls) {

			if ($TestFileFilter -and $testXml.Name -notlike "*$TestFileFilter*") {
				Write-Host "  Skipping $($testXml.Name) due to filter." -ForegroundColor Yellow
				continue
			}

			Invoke-AppBenchmark -app $app -testXml $testXml -outFileBase $outFileBase -counter $i
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
	Write-BenchmarkResultsMarkdown -Configs $global:configs -MarkdownFilePath (Join-Path $outFileBase 'benchmark_results.md')
	Write-BenchmarkSVG -Configs $global:configs -SvgFilePath (Join-Path $outFileBase 'benchmark_tp.svg')
	Write-BenchmarkLineSVG -Configs $global:configs -SvgFilePath (Join-Path $outFileBase 'benchmark_tp_line.svg')
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
