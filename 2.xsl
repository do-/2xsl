<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  
  <xsl:template match="processing-instruction()" mode="x">
    <xsl:element name="processing-instruction" namespace="http://www.w3.org/1999/XSL/Transform">
      <xsl:attribute name="name"><xsl:value-of select="name()"/></xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>      
  </xsl:template>

  <xsl:template match="text()" mode="x">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="@*" mode="x">
    <xsl:choose>
      <xsl:when test="starts-with(., '{')">
        <xsl:element name="attribute" namespace="http://www.w3.org/1999/XSL/Transform">
          <xsl:attribute name="name"><xsl:value-of select="name(.)" /></xsl:attribute>
          <xsl:value-of select="." />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="x">
    <xsl:copy>
      <xsl:apply-templates select="processing-instruction()|text()|@*|*" mode="x" />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="/">

    <xsl:element name="stylesheet" namespace="http://www.w3.org/1999/XSL/Transform">
      <xsl:attribute name="version">1.0</xsl:attribute>

      <xsl:element name="output" namespace="http://www.w3.org/1999/XSL/Transform">
        <xsl:attribute name="encoding">UTF-8</xsl:attribute>
        <xsl:attribute name="indent">yes</xsl:attribute>
      </xsl:element>      

      <xsl:element name="template" namespace="http://www.w3.org/1999/XSL/Transform">
        <xsl:attribute name="match">/</xsl:attribute>
        <xsl:apply-templates select="." mode="x" />
      </xsl:element>      

    </xsl:element>      
  
  </xsl:template>
  
</xsl:stylesheet>