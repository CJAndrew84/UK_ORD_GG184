<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <xsl:choose>
            <xsl:when test="$xslShowHelp = 'true'">
                <xsl:call-template name="StyleSheetHelp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="InRoads">
                    <xsl:text/>
                    <xsl:text>* Profile Chainage Elevation Report (from Vertical Alignment)&#xd;</xsl:text>
                    <xsl:text>*       Report Created: </xsl:text><xsl:value-of select="cif:date()"/><xsl:text>&#xd;</xsl:text>

                    <xsl:for-each select="GeometryProject">
                        <xsl:text>*              Project: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>*            File Name: </xsl:text><xsl:value-of select="@file"/><xsl:text>&#xd;</xsl:text>

                        <xsl:for-each select="HorizontalAlignment[HorizontalEventPoints]">
                            <xsl:text>* Horizontal Alignment: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                            <xsl:for-each select="VerticalAlignment">
                                <xsl:text>*   Vertical Alignment: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                                <xsl:text>*&#xd;</xsl:text>
                            </xsl:for-each>
                            <xsl:text>*    Chainage       Elevation&#xd;</xsl:text>
                            <xsl:text>*&#xd;</xsl:text>
                            <xsl:for-each select="HorizontalEventPoints/*/HorizontalEventPoint">
                                <xsl:variable name="fmtStation" select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                                <xsl:value-of select="cif:columnFormat(string($fmtStation), 12)"/>
                                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@elevation), 17)"/>
                                <xsl:text>&#xd;</xsl:text>
                            </xsl:for-each>
                            <xsl:text>&#xd;</xsl:text>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>You must select at least one Civil vertical geometry element </xsl:text>
        <xsl:text>to get results from this report.   &#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
