
# will be dot-sourced by xml-i.build.ps1

# .NET 10 build declaration
$decl10 = @{
	Name        = '.NET 10 - XmlReader'
	Description = 'xml-i in .NET 10'
	ParserType  = 'StAX'
	Origin      = $PSScriptRoot
	Meta        = { dotnet --version }
	Builder     = {
		Push-Location 'src'
		try {
			& dotnet publish -c Release 'xml-i-dotnet-10.csproj'
			Copy-Item -Path 'bin/Release/net10.0/publish/xml-i-dotnet' -Destination '../../bin/dotnet/xml-i-dotnet-10' -Force
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = '../bin/dotnet/xml-i-dotnet-10'
		ArgumentList = @()
	}
}
New-AppDecl @decl10

# .NET 8 build declaration
$decl8 = @{
	Name        = '.NET 8 - XmlReader'
	Description = 'xml-i in .NET 8'
	ParserType  = 'StAX'
	Origin      = $PSScriptRoot
	Meta        = { dotnet --version }
	Builder     = {
		Push-Location 'src'
		try {
			& dotnet publish -c Release 'xml-i-dotnet-8.csproj'
			Copy-Item -Path 'bin/Release/net8.0/xml-i-dotnet' -Destination '../../bin/dotnet/xml-i-dotnet-8' -Force
		}
		finally {
			Pop-Location
		}
	}
	Tester      = @{
		Executable   = '../bin/dotnet/xml-i-dotnet-8'
		ArgumentList = @()
	}
}
New-AppDecl @decl8
