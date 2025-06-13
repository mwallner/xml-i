
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Julia (LightXML)' 
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
		ArgumentList = @( 'src/CountXmlNodes.jl' )
	}
}
New-AppDecl @decl
