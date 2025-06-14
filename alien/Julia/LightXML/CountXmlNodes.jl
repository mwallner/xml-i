using LightXML


function traverse(node::XMLElement, node_counts::Dict{String, Int}, filter_nodes::Union{Nothing, Set{String}}=nothing)
        node_name = LightXML.name(node)
        if isnothing(filter_nodes) || node_name in filter_nodes
            node_counts[node_name] = get(node_counts, node_name, 0) + 1
        end
        for child in LightXML.child_elements(node)
            traverse(child, node_counts, filter_nodes)
        end
    end


function count_node_occurrences(xml_file_path::String, filter_nodes::Union{Nothing, Set{String}}=nothing)
    doc = parse_file(xml_file_path)
    node_counts = Dict{String, Int}()

    traverse(root(doc), node_counts, filter_nodes)
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