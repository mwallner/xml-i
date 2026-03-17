
# will be dot-sourced by xml-i.build.ps1

$global:CC = 'gcc'
$global:CFLAGS = @('-O3', '-Wall', '-DNDEBUG')

$decl_plain = @{
	Name        = 'C (noxml)' 
	Description = 'xml-i in pure C, without xml library'
	ParserType  = 'text'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CC @($CFLAGS) -o '../bin/xml-i-c-plain' 'src_plain/CountXmlNodes.c'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-c-plain'
		ArgumentList = @()
	}
}
New-AppDecl @decl_plain

$decl_plain = @{
	Name        = 'C scanfile (noxml)' 
	Description = 'scan file with pure C, without xml library'
	ParserType  = 'text'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CC @($CFLAGS) -o '../bin/xml-i-c-scanfile' 'src_plain/ScanFile.c'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-c-scanfile'
		ArgumentList = @()
	}
}
New-AppDecl @decl_plain
