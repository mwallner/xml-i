
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Go - std' 
	Description = 'xml-i in Go (using standard library encoding/xml)'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	go version }
	Builder     = {	
		go build -ldflags='-s -w' -trimpath -o '../bin/xml-i-go' 'src-std/CountXmlNodes.go'
	}
	Tester      = @{
		Executable   = '../bin/xml-i-go'
		ArgumentList = @() 
 }
}
New-AppDecl @decl

$decl = @{
	Name        = 'Go - xmlquery' 
	Description = 'xml-i in Go (using antchfx/xmlquery)'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	go version }
	Builder     = {	
		Push-Location 'src-xmlquery'
		try {
			go build -ldflags='-s -w' -trimpath -o '../../bin/xml-i-go-xmlquery' 'CountXmlNodes-XmlQuery.go'
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-go-xmlquery'
		ArgumentList = @() 
 }
}
New-AppDecl @decl
