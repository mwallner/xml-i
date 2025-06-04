#include <rapidxml.hpp>
#include <rapidxml_utils.hpp>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>

std::unordered_map<std::string, size_t> nodeCounts;
std::unordered_set<std::string> filterNodes;

void countNodes(rapidxml::xml_node<> *node)
{
	if (!node)
		return;

	std::string nodeName = node->name();
	if (!nodeName.empty() && (filterNodes.empty() || filterNodes.find(nodeName) != filterNodes.end()))
	{
		nodeCounts[nodeName]++;
	}

	for (rapidxml::xml_node<> *child = node->first_node(); child; child = child->next_sibling())
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

	try
	{
		rapidxml::file<> xmlFile(xmlFilePath);
		rapidxml::xml_document<> doc;
		doc.parse<0>(xmlFile.data());

		rapidxml::xml_node<> *root = doc.first_node();
		countNodes(root);

		std::cout << "Node counts:" << std::endl;
		for (const auto &[node, count] : nodeCounts)
		{
			std::cout << node << ": " << count << std::endl;
		}
	}
	catch (const std::exception &ex)
	{
		std::cerr << "Error: " << ex.what() << std::endl;
		return 1;
	}

	return 0;
}
