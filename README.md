# xml-i

xml-i ("***XML eye***") is a personal playground project where I experiment with implementing a simple program in various programming languages (and libraries), focusing on efficiency and performance in each approach.

The cli of the program should look the same in each language, which would be something like this:

```
./<path_to_program> <path_to_xml_file> [node_name1 node_name2 ...]
```

* The program expects at least one argument: the path to the XML file.
* Additional arguments can be provided to specify node names to filter.

The program counts the occurrences of distinct XML nodes in a given XML document. A custom list of node names may also be passed if only a subset of all nodes should be counted. (see if that makes any difference in runtime/mem consumption...) 

A basic benchmarking feature is included to demonstrate and compare the performance differences between the language implementations.

- **Baseline implementation:** Written in [Rust](https://www.rust-lang.org/), using [quick-xml](https://docs.rs/quick-xml/latest/quick_xml/), serving as the primary reference for efficiency and performance.
- **Alternative implementations:** Code in other languages can be found in the [alien](./alien/) directory.

## Example Usage

```
xml-i on  main [!] is 📦 v0.1.0 via 🦀 v1.86.0
❯ file ./test/huge.xml
./test/huge.xml: XML 1.0 document, Unicode text, UTF-8 (with BOM) text, with very long lines (453)

❯ du -h ./test/huge.xml
647M	./test/huge.xml

❯ ./target/release/xml-i ./test/huge.xml
Node counts:
blips: 1287
blip: 1287000
boing: 1334440
start: 1
boings: 1335

❯ ./target/release/xml-i ./test/huge.xml boing blips
Node counts:
blips: 1287
boing: 1334440
```

## Build / TestData / Benchmarking

Each variant defines it's *b*uild*c*onfig via `New-AppDecl`.
All `<something>.bc.ps1` are automatically picked up and dot-sources by`xml-i.build.ps1`.
Use PowerShell and `Invoke-Build`.

See [the Rust quick-xml build config](src/rust.bc.ps1) as example.

Basis for my [benchmark-results](test/benchmark_results.md):

* OS: Linux 6.something-MANJARO
* Model: ThinkPad X13 Laptop 
* CPU: 12th Gen Intel(R) Core(TM) i7-1270P
* RAM: 32GB 
* HDD: WD Black SN770 / PC SN740 256GB / PC SN560 (DRAM-less) NVMe SSD

=> [See benchmark_results.md](test/benchmark_results.md)

![quick-xml go brr](https://i.imgflip.com/9w3r5t.jpg)


## Motivation

This repository serves as a learning and benchmarking tool, helping to explore language-specific approaches to XML processing and performance optimization.

## License

MIT License - see [LICENSE.txt](./LICENSE.txt)
