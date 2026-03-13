# will be dot-sourced by xml-i.build.ps1

$decl = @{
	Name        = 'Lua'
	Description = 'xml-i in Lua (LuaExpat)'
	ParserType  = 'Expat'
	Origin      = $PSScriptRoot
	Meta        = { lua -v }
	Builder     = { }
	Tester      = @{
		Executable   = 'lua'
		ArgumentList = @(
			'src/CountXmlNodes.lua'
		)
	}
	PreBuild    = {
		# Check for LuaExpat (lxp) availability; do not auto-install.
		$check = & lua -e "local ok = pcall(require, 'lxp'); if not ok then os.exit(2) end"
		if ($LASTEXITCODE -ne 0) {
			Write-Host 'Warning: LuaExpat (lxp) not found. Please install LuaExpat for the Lua implementation to run.'
		}
	}
}
New-AppDecl @decl
