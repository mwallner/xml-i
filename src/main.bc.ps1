
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Rust (quick-xml)' 
	Description = 'xml-i in Rust with quick-xml'
	ParserType  = 'StAX'
	Origin      = $PSScriptRoot
	Meta        = {	cargo --version }
	Builder     = {	
		Push-Location '..'
		try {
			cargo build --release
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = '../target/release/xml-i'
		ArgumentList = @()
	}
}
New-AppDecl @decl
