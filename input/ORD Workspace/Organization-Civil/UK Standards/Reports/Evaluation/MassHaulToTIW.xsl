<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:variable name="cubicFactor">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">
                <xsl:choose>
                    <xsl:when test="$xslConvertToCY = 1">27</xsl:when>
                    <xsl:otherwise>1</xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Mass Haul ASCII Import Format -->
    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <xsl:for-each select="InRoads">
            <xsl:text/>
            <xsl:for-each select="CrossSectionSet">
                <xsl:text>*         </xsl:text>
                <xsl:value-of select="cif:columnFormat('Station', 16)"/>
                <xsl:value-of select="cif:columnFormat('Elevation', 16)"/>
                <xsl:for-each select="CrossSectionStations">
                    <xsl:apply-templates/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="CrossSectionStation">
        <xsl:value-of select="cif:columnDoubleFormat(number(Station/@internalStation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(StationVolume/@massOrdinate div $cubicFactor), 4, 16)"/>
    </xsl:template>
</xsl:stylesheet>
