# will be dot-sourced by xml-i.build.ps1

function SetJavaDeclObj($JavaVersion, $publicClassName) {
	$decl.Meta = [scriptblock]::Create(" & '/usr/lib/jvm/$JavaVersion-openjdk/bin/java' --version ")
	$decl.Builder = [scriptblock]::Create(" & '/usr/lib/jvm/$JavaVersion-openjdk/bin/javac' 'src/${PublicClassName}.java' -d 'bin/$JavaVersion' ")
	$decl.Tester = @{
		ArgumentList = @('-cp', "bin/$JavaVersion", $publicClassName)
		Executable   = "/usr/lib/jvm/$JavaVersion-openjdk/bin/java"
	}
}

$javaVersions = @(
	# 'java-11'
	'java-21'
	# 'java-24'
)
$javaversions | ForEach-Object {
	$v = $_
	$decl = @{
		Name        = "$v - StAX"
		Description = "xml-i in pure Java ($v-openjdk), using javax.xml.stream"
		Origin      = $PSScriptRoot
	}
	SetJavaDeclObj $v 'CountXMLNodes'
	New-AppDecl @decl

	$decl = @{
		Name        = "$v - SAX"
		Description = "xml-i in pure Java ($v-openjdk), using org.xml.sax"
		Origin      = $PSScriptRoot
	}
	SetJavaDeclObj $v 'CountXMLNodesSAX'
	New-AppDecl @decl
}

