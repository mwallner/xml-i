const fs = require('fs');
const sax = require('sax');

if (process.argv.length < 3) {
  console.error('Usage: node countXmlNodes.js <path_to_xml_file> [node_name1 node_name2 ...]');
  process.exit(1);
}

const xmlFilePath = process.argv[2];
const filterNodes = process.argv.length > 3
  ? new Set(process.argv.slice(3))
  : null;

const nodeCounts = {};

const parser = sax.createStream(true, { lowercase: false });

parser.on('opentag', node => {
  const nodeName = node.name;
  if (!filterNodes || filterNodes.has(nodeName)) {
    nodeCounts[nodeName] = (nodeCounts[nodeName] || 0) + 1;
  }
});

parser.on('error', err => {
  console.error('Error:', err.message);
  process.exit(1);
});

parser.on('end', () => {
  console.log('Node counts:');
  for (const [node, count] of Object.entries(nodeCounts)) {
    console.log(`${node}: ${count}`);
  }
});

fs.createReadStream(xmlFilePath).pipe(parser);
