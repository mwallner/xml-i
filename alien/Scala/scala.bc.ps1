
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Scala' 
	Description = 'xml-i in Scala'
	Origin      = $PSScriptRoot
	Meta        = {	scala -version }
	Builder     = {	scalac 'src/CountXmlNodes.scala'	}
	Tester      = @{
		Executable   = 'scala'
		ArgumentList = @(
			'src/CountXmlNodes.scala', '--'
		)
	}
}
New-AppDecl @decl
