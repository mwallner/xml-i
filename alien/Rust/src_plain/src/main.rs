use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io::{self, BufRead, BufReader};

fn filter_match<'a>(name: &str, filters: Option<&Vec<String>>) -> bool {
    match filters {
        None => true,
        Some(f) => f.iter().any(|n| n == name),
    }
}

fn add_node(name: &str, node_counts: &mut HashMap<String, usize>, filters: Option<&Vec<String>>) {
    if filter_match(name, filters) {
        *node_counts.entry(name.to_string()).or_insert(0) += 1;
    }
}

fn parse_xml<R: BufRead>(
    reader: R,
    node_counts: &mut HashMap<String, usize>,
    filters: Option<&Vec<String>>,
) {
    for line in reader.lines() {
        let line = match line {
            Ok(l) => l,
            Err(_) => continue,
        };
        let mut p = 0;
        let bytes = line.as_bytes();
        while let Some(start) = memchr::memchr(b'<', &bytes[p..]) {
            let mut idx = p + start + 1;
            if idx >= bytes.len() {
                break;
            }
            let c = bytes[idx] as char;
            if c == '/' || c == '?' || c == '!' {
                p = idx + 1;
                continue;
            }
            let mut name = String::new();
            while idx < bytes.len() {
                let ch = bytes[idx] as char;
                if ch.is_whitespace() || ch == '>' || ch == '/' {
                    break;
                }
                name.push(ch);
                idx += 1;
            }
            if !name.is_empty() {
                add_node(&name, node_counts, filters);
            }
            p = idx;
        }
    }
}

fn main() -> io::Result<()> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <xml_file> [node1 node2 ...]", args[0]);
        std::process::exit(1);
    }
    let file = File::open(&args[1])?;
    let reader = BufReader::new(file);

    let filters = if args.len() > 2 {
        Some(args[2..].to_vec())
    } else {
        None
    };

    let mut node_counts: HashMap<String, usize> = HashMap::new();
    parse_xml(reader, &mut node_counts, filters.as_ref());

    println!("Node counts:");
    for (name, count) in node_counts.iter() {
        println!("{}: {}", name, count);
    }
    Ok(())
}
