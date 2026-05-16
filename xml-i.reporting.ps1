
function Get-SelectedAppNames {
	param (
		[Parameter(Mandatory)]
		[hashtable]$BenchmarkResults,

		[Parameter(Mandatory = $false)]
		[int]$TopX = 0,

		[Parameter(Mandatory = $false)]
		[string]$ReferenceImpl
	)

	$apps = @($BenchmarkResults.Values | Where-Object { $_.Name -notlike '*(noxml)*' })
	$avgThroughput = @{}
	foreach ($app in $apps) {
		$sum = 0
		$count = 0
		foreach ($result in ($app.Results.Values | Where-Object Success)) {
			$sum += ($result.File.Length / 1MB) / ($result.Milliseconds / 1000)
			$count++
		}
		$avgThroughput[$app.Name] = if ($count -gt 0) { $sum / $count } else { 0 }
	}

	$sortedAppNames = @($apps | Sort-Object { - $avgThroughput[$_.Name] } | ForEach-Object { $_.Name })

	if ($ReferenceImpl) {
		if ($sortedAppNames -notcontains $ReferenceImpl) {
			Write-Host "ReferenceImpl '$ReferenceImpl' was not found in benchmark apps. Returning full app set." -ForegroundColor Yellow
			return $sortedAppNames
		}

		$refIndex = [array]::IndexOf($sortedAppNames, $ReferenceImpl)
		$start = [math]::Max(0, $refIndex - 3)
		$end = [math]::Min($sortedAppNames.Count - 1, $refIndex + 3)
		return @($sortedAppNames[$start..$end])
	}

	if ($TopX -gt 0 -and $sortedAppNames.Count -gt $TopX) {
		return @($sortedAppNames[0..($TopX - 1)])
	}

	return $sortedAppNames
}

function Get-BenchmarkPalette {
	return @(
		'#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f',
		'#bcbd22', '#17becf', '#393b79', '#637939', '#8c6d31', '#843c39', '#7b4173', '#3182bd',
		'#31a354', '#756bb1', '#636363', '#e6550d', '#969696', '#9ecae1', '#74c476', '#fd8d3c',
		'#6baed6', '#fdbe85', '#a1d99b', '#9e9ac8', '#fdae6b', '#bcbddc', '#9edae5', '#fdd0a2',
		'#c7e9c0', '#dadaeb', '#fcbba1', '#c994c7', '#c6dbef', '#fdae6b', '#bdbdbd', '#17a2b8'
	)
}

function Get-AppColorMap {
	param (
		[Parameter(Mandatory)]
		[hashtable]$BenchmarkResults
	)

	$palette = Get-BenchmarkPalette
	$appNames = @(
		$BenchmarkResults.Values |
			Where-Object { $_.Name -notlike '*(noxml)*' } |
			ForEach-Object { $_.Name } |
			Sort-Object -Unique
	)
	$appColorMap = @{}
	for ($i = 0; $i -lt $appNames.Count; $i++) {
		$appColorMap[$appNames[$i]] = $palette[$i % $palette.Count]
	}

	return $appColorMap
}

function Write-BenchmarkResultsMarkdown {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$MarkdownFilePath,

		[Parameter(Mandatory = $false)]
		[int]$TopX = 0,

		[Parameter(Mandatory = $false)]
		[string]$ReferenceImpl
	)


	function FormatSection($app) {
		if ($app.Name -and $app.Description) {
			''
			"### $($app.Name)"
			$metaInfo = $app.MetaInfo
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
	$mdResult += "# Benchmark Results $($Results.BenchmarkDate)"
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
	$lineChartFileName = 'benchmark_tp_line.svg'
	$barChartFileName = 'benchmark_tp.svg'
	$xyChartFileName = 'benchmark_xy.svg'
	$mdResult += "![benchmark results bars]($barChartFileName)"
	$mdResult += ''
	$mdResult += "![benchmark results]($lineChartFileName)"
	$mdResult += ''
	$mdResult += "![benchmark results x/y]($xyChartFileName)"
	$mdResult += ''

	$topAppSet = @{}
	if ($TopX -gt 0 -or $ReferenceImpl) {
		$selectedAppNames = Get-SelectedAppNames -BenchmarkResults $Results.BenchmarkResults -TopX $TopX -ReferenceImpl $ReferenceImpl
		foreach ($name in $selectedAppNames) {
			$topAppSet[$name] = $true
		}
	}

	$appList = $Results.BenchmarkResults.GetEnumerator() | ForEach-Object {
		$_.Value
	}
	$appList.Results.Values | Group-Object { $_.File.Name } | Sort-Object { $_.Group[0].File.Length } -Descending | ForEach-Object {
		$group = $_
		$pos = 1
		$groupRows = @($group.Group | Where-Object Success)
		if ($TopX -gt 0 -or $ReferenceImpl) {
			$groupRows = @($groupRows | Where-Object { $topAppSet.ContainsKey($_.Me.Name) })
		}
		if ($groupRows.Count -gt 0) {
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
			$groupRows | Sort-Object -Property Milliseconds | ForEach-Object {
				$tp = $groupSize / 1MB / ($_.Milliseconds / 1000)
				$isNoXml = $_.Me.Name -like '*(noxml)*'
				$rank = if ($isNoXml) { '' } else { $pos }
				$mdResult += '| {0,-4} | {1,-25} | {3,-10:N3} | {4,-17:N3} | {5,-12:N2} |' -f $rank, $_.Me.Name, $_.File.Name, ($_.Milliseconds / 1000), $tp, $_.MaxMemMB
				if (-not $isNoXml) { $pos++ }
			}
			$mdResult += ''
		}
	}

	$mdResult += ''
	$mdResult += '## App - Results'
	$mdResult += ''

	$appResultsList = $Results.BenchmarkResults.Values | Sort-Object Name
	if ($TopX -gt 0 -or $ReferenceImpl) {
		$appResultsList = $appResultsList | Where-Object { $topAppSet.ContainsKey($_.Name) }
	}

	$appResultsList | ForEach-Object {
		$app = $_
		if ($AppFilter -and $app.Name -notlike "*$AppFilter*") {
			Write-Host "Skipping $($app.Name) due to filter." -ForegroundColor Yellow
			return
		}
		Write-Host "  formatting $($app.Name) results..."
		$mdResult += FormatSection $app
	}

	$mdResult | Out-File -FilePath $MarkdownFilePath -Encoding UTF8
	Write-Host "Benchmark results written to $MarkdownFilePath." -ForegroundColor Green
}

function Write-BenchmarkLineSVG {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$SvgFilePath,

		[Parameter(Mandatory = $false)]
		[int]$TopX = 10,

		[Parameter(Mandatory = $false)]
		[string]$ReferenceImpl
	)

	# Gather all test files and apps
	$testFiles = @()
	$apps = @()
	foreach ($app in $Results.Values) {
		if ($app.Name -notlike '*(noxml)*') {
			$apps += $app.Name
		}
		foreach ($result in $app.Results.Values) {
			if ($testFiles.Name -notcontains $result.File.Name) {
				$testFiles += $result.File
			}
		}
	}
	$testFiles = $testFiles | Sort-Object { $_.Length } -Descending
	$apps = $apps | Sort-Object

	# Build throughput table: $table[app][file] = throughput
	$table = @{}
	foreach ($app in $Results.Values) {
		if ($app.Name -like '*(noxml)*') { continue }
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

	$appColorMap = Get-AppColorMap -BenchmarkResults $Results

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='$width' height='$height' style='background-color:#fff'>"
	$svg += '<style> .label { font: 13px sans-serif; } .legend { font: 13px sans-serif; } .axis { stroke: #333; stroke-width: 1; } .chart-title { font: bold 20px sans-serif; } </style>'

	$selectedApps = @(Get-SelectedAppNames -BenchmarkResults $Results -TopX $TopX -ReferenceImpl $ReferenceImpl)
	$selectedAppSet = @{}
	foreach ($name in $selectedApps) {
		$selectedAppSet[$name] = $true
	}
	$appsSorted = @($selectedApps | Where-Object { $table.ContainsKey($_) })
	$numberToDisplay = $appsSorted.Count
	if ($numberToDisplay -eq 0) {
		Write-Host 'No apps found for line chart generation.' -ForegroundColor Red
		return
	}

	# Find max throughput for scaling, based only on displayed apps.
	$displayedThroughputs = @()
	foreach ($app in $appsSorted) {
		$displayedThroughputs += @($table[$app].Values)
	}
	$maxTp = ($displayedThroughputs | Measure-Object -Maximum).Maximum
	if (-not $maxTp) { $maxTp = 1 }

	$titleDetail = if ($ReferenceImpl) { "around $ReferenceImpl (+/-3)" } else { "top $numberToDisplay" }

	# Add chart title
	$svg += "<text x='$([int]($width/2))' y='30' text-anchor='middle' class='chart-title'>Max. Throughput ($titleDetail)</text>"

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
		Write-Host " ($fileName - $fileSizeBytes)"
		
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

	# Draw lines for each app, in sorted order
	for ($a = 0; $a -lt $appsSorted.Count; $a++) {
		$app = $appsSorted[$a]
		$color = if ($appColorMap.ContainsKey($app)) { $appColorMap[$app] } else { '#666666' }
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
		$color = if ($appColorMap.ContainsKey($app)) { $appColorMap[$app] } else { '#666666' }
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
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$SvgFilePath,

		[Parameter(Mandatory = $false)]
		[int]$TopX = 0,

		[Parameter(Mandatory = $false)]
		[string]$ReferenceImpl
	)

	# Gather data: { TestFile => [ { AppName, Throughput } ] }
	$data = @{}
	foreach ($app in $Results.Values) {
		if ($app.Name -like '*(noxml)*') { continue }
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

	$selectedAppNames = @()
	if ($ReferenceImpl) {
		# For benchmark_tp, ranking context is the largest file used by this chart.
		$appsByLargestFileTp = @()
		foreach ($app in $Results.Values) {
			if ($app.Name -like '*(noxml)*') { continue }
			$result = $app.Results[$largestFile]
			$tp = if ($result) { [math]::Round(($result.File.Length / 1MB) / ($result.Milliseconds / 1000), 2) } else { 0 }
			$appsByLargestFileTp += [PSCustomObject]@{
				Name       = $app.Name
				Throughput = $tp
			}
		}

		$rankedNames = @($appsByLargestFileTp | Sort-Object -Property Throughput -Descending | ForEach-Object { $_.Name })
		if ($rankedNames -contains $ReferenceImpl) {
			$refIndex = [array]::IndexOf($rankedNames, $ReferenceImpl)
			$start = [math]::Max(0, $refIndex - 3)
			$end = [math]::Min($rankedNames.Count - 1, $refIndex + 3)
			$selectedAppNames = @($rankedNames[$start..$end])
		}
		else {
			Write-Host "ReferenceImpl '$ReferenceImpl' was not found in benchmark_tp ranking. Falling back to default selection." -ForegroundColor Yellow
			$selectedAppNames = @(Get-SelectedAppNames -BenchmarkResults $Results -TopX $TopX -ReferenceImpl $null)
		}
	}
	else {
		$selectedAppNames = @(Get-SelectedAppNames -BenchmarkResults $Results -TopX $TopX -ReferenceImpl $null)
	}

	$selectedAppSet = @{}
	foreach ($name in $selectedAppNames) {
		$selectedAppSet[$name] = $true
	}

	# SVG layout parameters
	$barHeight = 24
	$barGap = 8
	$leftMargin = 160
	$topMargin = 40
	$barWidthMax = 400
	$appColorMap = Get-AppColorMap -BenchmarkResults $Results

	# Calculate required SVG height
	$numBars = [math]::Max(1, $selectedAppNames.Count)
	$svgHeight = $topMargin + $numBars * ($barHeight + $barGap) + 20

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='900' height='$svgHeight' style='background-color:#fff'>"
	$svg += '<style> .label { font: 14px sans-serif; } .title { font: bold 18px sans-serif; } </style>'

	$yOffset = $topMargin
	$yOffset = $topMargin

	# Build a list of all apps, filling in throughput=0 if missing
	$allApps = @()
	foreach ($appName in $selectedAppNames) {
		$app = $Results[$appName]
		if (-not $app) { continue }
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
	if ($ReferenceImpl -or $TopX -gt 0) {
		# Keep the selection/ranking order from Get-SelectedAppNames for filtered reports.
		$apps = $allApps | Sort-Object { [array]::IndexOf($selectedAppNames, $_.AppName) }
	}
	else {
		$apps = $allApps | Sort-Object -Property Throughput -Descending
	}
	if ($apps.Count -eq 0) {
		Write-Host 'No apps found for throughput SVG generation.' -ForegroundColor Red
		return
	}
	$maxTp = ($apps | Measure-Object -Property Throughput -Maximum).Maximum
	if (-not $maxTp) { $maxTp = 1 }
	$title = '{0} ({1:N2} MB)' -f $largestFile, ($largestSize / 1MB)
	$svg += "<text x='10' y='$($yOffset-16)' class='title'>$title</text>"

	$i = 0
	foreach ($app in $apps) {
		$barLen = if ($maxTp -eq 0) { 0 } else { [math]::Round($barWidthMax * $app.Throughput / $maxTp) }
		$color = if ($appColorMap.ContainsKey($app.AppName)) { $appColorMap[$app.AppName] } else { '#666666' }
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

function Write-BenchmarkXYSVG {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$SvgFilePath,

		[Parameter(Mandatory = $false)]
		[int]$TopX = 0,

		[Parameter(Mandatory = $false)]
		[string]$ReferenceImpl
	)

	# Gather all test files and apps
	$testFiles = @()
	$apps = @()
	foreach ($app in $Results.Values) {
		if ($app.Name -notlike '*(noxml)*') {
			$apps += $app.Name
		}
		foreach ($result in $app.Results.Values) {
			if ($testFiles.Name -notcontains $result.File.Name) {
				$testFiles += $result.File
			}
		}
	}
	$testFiles = $testFiles | Sort-Object { $_.Length }
	$apps = $apps | Sort-Object

	# Find the largest file
	$largestFile = $testFiles | Sort-Object Length -Descending | Select-Object -First 1
	if (-not $largestFile) {
		Write-Host 'No files found for SVG generation.' -ForegroundColor Red
		return
	}

	# Build table: $table[app] = @{ MaxMemMB = ..., Seconds = ... }
	$table = @{}
	$maxMem = 1
	$minMem = $null
	$maxTime = 1
	foreach ($app in $Results.Values) {
		if ($app.Name -like '*(noxml)*') { continue }
		$result = $app.Results[$largestFile.Name]
		if ($result) {
			$mem = [math]::Round($result.MaxMemMB, 2)
			$seconds = [math]::Round($result.Milliseconds / 1000, 3)
			$table[$app.Name] = @{ MaxMemMB = $mem; Seconds = $seconds }
			if ($mem -gt $maxMem) { $maxMem = $mem }
			if ($mem -lt $minMem -or $minMem -eq $null) { $minMem = $mem }
			if ($seconds -gt $maxTime) { $maxTime = $seconds }
		}
	}
	if ($minMem -le 0) { $minMem = 0.1 } # avoid log(0)

	# Order apps by time (fastest to slowest)
	$apps = $apps | Sort-Object { $table[$_].Seconds }

	# SVG layout
	$width = 900
	$marginLeft = 100
	$marginBottom = 60
	$marginRight = 40
	$legendPerRow = 5
	$legendSpacingX = 160
	$legendSpacingY = 22
	$legendTopPad = 45
	$plotWidth = $width - $marginLeft - $marginRight
	$plotHeight = 400
	$plotTop = 0
	$height = 0

	$appColorMap = Get-AppColorMap -BenchmarkResults $Results

	# Log scale helpers
	$logMinMem = [math]::Log10($minMem)
	$logMaxMem = [math]::Log10($maxMem)
	function GetLogX($mem) {
		if ($mem -le 0) { $mem = $minMem }
		$logMem = [math]::Log10($mem)
		if ($logMaxMem -eq $logMinMem) {
			return $marginLeft + [math]::Round($plotWidth / 2)
		}
		return $marginLeft + [math]::Round($plotWidth * ($logMem - $logMinMem) / ($logMaxMem - $logMinMem))
	}

	# Calculate geometric distances from (0,0) for each point
	$distances = @()
	foreach ($app in $apps) {
		if ($table.ContainsKey($app)) {
			$mem = $table[$app].MaxMemMB
			$seconds = $table[$app].Seconds
			$x = GetLogX $mem
			$y = $plotTop + $plotHeight - [math]::Round($plotHeight * $seconds / $maxTime)
			# Distance from (marginLeft, plotTop + plotHeight) == (0,0) in plot coordinates
			$dx = $x - $marginLeft
			$dy = ($y - ($plotTop + $plotHeight))
			$dist = [math]::Sqrt($dx * $dx + $dy * $dy)
			$distances += [PSCustomObject]@{ App = $app; Distance = $dist }
		}
	}
	$selectedApps = @(Get-SelectedAppNames -BenchmarkResults $Results -TopX $TopX -ReferenceImpl $ReferenceImpl)
	$selectedAppSet = @{}
	foreach ($name in $selectedApps) {
		$selectedAppSet[$name] = $true
	}
	$distances = @($distances | Where-Object { $selectedAppSet.ContainsKey($_.App) })

	# Order by distance, assign numbers
	$distances = $distances | Sort-Object Distance
	$numberToDisplay = $distances.Count
	$appNumbers = @{}
	for ($i = 0; $i -lt $distances.Count; $i++) {
		$appNumbers[$distances[$i].App] = $i + 1
	}

	# --- ORDER LEGEND BY DISTANCE ---
	$legendApps = $distances | Sort-Object { $_.Distance } | ForEach-Object { $_.App }
	if ($legendApps.Count -eq 0) {
		Write-Host 'No apps found for XY chart generation.' -ForegroundColor Red
		return
	}

	# Recompute axis scaling and layout based only on displayed apps.
	$selectedApps = @($legendApps)
	$selectedMemValues = @($selectedApps | ForEach-Object { $table[$_].MaxMemMB })
	$selectedTimeValues = @($selectedApps | ForEach-Object { $table[$_].Seconds })
	$maxMem = ($selectedMemValues | Measure-Object -Maximum).Maximum
	$minMem = ($selectedMemValues | Measure-Object -Minimum).Minimum
	$maxTime = ($selectedTimeValues | Measure-Object -Maximum).Maximum
	if (-not $maxMem) { $maxMem = 1 }
	if ($null -eq $minMem -or $minMem -le 0) { $minMem = 0.1 }
	if (-not $maxTime) { $maxTime = 1 }
	$logMinMem = [math]::Log10($minMem)
	$logMaxMem = [math]::Log10($maxMem)

	$legendRows = [math]::Ceiling($legendApps.Count / $legendPerRow)
	$legendHeight = $legendRows * $legendSpacingY + $legendTopPad
	$plotTop = $legendHeight + 10
	$height = $plotTop + $plotHeight + $marginBottom

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='$width' height='$height' style='background-color:#fff'>"
	$svg += '<style> .label { font: 13px sans-serif; } .legend { font: 13px sans-serif; } .axis { stroke: #333; stroke-width: 1; } .chart-title { font: bold 20px sans-serif; } .pointnum { font: bold 14px sans-serif; fill: #222; } </style>'

	$fileTitle = '{0} - {1:N2}GB' -f $largestFile.Name, ($largestFile.Length / 1GB) 
	$topLabel = if ($ReferenceImpl) { " around $ReferenceImpl (+/-3)" } elseif ($TopX -gt 0) { " top $numberToDisplay" } else { '' }
	# Add chart title
	$svg += "<text x='$([int]($width/2))' y='30' text-anchor='middle' class='chart-title'>Time vs. Max Memory$topLabel ($fileTitle)</text>"

	# Legend above the chart, wrap every 5 entries, ordered by distance
	for ($a = 0; $a -lt $legendApps.Count; $a++) {
		$app = $legendApps[$a]
		$color = if ($appColorMap.ContainsKey($app)) { $appColorMap[$app] } else { '#666666' }
		$row = [math]::Floor($a / $legendPerRow)
		$col = $a % $legendPerRow
		$lx = $marginLeft + $col * $legendSpacingX
		$ly = $legendTopPad + $row * $legendSpacingY
		$num = $appNumbers[$app]
		$svg += "<rect x='$lx' y='$ly' width='18' height='12' fill='$color'/>"
		$svg += "<text x='$($lx+24)' y='$($ly+11)' class='legend'>${num}: $app</text>"
	}

	# Add Y axis label
	$svg += "<text x='$([int]($marginLeft)-55)' y='$([int]($plotTop + $plotHeight/2))' text-anchor='middle' class='label' font-size='16px' transform='rotate(-90 $([int]($marginLeft)-55),$([int]($plotTop + $plotHeight/2)))'>Time (s)</text>"

	# Add X axis label
	$svg += "<text x='$([int]($marginLeft + $plotWidth/2))' y='$($height-10)' text-anchor='middle' class='label' font-size='16px'>Max Memory (MB, log scale)</text>"

	# Axes
	$svg += "<line x1='$marginLeft' y1='$plotTop' x2='$marginLeft' y2='$($plotTop+$plotHeight)' class='axis'/>"
	$svg += "<line x1='$marginLeft' y1='$($plotTop+$plotHeight)' x2='$($marginLeft+$plotWidth)' y2='$($plotTop+$plotHeight)' class='axis'/>"

	# Y-axis labels and grid
	$yTicks = 6
	for ($i = 0; $i -le $yTicks; $i++) {
		$yVal = [math]::Round($maxTime * ($i / $yTicks), 2)
		$y = $plotTop + $plotHeight - [math]::Round($plotHeight * ($i / $yTicks))
		$svg += "<text x='$($marginLeft-10)' y='$([int]$y+5)' text-anchor='end' class='label'>$yVal</text>"
		if ($i -ne 0 -and $i -ne $yTicks) {
			$svg += "<line x1='$marginLeft' y1='$y' x2='$($marginLeft+$plotWidth)' y2='$y' stroke='#ccc' stroke-dasharray='2,2'/>"
		}
	}

	# X-axis labels and grid (log scale)
	$xTicks = 8
	for ($i = 0; $i -le $xTicks; $i++) {
		$logVal = $logMinMem + ($logMaxMem - $logMinMem) * ($i / $xTicks)
		$memVal = [math]::Pow(10, $logVal)
		$x = GetLogX $memVal
		$label = if ($memVal -ge 1) { [math]::Round($memVal, 1) } else { '{0:0.2f}' -f $memVal }
		$svg += "<text x='$x' y='$($plotTop+$plotHeight+20)' text-anchor='middle' class='label'>$label</text>"
		if ($i -ne 0 -and $i -ne $xTicks) {
			$svg += "<line x1='$x' y1='$plotTop' x2='$x' y2='$($plotTop+$plotHeight)' stroke='#ccc' stroke-dasharray='2,2'/>"
		}
	}

	# Draw one dot per app for the largest file, and add number
	$ellipsePoints = @()
	for ($a = 0; $a -lt $legendApps.Count; $a++) {
		$app = $legendApps[$a]
		if ($table.ContainsKey($app)) {
			$color = if ($appColorMap.ContainsKey($app)) { $appColorMap[$app] } else { '#666666' }
			$mem = $table[$app].MaxMemMB
			$seconds = $table[$app].Seconds
			$x = GetLogX $mem
			$y = $plotTop + $plotHeight - [math]::Round($plotHeight * $seconds / $maxTime)

			$tooltip = '"{0}" - Test "{1}" : {2:N2} GB in {3:N2} seconds using {4:N2} MB RAM' -f $app, $largestFile.Name, ($largestFile.Length / 1GB), $seconds, $mem
			$num = $appNumbers[$app]
			$svg += "<circle cx='$x' cy='$y' r='8' fill='$color'><title>$tooltip</title></circle>"
			# Number to the right of the point
			$svg += "<text x='$($x+13)' y='$($y+5)' class='pointnum'>$num</text>"

			# Collect coordinates for points 1,2,3
			if ($num -le 3) {
				$ellipsePoints += @{ x = $x; y = $y }
			}
		}
	}

	<#
	# Draw a single green ellipse around points 1,2,3 if all are present
	if ($ellipsePoints.Count -eq 3) {
		# Calculate bounding box
		$minX = ($ellipsePoints | Measure-Object x -Minimum).Minimum
		$maxX = ($ellipsePoints | Measure-Object x -Maximum).Maximum
		$minY = ($ellipsePoints | Measure-Object y -Minimum).Minimum
		$maxY = ($ellipsePoints | Measure-Object y -Maximum).Maximum
		$cx = [math]::Round(($minX + $maxX) / 2)
		$cy = [math]::Round(($minY + $maxY) / 2)
		$rx = [math]::Round(($maxX - $minX) / 2 + 22) # add padding
		$ry = [math]::Round(($maxY - $minY) / 2 + 22) # add padding
		$svg += "<ellipse cx='$cx' cy='$cy' rx='$rx' ry='$ry' fill='none' stroke='green' stroke-width='3'/>"
	}
	#>

	$svg += '</svg>'
	$svgContent = $svg -join "`n"
	Set-Content -Path $SvgFilePath -Value $svgContent -Encoding UTF8
	Write-Host "SVG XY chart written to $SvgFilePath (log X, seconds, numbered, legend above, wrap 5, ordered by distance)" -ForegroundColor Green
}
