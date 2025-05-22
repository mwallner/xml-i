using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;

class Program
{
	static void Main(string[] args)
	{
		if (args.Length < 1)
		{
			Console.Error.WriteLine("Usage: dotnet run <path_to_xml_file> [node_name1 node_name2 ...]");
			Environment.Exit(1);
		}

		string xmlFilePath = args[0];
		HashSet<string> filterNodes = args.Length > 1
				? new HashSet<string>(args.Skip(1))
				: null;

		try
		{
			var nodeCounts = CountNodeOccurrences(xmlFilePath, filterNodes);

			Console.WriteLine("Node counts:");
			foreach (var kvp in nodeCounts)
			{
				Console.WriteLine($"{kvp.Key}: {kvp.Value}");
			}
		}
		catch (Exception ex)
		{
			Console.Error.WriteLine($"Error processing XML file: {ex.Message}");
			Environment.Exit(1);
		}
	}

	static Dictionary<string, int> CountNodeOccurrences(string xmlFilePath, HashSet<string> filterNodes)
	{
		if (!File.Exists(xmlFilePath))
		{
			throw new FileNotFoundException($"The file '{xmlFilePath}' does not exist.");
		}

		var nodeCounts = new Dictionary<string, int>();

		using (var reader = File.OpenRead(xmlFilePath))
		{
			var xml = XDocument.Load(reader);

			foreach (var element in xml.Descendants())
			{
				string nodeName = element.Name.LocalName;

				if (filterNodes == null || filterNodes.Contains(nodeName))
				{
					if (!nodeCounts.ContainsKey(nodeName))
					{
						nodeCounts[nodeName] = 0;
					}

					nodeCounts[nodeName]++;
				}
			}
		}

		return nodeCounts;
	}
}
