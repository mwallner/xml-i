package main

import (
	"encoding/xml"
	"fmt"
	"io"
	"os"
)

func countNodeOccurrences(xmlFilePath string, filterNodes map[string]struct{}) (map[string]int, error) {
	file, err := os.Open(xmlFilePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	decoder := xml.NewDecoder(file)
	nodeCounts := make(map[string]int)

	for {
		tok, err := decoder.Token()
		if err == io.EOF {
			break
		}
		if err != nil {
			return nil, err
		}

		switch se := tok.(type) {
		case xml.StartElement:
			nodeName := se.Name.Local
			if len(filterNodes) == 0 {
				nodeCounts[nodeName]++
			} else {
				if _, ok := filterNodes[nodeName]; ok {
					nodeCounts[nodeName]++
				}
			}
		}
	}
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
