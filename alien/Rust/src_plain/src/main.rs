use memchr::memchr;
use rustc_hash::{FxHashMap, FxHashSet};
use std::env;
use std::fs::File;
use std::io::{self, Read};

const CHUNK_SIZE: usize = 4 * 1024 * 1024; // 4 MiB

#[inline]
fn is_name_delim(b: u8) -> bool {
    matches!(b, b'>' | b'/' | b' ' | b'\t' | b'\n' | b'\r')
}

fn add_node(
    name: &str,
    node_counts: &mut FxHashMap<String, usize>,
    filters: Option<&FxHashSet<String>>,
) {
    if filters.is_some_and(|f| !f.contains(name)) {
        return;
    }

    if let Some(count) = node_counts.get_mut(name) {
        *count += 1;
    } else {
        node_counts.insert(name.to_owned(), 1);
    }
}

fn parse_xml_chunk(
    buf: &[u8],
    node_counts: &mut FxHashMap<String, usize>,
    filters: Option<&FxHashSet<String>>,
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
        let c = buf[idx];
        if matches!(c, b'/' | b'?' | b'!') {
            p = idx + 1;
            continue;
        }

        let name_start = idx;
        while idx < buf.len() {
            if is_name_delim(buf[idx]) {
                break;
            }
            idx += 1;
        }
        if idx > name_start {
            if let Ok(name) = std::str::from_utf8(&buf[name_start..idx]) {
                add_node(name, node_counts, filters);
            }
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
        if memchr(b'>', &buf[last_start..]).is_none() {
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
        Some(args[2..].iter().cloned().collect::<FxHashSet<String>>())
    } else {
        None
    };

    let mut node_counts: FxHashMap<String, usize> = FxHashMap::default();
    node_counts.reserve(64);
    let mut trailing = Vec::with_capacity(1024);
    let mut work_buf = Vec::with_capacity(CHUNK_SIZE + trailing.capacity());

    loop {
        // Reuse a single parsing buffer and read directly into its tail to avoid extra copies.
        work_buf.clear();
        if !trailing.is_empty() {
            work_buf.extend_from_slice(&trailing);
        }

        let prefix_len = work_buf.len();
        work_buf.resize(prefix_len + CHUNK_SIZE, 0);
        let bytes_read = file.read(&mut work_buf[prefix_len..])?;
        if bytes_read == 0 {
            break;
        }
        work_buf.truncate(prefix_len + bytes_read);

        parse_xml_chunk(&work_buf, &mut node_counts, filters.as_ref(), &mut trailing);
    }

    println!("Node counts:");
    for (name, count) in node_counts.iter() {
        println!("{}: {}", name, count);
    }
    Ok(())
}
