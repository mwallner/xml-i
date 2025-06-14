using XML

function traverse(node::LazyNode, node_counts::Dict{String, Int}, filter_nodes::Union{Nothing, Set{String}}=nothing)    
    node_name = node.tag

    if isnothing(filter_nodes) || node_name in filter_nodes
        node_counts[node_name] = get(node_counts, node_name, 0) + 1
    end

    for child in children(node)        
       if child.tag !== nothing
            traverse(child, node_counts, filter_nodes)
        end
    end
end

function count_node_occurrences(xml_file_path::String, filter_nodes::Union{Nothing, Set{String}}=nothing)
    doc = XML.read(xml_file_path, LazyNode)
    root_node = doc[end]

    node_counts = Dict{String, Int}()

    traverse(root_node, node_counts, filter_nodes)
    return node_counts
end

function main()
    if length(ARGS) < 1
        println("Usage: julia CountXmlNodes.jl <path_to_xml_file> [node_name1 node_name2 ...]")
        exit(1)
    end

    xml_file_path = ARGS[1]
    filter_nodes = length(ARGS) > 1 ? Set(ARGS[2:end]) : nothing

    try
        node_counts = count_node_occurrences(xml_file_path, filter_nodes)
        println("Node counts:")
        for (node, count) in node_counts
            println("$(node): $(count)")
        end
    catch e
        println("Error processing XML file: $e")
        exit(1)
    end
end

main()
