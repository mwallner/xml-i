<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Whitespace-separated list of node names to filter; leave empty to count all -->
  <xsl:param name="filter" select="''"/>

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:variable name="filter-list" select="tokenize($filter, '\s+')" />

  <xsl:template match="/">
    <xsl:text>Node counts:</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:for-each-group select="//*" group-by="name()">
      <xsl:variable name="nodeName" select="current-grouping-key()" />
      <xsl:if test="empty($filter-list) or $nodeName = $filter-list">
        <xsl:value-of select="$nodeName"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="count(current-group())"/>
        <xsl:text>&#10;</xsl:text>
      </xsl:if>
    </xsl:for-each-group>
  </xsl:template>
</xsl:stylesheet>
