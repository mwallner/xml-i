import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;
import javax.xml.parsers.*;
import java.io.*;
import java.util.*;

public class CountXMLNodesSAX {

    public static Map<String, Integer> countNodes(String xmlFilePath, Set<String> filterNodes) throws Exception {
        Map<String, Integer> nodeCounts = new HashMap<>();

        SAXParserFactory factory = SAXParserFactory.newInstance();
        SAXParser parser = factory.newSAXParser();

        DefaultHandler handler = new DefaultHandler() {
            @Override
            public void startElement(String uri, String localName, String qName, Attributes attributes) {
                String nodeName = localName.isEmpty() ? qName : localName;
                if (filterNodes == null || filterNodes.contains(nodeName)) {
                    nodeCounts.put(nodeName, nodeCounts.getOrDefault(nodeName, 0) + 1);
                }
            }
        };

        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(xmlFilePath), 64 * 1024)) {
            parser.parse(bis, handler);
        }
        return nodeCounts;
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Usage: java CountXMLNodesSAX <path_to_xml_file> [node_name1 node_name2 ...]");
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
