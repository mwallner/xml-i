use std::collections::{HashMap, HashSet};
use std::env;
use std::fs::File;
use std::io::BufReader;
use xml::reader::{EventReader, XmlEvent};

fn count_node_occurrences(
    xml_file_path: &str,
    filter_nodes: Option<HashSet<String>>,
) -> Result<HashMap<String, usize>, Box<dyn std::error::Error>> {
    let file = File::open(xml_file_path)?;
    let reader = BufReader::new(file);
    let parser = EventReader::new(reader);

    let mut node_counts: HashMap<String, usize> = HashMap::new();

    for event in parser {
        match event? {
            XmlEvent::StartElement { name, .. } => {
                let node_name = name.local_name;
                if filter_nodes
                    .as_ref()
                    .map_or(true, |nodes| nodes.contains(&node_name))
                {
                    *node_counts.entry(node_name).or_insert(0) += 1;
                }
            }
            _ => {}
        }
    }

    Ok(node_counts)
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!(
            "Usage: {} <path_to_xml_file> [node_name1 node_name2 ...]",
            args[0]
        );
        std::process::exit(1);
    }

    let xml_file_path = &args[1];
    let filter_nodes = if args.len() > 2 {
        Some(args[2..].iter().cloned().collect::<HashSet<String>>())
    } else {
        None
    };

    match count_node_occurrences(xml_file_path, filter_nodes) {
        Ok(node_counts) => {
            println!("Node counts:");
            for (node, count) in node_counts {
                println!("{}: {}", node, count);
            }
        }
        Err(e) => {
            eprintln!("Error processing XML file: {}", e);
            std::process::exit(1);
        }
    }
}
