# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Perl' 
	Description = 'xml-i in Perl'
	ParserType  = 'Expat'
	Origin      = $PSScriptRoot
	Meta        = { perl -v }
	Builder     = { }
	Tester      = @{
		Executable   = 'perl'
		ArgumentList = @(
			'src/CountXmlNodes.pl'
		)
	}
	PreBuild    = {
		# Ensure XML::Parser is installed
		if (-not (perl -MXML::Parser -e 'print "XML::Parser is installed\n"')) {
			Write-Host 'Installing XML::Parser module...'
			cpan XML::Parser
		}
	}
}
New-AppDecl @decl
