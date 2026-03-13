import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Arrays;
import java.util.HashSet;

public class CountXMLNodesAalto {

	public static Map<String, Integer> countNodes(String xmlFilePath, Set<String> filterNodes) throws Exception {
		Map<String, Integer> nodeCounts = new HashMap<>();

		XMLInputFactory factory;
		try {
			factory = (XMLInputFactory) Class.forName("com.fasterxml.aalto.stax.InputFactoryImpl").newInstance();
		} catch (Throwable t) {
			factory = XMLInputFactory.newInstance();
		}

		try (InputStream is = new BufferedInputStream(new FileInputStream(xmlFilePath), 64 * 1024)) {
			XMLStreamReader reader = factory.createXMLStreamReader(is);
			try {
				while (true) {
					int ev;
					try {
						ev = reader.next();
					} catch (XMLStreamException e) {
						break;
					}
					if (ev == XMLStreamConstants.START_ELEMENT) {
						String nodeName = reader.getLocalName();
						if (nodeName == null) nodeName = "";
						if (filterNodes == null || filterNodes.contains(nodeName)) {
							nodeCounts.put(nodeName, nodeCounts.getOrDefault(nodeName, 0) + 1);
						}
					}
					if (ev == XMLStreamConstants.END_DOCUMENT) break;
				}
			} finally {
				try {
					reader.close();
				} catch (Exception ignored) {
				}
			}
		}

		return nodeCounts;
	}

	public static void main(String[] args) {
		if (args.length < 1) {
			System.err.println("Usage: java CountXMLNodesAalto <path_to_xml_file> [node_name1 node_name2 ...]");
			System.exit(1);
		}

		String xmlFilePath = args[0];
		Set<String> filterNodes = null;
		if (args.length > 1) {
			filterNodes = new HashSet<>(Arrays.asList(Arrays.copyOfRange(args, 1, args.length)));
		}

		try {
			Map<String, Integer> nodeCounts = countNodes(xmlFilePath, filterNodes);
			System.out.println("Node counts:");
			for (Map.Entry<String, Integer> entry : nodeCounts.entrySet()) {
				System.out.println(entry.getKey() + ": " + entry.getValue());
			}
		} catch (Exception e) {
			System.err.println("Error processing XML file: " + e.getMessage());
			System.exit(1);
		}
	}
}

