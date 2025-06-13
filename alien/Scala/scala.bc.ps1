
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Scala' 
	Description = 'xml-i in Scala'
	ParserType  = 'SAX'
	Origin      = $PSScriptRoot
	Meta        = {	scala -version }
	Builder     = {	
		scala --power package --assembly 'src/CountXmlNodes.scala' --force
	}
	Tester      = @{
		Executable   = './CountXMLNodes'
		ArgumentList = @()
	}
}
New-AppDecl @decl
