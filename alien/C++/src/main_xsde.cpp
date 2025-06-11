#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <string_view>
#include "../src_xsde/scheme-pskel.hxx"

// Custom parser for <blip>
class blip_counter : public blip_pskel
{
public:
	blip_counter(std::unordered_map<std::string, size_t> &counts, const std::unordered_set<std::string> &filter)
			: counts_(counts), filter_(filter), blip_pskel(&base_impl_) {}

	void post_blip() override
	{
		if (filter_.empty() || filter_.count("blip"))
		{
			counts_["blip"]++;
		}
	}

private:
	xml_schema::string_pimpl base_impl_;
	std::unordered_map<std::string, size_t> &counts_;
	const std::unordered_set<std::string> &filter_;
};

// Custom parser for <boing>
class boing_counter : public boing_pskel
{
public:
	boing_counter(std::unordered_map<std::string, size_t> &counts, const std::unordered_set<std::string> &filter)
			: counts_(counts), filter_(filter), boing_pskel(&base_impl_) {}

	void post_boing() override
	{
		if (filter_.empty() || filter_.count("boing"))
		{
			counts_["boing"]++;
		}
	}

private:
	xml_schema::string_pimpl base_impl_;
	std::unordered_map<std::string, size_t> &counts_;
	const std::unordered_set<std::string> &filter_;
};

// Custom parser for <blips>
class blips_counter : public blips_pskel
{
public:
	blips_counter(std::unordered_map<std::string, size_t> &counts, blip_counter &blip, const std::unordered_set<std::string> &filter)
			: counts_(counts), filter_(filter)
	{
		blip_parser(blip);
	}
	void post_blips() override
	{
		if (filter_.empty() || filter_.count("blips"))
		{
			counts_["blips"]++;
		}
	}

private:
	std::unordered_map<std::string, size_t> &counts_;
	const std::unordered_set<std::string> &filter_;
};

// Custom parser for <boings>
class boings_counter : public boings_pskel
{
public:
	boings_counter(std::unordered_map<std::string, size_t> &counts, boing_counter &boing, const std::unordered_set<std::string> &filter)
			: counts_(counts), filter_(filter)
	{
		boing_parser(boing);
	}
	void post_boings() override
	{
		if (filter_.empty() || filter_.count("boings"))
		{
			counts_["boings"]++;
		}
	}

private:
	std::unordered_map<std::string, size_t> &counts_;
	const std::unordered_set<std::string> &filter_;
};

// Custom parser for <start>
class start_counter : public start_pskel
{
public:
	start_counter(std::unordered_map<std::string, size_t> &counts, blips_counter &blips, boings_counter &boings, const std::unordered_set<std::string> &filter)
			: counts_(counts), filter_(filter)
	{
		blips_parser(blips);
		boings_parser(boings);
	}
	void post_start() override
	{
		if (filter_.empty() || filter_.count("start"))
		{
			counts_["start"]++;
		}
	}

private:
	std::unordered_map<std::string, size_t> &counts_;
	const std::unordered_set<std::string> &filter_;
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

	std::unordered_map<std::string, size_t> nodeCounts;

	// Set up the parser hierarchy
	blip_counter blip(nodeCounts, filterNodes);
	boing_counter boing(nodeCounts, filterNodes);
	blips_counter blips(nodeCounts, blip, filterNodes);
	boings_counter boings(nodeCounts, boing, filterNodes);
	start_counter start(nodeCounts, blips, boings, filterNodes);

	// Parse the XML file
	try
	{
		std::ifstream xmlFileStream(xmlFilePath);
		if (!xmlFileStream)
		{
			std::cerr << "Failed to open XML file: " << xmlFilePath << std::endl;
			return 1;
		}
		xml_schema::document_pimpl doc(start, "start");
		start.pre();
		doc.parse(xmlFileStream);
	}
	catch (const xml_schema::parser_exception &e)
	{
		std::cerr << "Parse error: " << e.what() << std::endl;
		std::cerr << "line: " << e.line() << std::endl;
		return 1;
	}
	catch (const std::exception &e)
	{
		std::cerr << "Error: " << e.what() << std::endl;
		return 1;
	}

	// Output the node counts
	std::cout << "Node counts:" << std::endl;
	for (const auto &[node, count] : nodeCounts)
	{
		std::cout << node << ": " << count << std::endl;
	}

	return 0;
}
