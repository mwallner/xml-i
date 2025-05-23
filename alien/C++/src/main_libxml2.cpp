#include <libxml/parser.h>
#include <libxml/xmlstring.h>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>

std::unordered_map<std::string, size_t> nodeCounts;
std::unordered_set<std::string> filterNodes;

void startElement(void *ctx, const xmlChar *name, const xmlChar **attrs)
{
	std::string nodeName(reinterpret_cast<const char *>(name));

	if (filterNodes.empty() || filterNodes.find(nodeName) != filterNodes.end())
	{
		nodeCounts[nodeName]++;
	}
}

void endElement(void *ctx, const xmlChar *name)
{
}

void characters(void *ctx, const xmlChar *ch, int len)
{
}

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

	xmlInitParser();

	xmlSAXHandler saxHandler = {};
	saxHandler.startElement = startElement;
	saxHandler.endElement = endElement;
	saxHandler.characters = characters;

	if (xmlSAXUserParseFile(&saxHandler, nullptr, xmlFilePath) != 0)
	{
		std::cerr << "Error: Failed to parse XML file: " << xmlFilePath << std::endl;
		xmlCleanupParser();
		return 1;
	}

	std::cout << "Node counts:" << std::endl;
	for (const auto &[node, count] : nodeCounts)
	{
		std::cout << node << ": " << count << std::endl;
	}

	xmlCleanupParser();
	return 0;
}
