
# will be dot-sourced by xml-i.build.ps1

$global:CXX = 'g++'
$global:CXXFLAGS = @('-std=c++20', '-O3', '-Wall', '-Wextra', '-pedantic', '-DNDEBUG')

$decl_rapid = @{
	Name        = 'C++ (rapidxml)' 
	Description = 'xml-i in C++ powered by rapidxml'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CXX @($CXXFLAGS) '-I./rapidxml/RapidXML' -o '../bin/xml-i-rapidxml' 'src/main_rapidxml.cpp'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-rapidxml'
		ArgumentList = @()
	}
}
New-AppDecl @decl_rapid

$decl_pugi = @{
	Name        = 'C++ (pugixml)' 
	Description = 'xml-i in C++ powered by pugixml'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CXX @($CXXFLAGS) '-c' 'src/main_pugixml.cpp' '-o' 'src/main_pugixml.o'
		}
		exec {
			& $CXX @($CXXFLAGS) '-lpugixml' '-o' '../bin/xml-i-pugixml' 'src/main_pugixml.o'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-pugixml'
		ArgumentList = @()
	}
}
New-AppDecl @decl_pugi

$decl_libxml2 = @{
	Name        = 'C++ (libxml2)' 
	Description = 'xml-i in C++ powered by libxml2'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {

		$LIBXML2_INC = '/usr/include/libxml2'
		$LIBXML2_LIB = '/usr/lib'
		$LIBXML2_SRC = 'src/main_libxml2.cpp'
		$LIBXML2_OBJ = $LIBXML2_SRC -replace '\.cpp$', '.o'
		$LIBXML2_TARGET = '../bin/xml-i-libxml2'

		exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" '-c' $LIBXML2_SRC '-o' $LIBXML2_OBJ
		}
		exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" "-L$LIBXML2_LIB" '-lxml2' '-o' $LIBXML2_TARGET $LIBXML2_OBJ
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-libxml2'
		ArgumentList = @()
	}
}
New-AppDecl @decl_libxml2

$decl_libxml2_xmlreader = @{
	Name        = 'C++ (libxml2 XMLReader)' 
	Description = 'xml-i in C++ powered by libxml2 XMLReader'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {

		$LIBXML2_INC = '/usr/include/libxml2'
		$LIBXML2_LIB = '/usr/lib'
		$LIBXML2_SRC = 'src/main_libxml2_xmlreader.cpp'
		$LIBXML2_OBJ = $LIBXML2_SRC -replace '\.cpp$', '.o'
		$LIBXML2_TARGET = '../bin/xml-i-libxml2-xmlreader'

		exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" '-c' $LIBXML2_SRC '-o' $LIBXML2_OBJ
		}
		exec {
			& $CXX @($CXXFLAGS) "-I$LIBXML2_INC" "-L$LIBXML2_LIB" '-lxml2' '-o' $LIBXML2_TARGET $LIBXML2_OBJ
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-libxml2-xmlreader'
		ArgumentList = @()
	}
}
New-AppDecl @decl_libxml2_xmlreader

$decl_apache_xerces = @{
	Name        = 'C++ (Apache Xerces)' 
	Description = 'xml-i in C++ powered by Apache Xerces'
	Origin      = $PSScriptRoot
	Meta        = {	}
	Builder     = {
		exec {
			& $CXX @($CXXFLAGS) '-I/usr/include/xerces-c' '-c' 'src/main_xerces.cpp' '-o' 'src/main_xerces.o'
		}
		exec {
			& $CXX @($CXXFLAGS) '-lxerces-c' '-o' '../bin/xml-i-xerces' 'src/main_xerces.o'
		}
	}
	Tester      = @{
		Executable   = '../bin/xml-i-xerces'
		ArgumentList = @()
	}
}
New-AppDecl @decl_apache_xerces	
