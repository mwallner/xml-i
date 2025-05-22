use quick_xml::Reader;
use quick_xml::events::Event;
use std::collections::HashMap;
use std::collections::HashSet;
use std::fs::File;
use std::io::BufReader;

fn count_node_occurrences(
    xml_file_path: &str,
    filter_nodes: Option<HashSet<String>>,
) -> Result<HashMap<String, usize>, Box<dyn std::error::Error>> {
    let file = File::open(xml_file_path)?;
    let reader = BufReader::new(file);

    let mut xml_reader = Reader::from_reader(reader);

    let mut node_counts: HashMap<String, usize> = HashMap::new();
    let mut buf = Vec::new();

    loop {
        match xml_reader.read_event_into(&mut buf) {
            Ok(Event::Start(ref e)) => {
                let node_name = String::from_utf8_lossy(e.name().as_ref()).to_string();
                if filter_nodes
                    .as_ref()
                    .map_or(true, |nodes| nodes.contains(&node_name))
                {
                    *node_counts.entry(node_name).or_insert(0) += 1;
                }
            }
            Ok(Event::Eof) => break,
            Err(e) => return Err(Box::new(e)),
            _ => (), // Ignore other events
        }
        buf.clear();
    }

    Ok(node_counts)
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
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
