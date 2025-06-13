
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Saxon HE 12' 
	Description = 'xml-i in xslt powered by Saxon HE 12'
	ParserType  = 'XSLT'
	Origin      = $PSScriptRoot
	Meta        = {	'SaxonHE12-7J.zip' }
	Builder     = {

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
	Tester      = @{
		Executable   = 'java'
		ArgumentList = @(
			'-Xms32M', '-Xmx16G', '-jar', './saxon/saxon-he-12.7.jar', '-xsl:src/CountXmlNodes.xsl'
		)
	}
}
New-AppDecl @decl
