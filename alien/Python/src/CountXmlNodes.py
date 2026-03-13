import sys
import xml.etree.ElementTree as ET
from collections import defaultdict

def count_node_occurrences(xml_file_path, filter_nodes=None):
    counts = defaultdict(int)

    for event, elem in ET.iterparse(xml_file_path, events=('start',)):
        node_name = elem.tag
        if filter_nodes is None or node_name in filter_nodes:
            counts[node_name] += 1
    return counts

def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <path_to_xml_file> [node_name1 node_name2 ...]")
        sys.exit(1)

    xml_file_path = sys.argv[1]
    filter_nodes = set(sys.argv[2:]) if len(sys.argv) > 2 else None

    try:
        node_counts = count_node_occurrences(xml_file_path, filter_nodes)
        print("Node counts:")
        for node, count in node_counts.items():
            print(f"{node}: {count}")
    except Exception as e:
        print(f"Error processing XML file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
