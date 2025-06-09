package main

import (
	"fmt"
	"os"

	"github.com/antchfx/xmlquery"
)

func countNodeOccurrences(xmlFilePath string, filterNodes map[string]struct{}) (map[string]int, error) {
	file, err := os.Open(xmlFilePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	doc, err := xmlquery.Parse(file)
	if err != nil {
		return nil, err
	}

	nodeCounts := make(map[string]int)
	var visit func(*xmlquery.Node)
	visit = func(n *xmlquery.Node) {
		if n.Type == xmlquery.ElementNode {
			nodeName := n.Data
			if len(filterNodes) == 0 {
				nodeCounts[nodeName]++
			} else {
				if _, ok := filterNodes[nodeName]; ok {
					nodeCounts[nodeName]++
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			visit(c)
		}
	}
	visit(doc)

	return nodeCounts, nil
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s <path_to_xml_file> [node_name1 node_name2 ...]\n", os.Args[0])
		os.Exit(1)
	}

	xmlFilePath := os.Args[1]
	filterNodes := make(map[string]struct{})
	if len(os.Args) > 2 {
		for _, name := range os.Args[2:] {
			filterNodes[name] = struct{}{}
		}
	}

	nodeCounts, err := countNodeOccurrences(xmlFilePath, filterNodes)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error processing XML file: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("Node counts:")
	for node, count := range nodeCounts {
		fmt.Printf("%s: %d\n", node, count)
	}
}
