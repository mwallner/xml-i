import javax.xml.stream.{XMLInputFactory, XMLStreamConstants}
import java.io.{FileInputStream, BufferedInputStream}
import scala.collection.mutable

object CountXMLNodes {
  def countNodes(
      xmlFilePath: String,
      filterNodes: Set[String]
  ): Map[String, Int] = {
    val nodeCounts = mutable.Map[String, Int]()
    val factory = XMLInputFactory.newInstance()
    val fis = new FileInputStream(xmlFilePath)
    val bis = new BufferedInputStream(fis, 64 * 1024)
    val reader = factory.createXMLStreamReader(bis)

    try {
      while (reader.hasNext) {
        val event = reader.next()
        if (event == XMLStreamConstants.START_ELEMENT) {
          val nodeName = reader.getLocalName
          if (filterNodes.isEmpty || filterNodes.contains(nodeName)) {
            nodeCounts(nodeName) = nodeCounts.getOrElse(nodeName, 0) + 1
          }
        }
      }
    } finally {
      reader.close()
      bis.close()
      fis.close()
    }
    nodeCounts.toMap
  }

  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      Console.err.println(
        "Usage: scala CountXMLNodes <path_to_xml_file> [node_name1 node_name2 ...]"
      )
      sys.exit(1)
    }

    val xmlFilePath = args(0)
    val filterNodes =
      if (args.length > 1) args.drop(1).toSet
      else Set.empty[String]

    try {
      val nodeCounts = countNodes(xmlFilePath, filterNodes)
      println("Node counts:")
      nodeCounts.foreach { case (node, count) =>
        println(s"$node: $count")
      }
    } catch {
      case e: Exception =>
        Console.err.println(s"Error processing XML file: ${e.getMessage}")
        sys.exit(1)
    }
  }
}
