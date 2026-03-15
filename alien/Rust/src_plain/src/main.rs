use memchr::memchr;
use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io::{self, Read};

const CHUNK_SIZE: usize = 4 * 1024 * 1024; // 4 MiB

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

fn parse_xml_chunk(
    buf: &[u8],
    node_counts: &mut HashMap<String, usize>,
    filters: Option<&Vec<String>>,
    trailing: &mut Vec<u8>,
) {
    let mut p = 0;
    let mut last_lt = None;
    while let Some(start) = memchr(b'<', &buf[p..]) {
        let lt_pos = p + start;
        let mut idx = lt_pos + 1;
        if idx >= buf.len() {
            break;
        }
        let c = buf[idx] as char;
        if c == '/' || c == '?' || c == '!' {
            p = idx + 1;
            continue;
        }
        let mut name = String::new();
        while idx < buf.len() {
            let ch = buf[idx] as char;
            if ch.is_whitespace() || ch == '>' || ch == '/' {
                break;
            }
            name.push(ch);
            idx += 1;
        }
        if !name.is_empty() {
            add_node(&name, node_counts, filters);
        }
        last_lt = Some(lt_pos);
        if let Some(gt_pos) = memchr(b'>', &buf[idx..]) {
            p = idx + gt_pos + 1;
        } else {
            break;
        }
    }
    trailing.clear();
    if let Some(last_start) = last_lt {
        if !buf[last_start..].contains(&b'>') {
            trailing.extend_from_slice(&buf[last_start..]);
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
    let mut file = file;
    let filters = if args.len() > 2 {
        Some(args[2..].to_vec())
    } else {
        None
    };

    let mut node_counts: HashMap<String, usize> = HashMap::new();
    let mut trailing = Vec::with_capacity(1024);
    let mut read_buf = vec![0u8; CHUNK_SIZE];
    let mut work_buf = Vec::with_capacity(CHUNK_SIZE + trailing.capacity());

    loop {
        let bytes_read = file.read(&mut read_buf)?;
        if bytes_read == 0 {
            break;
        }

        // Reuse a single parsing buffer by rebuilding it from trailing + current chunk.
        work_buf.clear();
        if !trailing.is_empty() {
            work_buf.extend_from_slice(&trailing);
        }
        work_buf.extend_from_slice(&read_buf[..bytes_read]);

        parse_xml_chunk(&work_buf, &mut node_counts, filters.as_ref(), &mut trailing);
    }

    println!("Node counts:");
    for (name, count) in node_counts.iter() {
        println!("{}: {}", name, count);
    }
    Ok(())
}
