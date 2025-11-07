<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:strip-space elements="*"/>
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
                    <xsl:text>* Profile Chainage Elevation Report (from Chainage Offset Points)&#xd;</xsl:text>
                    <xsl:text>* Report Created: </xsl:text><xsl:value-of select="cif:date()"/><xsl:text>&#xd;</xsl:text>

                    <xsl:for-each select="GeometryProject">
                        <xsl:text>* Project: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* File Name: </xsl:text><xsl:value-of select="@file"/><xsl:text>&#xd;</xsl:text>

                        <xsl:for-each select="HorizontalAlignment[StationOffsetPoints]">
                            <xsl:text>*&#xd;</xsl:text>
                            <xsl:text>* Alignment Name: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                            <xsl:text>*&#xd;</xsl:text>
                            <xsl:text>*      Chainage       Elevation&#xd;</xsl:text>
                            <xsl:text>*&#xd;</xsl:text>

                            <xsl:for-each select="StationOffsetPoints/StationOffsetPoint">
                                <xsl:variable name="fmtStation" select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                <xsl:if test="not (@offsetAlignmentName = preceding-sibling::*/@offsetAlignmentName)">
                                    <xsl:text>* Offset (Specified) Alignment:  </xsl:text><xsl:value-of select="@offsetAlignmentName"/><xsl:text>&#xd;</xsl:text>
                                </xsl:if>
                                <xsl:value-of select="cif:columnFormat(string($fmtStation), 14)"/>
                                <xsl:value-of select="cif:columnDoubleFormat(number(centerLinePoint/point/@elevation), 17)"/>
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
        <xsl:text>    You must create station offset points for this report&#xd;</xsl:text>
        <xsl:text>    by selecting either Tools &gt; XML Reports &gt; Station Base&#xd;</xsl:text>
        <xsl:text>    or Tools &gt; XML Reports &gt; Station Offset.&#xd;&#xd;</xsl:text>
        <xsl:text>    You must include at least one horizontal alignment or&#xd;</xsl:text>
        <xsl:text>    one feature on the General leaf in the From fields.&#xd;&#xd;</xsl:text>
        <xsl:text>    You must also include the same horizontal alignment on&#xd;</xsl:text>
        <xsl:text>    the Horizontal Alignments leaf or feature on the&#xd;</xsl:text>
        <xsl:text>    Features leaf.&#xd;&#xd;</xsl:text>
        <xsl:text>    You must choose at least one option on the Include leaf&#xd;</xsl:text>
        <xsl:text>    (Horizontal On-Alignment Points, Horizontal Event&#xd;</xsl:text>
        <xsl:text>    Points, Vertical On-Alignment Points, Vertical Event&#xd;</xsl:text>
        <xsl:text>    Points or Interval.)&#xd;&#xd;</xsl:text>
        <xsl:text>    Station Limits only apply to computed data, ie, event&#xd;</xsl:text>
        <xsl:text>    points by interval.&#xd;&#xd;</xsl:text>
        <xsl:text>    Most style sheets in the DataCollection directory do&#xd;</xsl:text>
        <xsl:text>    not honor Tools &gt; Format Options with the exception of&#xd;</xsl:text>
        <xsl:text>    precision, where practical.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
