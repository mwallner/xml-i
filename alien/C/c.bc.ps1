
# will be dot-sourced by xml-i.build.ps1

$global:CXX = 'gcc'
$global:CXXFLAGS = @('-O3', '-Wall', '-DNDEBUG')

$decl_plain = @{
	Name        = 'C (noxml)' 
	Description = 'xml-i in pure C, without xml library'
	ParserType  = 'text'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CXX @($CXXFLAGS) -o '../bin/xml-i-c-plain' 'src_plain/CountXmlNodes.c'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-c-plain'
		ArgumentList = @()
	}
}
New-AppDecl @decl_plain
