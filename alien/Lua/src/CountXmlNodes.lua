#!/usr/bin/env lua

local xml_file = arg[1]
if not xml_file then
    io.stderr:write("Usage: CountXmlNodes.lua <path_to_xml_file> [node_name1 node_name2 ...]\n")
    os.exit(1)
end

local filters = {}
for i = 2, #arg do filters[arg[i]] = true end
local use_filter = next(filters) ~= nil

local ok, lxp = pcall(require, "lxp")
if not ok then
    io.stderr:write("LuaExpat (lxp) is required. Install it and try again.\n")
    os.exit(1)
end

local counts = {}

local callbacks = {}
function callbacks.StartElement(parser, name, attrs)
    if not use_filter or filters[name] then
        counts[name] = (counts[name] or 0) + 1
    end
end

local parser = lxp.new(callbacks)
local f, err = io.open(xml_file, "rb")
if not f then
    io.stderr:write("Failed to open file: " .. err .. "\n")
    os.exit(1)
end

while true do
    local chunk = f:read(8192)
    if not chunk then break end
    local ok, msg = parser:parse(chunk)
    if not ok then
        io.stderr:write("Parse error: " .. tostring(msg) .. "\n")
        f:close()
        os.exit(1)
    end
end

local ok, msg = parser:parse()
if not ok then
    io.stderr:write("Parse error: " .. tostring(msg) .. "\n")
    f:close()
    os.exit(1)
end
parser:close()
f:close()

io.write("Node counts:\n")
local keys = {}
for k in pairs(counts) do table.insert(keys, k) end
table.sort(keys)
for _, k in ipairs(keys) do
    io.write(k .. ": " .. counts[k] .. "\n")
end
