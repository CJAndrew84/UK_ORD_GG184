<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>

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
                    <xsl:for-each select="HorizontalAlignment/VerticalAlignment">
                        <xsl:text>*         </xsl:text>
                        <xsl:value-of select="cif:columnFormat('Station', 16)"/>
                        <xsl:value-of select="cif:columnFormat('Elevation', 16)"/>
                        <xsl:choose>
                            <xsl:when test="//VerticalCircle">
                                <xsl:value-of select="cif:columnFormat('Radius', 16)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:columnFormat('Length', 16)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:for-each select="VerticalElements">
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="VerticalLine">
        <xsl:choose>
            <xsl:when test="VerticalStart/@pointType = 'POB'">
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalStart/station/@internalStation), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalStart/@elevation), 4, 16)"/>
            </xsl:when>
            <xsl:when test="VerticalStart/@pointType = 'PVI'">
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalStart/station/@internalStation), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalStart/@elevation), 4, 16)"/>
            </xsl:when>
            <xsl:when test="VerticalEnd/@pointType = 'POE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalEnd/station/@internalStation), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(VerticalEnd/@elevation), 4, 16)"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="VerticalSymmetricalParabola">
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/station/@internalStation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/@elevation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@verticalCurveLength), 4, 16)"/>
    </xsl:template>

    <xsl:template match="VerticalUnsymmetricalParabola">
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/station/@internalStation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/@elevation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@startVerticalCurveLength + @endVerticalCurveLength), 4, 16)"/>
    </xsl:template>

    <xsl:template match="VerticalCircle">
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/station/@internalStation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(PVI/@elevation), 4, 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 4, 16)"/>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
