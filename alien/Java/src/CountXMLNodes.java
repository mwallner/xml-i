import javax.xml.stream.*;
import javax.xml.stream.events.StartElement;
import java.io.FileInputStream;
import java.io.BufferedInputStream;
import java.util.*;

public class CountXMLNodes {

    public static Map<String, Integer> countNodes(String xmlFilePath, Set<String> filterNodes) throws Exception {
        Map<String, Integer> nodeCounts = new HashMap<>();
        XMLInputFactory factory = XMLInputFactory.newInstance();
        FileInputStream fis = new FileInputStream(xmlFilePath);
        BufferedInputStream bis = new BufferedInputStream(fis, 8192 * 1024);
        XMLStreamReader reader = factory.createXMLStreamReader(bis);

        while (reader.hasNext()) {
            int event = reader.next();
            if (event == XMLStreamConstants.START_ELEMENT) {
                String nodeName = reader.getLocalName();
                if (filterNodes == null || filterNodes.contains(nodeName)) {
                    nodeCounts.put(nodeName, nodeCounts.getOrDefault(nodeName, 0) + 1);
                }
            }
        }
        reader.close();
        fis.close();
        return nodeCounts;
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Usage: java XmlNodeCounter <path_to_xml_file> [node_name1 node_name2 ...]");
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
