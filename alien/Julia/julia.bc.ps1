
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Julia - LightXML' 
	Description = 'xml-i in Julia with LightXML'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	julia --version }
	Builder     = {	
		Exec {
			julia -e 'using Pkg; Pkg.add("LightXML")'
		}
	}
	Tester      = @{
		Executable   = 'julia'
		ArgumentList = @( 'LightXML/CountXmlNodes.jl' )
	}
}
New-AppDecl @decl

$decl = @{
	Name        = 'Julia - XML' 
	Description = 'xml-i in Julia with XML'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	julia --version }
	Builder     = {	
		Exec {
			julia -e 'using Pkg; Pkg.add("XML")'
		}
	}
	Tester      = @{
		Executable   = 'julia'
		ArgumentList = @( 'XML/CountXmlNodes.jl' )
	}
}
New-AppDecl @decl