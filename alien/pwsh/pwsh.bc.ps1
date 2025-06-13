
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'PowerShell Core' 
	Description = 'xml-i in pwsh'
	ParserType  = 'SAX'
	Origin      = $PSScriptRoot
	Meta        = {	$PSVersionTable |
		Select-Object PSVersion, PSEdition, BuildVersion, CLRVersion, OS }
	Builder     = { }
	Tester      = @{
		Executable   = 'pwsh'
		ArgumentList = @(
			'-NoProfile',
			'-ExecutionPolicy', 'Bypass',
			'-NoLogo',
			'-File', 'src/CountXmlNodes.ps1',
			'-XmlFilePath'
		)
	}
}
New-AppDecl @decl
