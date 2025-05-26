#include <libxml/xmlreader.h>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <string_view>

std::unordered_map<std::string_view, size_t> nodeCounts;
std::unordered_set<std::string> filterNodes;

int main(int argc, char *argv[])
{
	if (argc < 2)
	{
		std::cerr << "Usage: " << argv[0] << " <path_to_xml_file> [node_name1 node_name2 ...]" << std::endl;
		return 1;
	}

	const char *xmlFilePath = argv[1];

	if (argc > 2)
	{
		for (int i = 2; i < argc; ++i)
		{
			filterNodes.insert(argv[i]);
		}
	}

	xmlTextReaderPtr reader = xmlReaderForFile(xmlFilePath, nullptr, XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
	if (reader == nullptr)
	{
		std::cerr << "Error: Unable to open XML file: " << xmlFilePath << std::endl;
		return 1;
	}

	while (xmlTextReaderRead(reader) == 1)
	{
		if (xmlTextReaderNodeType(reader) == XML_READER_TYPE_ELEMENT)
		{
			const xmlChar *name = xmlTextReaderConstLocalName(reader);
			std::string_view nodeName(reinterpret_cast<const char *>(name));

			if (filterNodes.empty() || filterNodes.find(std::string(nodeName)) != filterNodes.end())
			{
				nodeCounts[nodeName]++;
			}
		}
	}

	xmlFreeTextReader(reader);

	std::cout << "Node counts:" << std::endl;
	for (const auto &[node, count] : nodeCounts)
	{
		std::cout << node << ": " << count << std::endl;
	}

	return 0;
}
