
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

	$outFileName = Join-Path $outFileBase "tmp/$($app.Name)-$counter.out"
	$app.OutFiles += $outFileName
	Push-Location $app.Origin
	try {
		$appArgs = $app.Tester.ArgumentList
		$appArgs += $testXml
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
		$app.Results[$testXml] = @{
			Milliseconds = $testrun.TotalMilliseconds
			MaxMemMB     = $maxMem
			Output       = $result
		}
		Write-Host (' ... ok ({0:N2} sec)' -f $testrun.TotalSeconds) -ForegroundColor Green
	}
	catch {
		Write-Host " Error benchmarking $($app.Name): $_ / $testXml" -ForegroundColor Red
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
	$testXmls = Get-ChildItem 'test' -Filter '*.xml' | Where-Object { $_.Length -gt 0 } | Select-Object -ExpandProperty FullName
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
}
