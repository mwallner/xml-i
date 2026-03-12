
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = '.NET 10 - XmlReader' 
	Description = 'xml-i in .NET'
	ParserType  = 'StAX'
	Origin      = $PSScriptRoot
	Meta        = {	dotnet --version }
	Builder     = {    
		Push-Location 'src'
		try {
			& dotnet publish -c Release
			Copy-Item -Path 'bin/Release/net10.0/publish/xml-i-dotnet' -Destination '../../bin/dotnet/xml-i-dotnet' -Force
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = '../bin/dotnet/xml-i-dotnet'
		ArgumentList = @() 
 }
}
New-AppDecl @decl
