# will be dot-sourced by xml-i.build.ps1

function SetJavaDeclObj($JavaVersion, $publicClassName) {
	$decl.Meta = [scriptblock]::Create(" & '/usr/lib/jvm/$JavaVersion-openjdk/bin/java' --version ")
	$decl.Builder = [scriptblock]::Create(" & '/usr/lib/jvm/$JavaVersion-openjdk/bin/javac' 'src/${PublicClassName}.java' -d 'bin/$JavaVersion' ")
	$decl.Tester = @{
		ArgumentList = @('-cp', "bin/$JavaVersion", '-Xms32M', '-Xmx16G', $publicClassName)
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
		ParserType  = 'StAX'
		Description = "xml-i in pure Java ($v-openjdk), using javax.xml.stream"
		Origin      = $PSScriptRoot
	}
	SetJavaDeclObj $v 'CountXMLNodes'
	New-AppDecl @decl

	$decl = @{
		Name        = "$v - SAX"
		ParserType  = 'SAX'
		Description = "xml-i in pure Java ($v-openjdk), using org.xml.sax"
		Origin      = $PSScriptRoot
	}
	SetJavaDeclObj $v 'CountXMLNodesSAX'
	New-AppDecl @decl

	$decl = @{
		Name        = "$v - Aalto XML"
		ParserType  = 'StAX'
		Description = "xml-i in pure Java ($v-openjdk), using Aalto XML"
		Origin      = $PSScriptRoot
		PreBuild    = {
			# Download Aalto XML if not already present
			$aaltoJarPath = Join-Path $PSScriptRoot 'lib/aalto-xml.jar'
			if (-not (Test-Path $aaltoJarPath)) {
				Write-Host 'Downloading Aalto XML...'
				Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/fasterxml/aalto-xml/1.3.4/aalto-xml-1.3.4.jar' -OutFile $aaltoJarPath
			}
		}
	}
	SetJavaDeclObj $v 'CountXMLNodesAalto'
	$decl.Tester.ArgumentList = @('-cp', 'lib/aalto-xml.jar') + $decl.Tester.ArgumentList
	New-AppDecl @decl
}

