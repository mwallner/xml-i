#include <pugixml.hpp>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>

std::unordered_map<std::string, size_t> nodeCounts;
std::unordered_set<std::string> filterNodes;

void countNodes(const pugi::xml_node &node)
{
	std::string nodeName = node.name();

	if (nodeName.empty())
	{
		return; // Skip empty node names
	}

	if (filterNodes.empty() || filterNodes.find(nodeName) != filterNodes.end())
	{
		nodeCounts[nodeName]++;
	}

	for (const auto &child : node.children())
	{
		countNodes(child);
	}
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

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file(xmlFilePath);

	if (!result)
	{
		std::cerr << "Error: Failed to parse XML file: " << xmlFilePath << std::endl;
		std::cerr << "Error description: " << result.description() << std::endl;
		return 1;
	}

	pugi::xml_node root = doc.document_element();
	countNodes(root);

	std::cout << "Node counts:" << std::endl;
	for (const auto &[node, count] : nodeCounts)
	{
		std::cout << node << ": " << count << std::endl;
	}

	return 0;
}
