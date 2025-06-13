
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Rust (xml-rs)' 
	Description = 'xml-i in Rust with xml-rs'
	ParserType  = 'DOM'
	Origin      = $PSScriptRoot
	Meta        = {	cargo --version }
	Builder     = {	
		Push-Location 'xml-rs'
		try {
			cargo build --release
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = 'xml-rs/target/release/xml-i-xml-rs'
		ArgumentList = @()
	}
}
New-AppDecl @decl
