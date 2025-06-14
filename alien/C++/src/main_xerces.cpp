#include <xercesc/sax2/DefaultHandler.hpp>
#include <xercesc/sax2/XMLReaderFactory.hpp>
#include <xercesc/util/XMLString.hpp>
#include <xercesc/util/PlatformUtils.hpp>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <string_view>

using namespace xercesc;

class NodeCounterHandler : public DefaultHandler
{
public:
	NodeCounterHandler(const std::unordered_set<std::string> *filterNodes)
			: filterNodes(filterNodes)
	{
		nodeCounts.reserve(100); // Preallocate space for performance
	}

	void startElement(const XMLCh *const uri,
										const XMLCh *const localname,
										const XMLCh *const qname,
										const Attributes &attrs) override
	{
		std::string nodeName = XMLChToString(qname); // Use qname instead of localname

		if (filterNodes->empty() || filterNodes->find(nodeName) != filterNodes->end())
		{
			nodeCounts[nodeName]++;
		}
	}

	const std::unordered_map<std::string, size_t> &getNodeCounts() const
	{
		return nodeCounts;
	}

private:
	std::unordered_map<std::string, size_t> nodeCounts;
	const std::unordered_set<std::string> *filterNodes;
	std::string XMLChToString(const XMLCh *xmlCh)
	{
		char *temp = XMLString::transcode(xmlCh);
		std::string result(temp);
		XMLString::release(&temp);
		return result;
	}
};

int main(int argc, char *argv[])
{
	if (argc < 2)
	{
		std::cerr << "Usage: " << argv[0] << " <path_to_xml_file> [node_name1 node_name2 ...]" << std::endl;
		return 1;
	}

	const char *xmlFilePath = argv[1];
	std::unordered_set<std::string> filterNodes;

	if (argc > 2)
	{
		for (int i = 2; i < argc; ++i)
		{
			filterNodes.insert(argv[i]);
		}
	}

	try
	{
		XMLPlatformUtils::Initialize();
	}
	catch (const XMLException &e)
	{
		char *message = XMLString::transcode(e.getMessage());
		std::cerr << "Error during Xerces initialization: " << message << std::endl;
		XMLString::release(&message);
		return 1;
	}

	try
	{
		SAX2XMLReader *parser = XMLReaderFactory::createXMLReader();

		NodeCounterHandler handler(&filterNodes);
		parser->setContentHandler(&handler);
		parser->setErrorHandler(&handler);

		parser->parse(xmlFilePath);

		const auto &nodeCounts = handler.getNodeCounts();
		std::cout << "Node counts:" << std::endl;
		for (const auto &[node, count] : nodeCounts)
		{
			std::cout << node << ": " << count << std::endl;
		}

		delete parser;
	}
	catch (const XMLException &e)
	{
		char *message = XMLString::transcode(e.getMessage());
		std::cerr << "XMLException: " << message << std::endl;
		XMLString::release(&message);
		XMLPlatformUtils::Terminate();
		return 1;
	}
	catch (const SAXException &e)
	{
		char *message = XMLString::transcode(e.getMessage());
		std::cerr << "SAXException: " << message << std::endl;
		XMLString::release(&message);
		XMLPlatformUtils::Terminate();
		return 1;
	}

	XMLPlatformUtils::Terminate();
	return 0;
}
