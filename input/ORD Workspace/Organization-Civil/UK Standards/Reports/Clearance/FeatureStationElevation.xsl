<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Feature Station Elevation Report -->
    <xsl:variable name="uniqueClearanceAlignments" select="//ClearancePoints/ClearancePoint[not(@clearanceAlignmentName = preceding-sibling::ClearancePoint/@clearanceAlignmentName )]/@clearanceAlignmentName "/>
    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <xsl:choose>
            <xsl:when test="$xslShowHelp = 'true'">
                <xsl:call-template name="StyleSheetHelp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="InRoads/GeometryProject">
                    <xsl:text/>
                    <xsl:text>Station Elevation Report&#xd;&#xd;</xsl:text>
                    <xsl:for-each select="$uniqueClearanceAlignments">
                        <xsl:value-of select="."/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>     Chainage           Elevation&#xd;</xsl:text>
                        <xsl:text>     ---------         -----------&#xd;&#xd;</xsl:text>
                        <xsl:for-each select="//ClearancePoint[@clearanceAlignmentName = current()]">
                            <xsl:sort select="centerLinePoint/point/station/@internalStation" data-type="number"/>
                            <xsl:sort select="@firstOffset" data-type="number"/>
                            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName)), 14)"/>
                            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(offsetPoint/@elevation)), 20)"/>
                            <xsl:text>&#xd;</xsl:text>
                        </xsl:for-each>
                        <xsl:text>&#xd;</xsl:text>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>    You must create clearance points for this report by&#xd;</xsl:text>
        <xsl:text>    selecting Tools &gt; XML Reports &gt; Clearance.&#xd;&#xd;</xsl:text>
        <xsl:text>    You must include at least one horizontal alignment or&#xd;</xsl:text>
        <xsl:text>    feature on the General leaf in the From fields.&#xd;&#xd;</xsl:text>
        <xsl:text>    You must also include at least one feature on the&#xd;</xsl:text>
        <xsl:text>    Features leaf.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
