
function Write-BenchmarkResultsMarkdown {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$MarkdownFilePath
	)


	function FormatSection($app) {
		if ($app.Name -And $app.Description) {
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
	$mdResult += '![benchmark results](benchmark_tp_line.svg)'
	$mdResult += ''
	$mdResult += '![benchmark results x/y](benchmark_xy.svg)'
	$mdResult += ''

	$appList = $Results.BenchmarkResults.GetEnumerator() | ForEach-Object {
		$_.Value
	}
	$appList.Results.Values | Group-Object { $_.File.Name } | Sort-Object { $_.Group[0].File.Length } -Descending | ForEach-Object {
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

	$Results.BenchmarkResults.Values | Sort-Object Name | ForEach-Object {
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
		[string]$SvgFilePath
	)

	# Gather all test files and apps
	$testFiles = @()
	$apps = @()
	foreach ($app in $Results.Values) {
		$apps += $app.Name
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
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$SvgFilePath
	)

	# Gather data: { TestFile => [ { AppName, Throughput } ] }
	$data = @{}
	foreach ($app in $Results.Values) {
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
	$numBars = $Results.Count
	$svgHeight = $topMargin + $numBars * ($barHeight + $barGap) + 20

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='900' height='$svgHeight' style='background-color:#fff'>"
	$svg += '<style> .label { font: 14px sans-serif; } .title { font: bold 18px sans-serif; } </style>'

	$yOffset = $topMargin
	$yOffset = $topMargin

	# Build a list of all apps, filling in throughput=0 if missing
	$allApps = @()
	foreach ($app in $Results.Values) {
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

function Write-BenchmarkXYSVG {
	param (
		[Parameter(Mandatory)]
		[hashtable]$Results,

		[Parameter(Mandatory)]
		[string]$SvgFilePath
	)

	# Gather all test files and apps
	$testFiles = @()
	$apps = @()
	foreach ($app in $Results.Values) {
		$apps += $app.Name
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
	$legendRows = [math]::Ceiling($apps.Count / $legendPerRow)
	$legendHeight = $legendRows * $legendSpacingY + $legendTopPad
	$plotTop = $legendHeight + 10
	$plotWidth = $width - $marginLeft - $marginRight
	$plotHeight = 400
	$height = $plotTop + $plotHeight + $marginBottom

	# Colors for dots
	$colors = @('#4e79a7', '#f28e2b', '#e15759', '#76b7b2', '#59a14f', '#edc949', '#af7aa1', '#ff9da7', '#9c755f', '#bab0ab')

	# Log scale helpers
	$logMinMem = [math]::Log10($minMem)
	$logMaxMem = [math]::Log10($maxMem)
	function GetLogX($mem) {
		if ($mem -le 0) { $mem = $minMem }
		$logMem = [math]::Log10($mem)
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
	# Order by distance, assign numbers
	$distances = $distances | Sort-Object Distance
	$appNumbers = @{}
	for ($i = 0; $i -lt $distances.Count; $i++) {
		$appNumbers[$distances[$i].App] = $i + 1
	}

	# --- ORDER LEGEND BY DISTANCE ---
	$legendApps = $distances | Sort-Object { $_.Distance } | ForEach-Object { $_.App }

	$svg = @()
	$svg += '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
	$svg += "<svg xmlns='http://www.w3.org/2000/svg' width='$width' height='$height' style='background-color:#fff'>"
	$svg += '<style> .label { font: 13px sans-serif; } .legend { font: 13px sans-serif; } .axis { stroke: #333; stroke-width: 1; } .chart-title { font: bold 20px sans-serif; } .pointnum { font: bold 14px sans-serif; fill: #222; } </style>'

	$fileTitle = '{0} - {1:N2}GB' -f $largestFile.Name, ($largestFile.Length / 1GB) 
	# Add chart title
	$svg += "<text x='$([int]($width/2))' y='30' text-anchor='middle' class='chart-title'>Time vs. Max Memory ($fileTitle)</text>"

	# Legend above the chart, wrap every 5 entries, ordered by distance
	for ($a = 0; $a -lt $legendApps.Count; $a++) {
		$app = $legendApps[$a]
		$color = $colors[$a % $colors.Count]
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
	for ($a = 0; $a -lt $apps.Count; $a++) {
		$app = $apps[$a]
		if ($table.ContainsKey($app)) {
			# Use the same color index as in the legend
			$legendIdx = ($legendApps.IndexOf($app))
			$color = $colors[$legendIdx % $colors.Count]
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
