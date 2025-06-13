
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Python 3' 
	Description = 'xml-i in Python 3'
	ParserType  = 'SAX'
	Origin      = $PSScriptRoot
	Meta        = {	python3 --version }
	Builder     = { }
	Tester      = @{
		Executable   = 'python3'
		ArgumentList = @(
			'src/CountXmlNodes.py'
		)
	}
}
New-AppDecl @decl
