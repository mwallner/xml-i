
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Node.js' 
	Description = 'xml-i in Node.js'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	node --version }
	Builder     = {	
		Push-Location 'src'
		try {	npm ci	}
		finally {	Pop-Location	}
	}
	Tester      = @{
		Executable   = 'node'
		ArgumentList = @(
			'src/CountXmlNodes.js'
		)
	}
}
New-AppDecl @decl
