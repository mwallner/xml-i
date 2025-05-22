param (
	[string]$XmlFilePath,
	[string[]]$FilterNodes
)

if (-not $XmlFilePath) {
	Write-Error 'Usage: .\CountXmlNodes.ps1 -XmlFilePath <path_to_xml_file> [-FilterNodes <node_name1,node_name2,...>]'
	exit 1
}

function CountNodeOccurrences {
	param (
		[string]$XmlFilePath,
		[string[]]$FilterNodes
	)

	if (-not (Test-Path $XmlFilePath)) {
		throw "The file '$XmlFilePath' does not exist."
	}

	$nodeCounts = @{}

	# Create an XmlReader to process the file in a streaming manner
	# [xml] (Get-Content -Raw  ...) would load the entire file into memory, which is not efficient for large files
	$settings = New-Object System.Xml.XmlReaderSettings
	$settings.IgnoreWhitespace = $true
	$settings.IgnoreComments = $true

	$reader = [System.Xml.XmlReader]::Create($XmlFilePath, $settings)

	try {
		while ($reader.Read()) {
			if ($reader.NodeType -eq [System.Xml.XmlNodeType]::Element) {
				$nodeName = $reader.LocalName

				if (-not $FilterNodes -or $FilterNodes -contains $nodeName) {
					if (-not $nodeCounts.ContainsKey($nodeName)) {
						$nodeCounts[$nodeName] = 0
					}
					$nodeCounts[$nodeName]++
				}
			}
		}
	}
 finally {
		$reader.Close()
	}

	return $nodeCounts
}

try {
	$nodeCounts = CountNodeOccurrences -XmlFilePath $XmlFilePath -FilterNodes $FilterNodes

	Write-Output 'Node counts:'
	foreach ($kvp in $nodeCounts.GetEnumerator()) {
		Write-Output "$($kvp.Key): $($kvp.Value)"
	}
}
catch {
	Write-Error "Error processing XML file: $_"
	exit 1
}
