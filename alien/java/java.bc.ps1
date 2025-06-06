
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Java' 
	Description = 'xml-i in pure Java'
	Origin      = $PSScriptRoot
	Meta        = {	java --version }
	Builder     = {	javac 'src/CountXMLNodes.java'	}
	Tester      = @{
		Executable   = 'java'
		ArgumentList = @(
			'-cp', 'src',
			'CountXMLNodes'
		)
	}
}
New-AppDecl @decl
