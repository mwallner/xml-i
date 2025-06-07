
# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = '.NET' 
	Description = 'xml-i in .NET'
	Origin      = $PSScriptRoot
	Meta        = {	dotnet --version }
	Builder     = {	
		& dotnet publish 'src' -c Release -o '../bin/dotnet'
	}
	Tester      = @{
		Executable   = '../bin/dotnet/xml-i-dotnet'
		ArgumentList = @() 
 }
}
New-AppDecl @decl
