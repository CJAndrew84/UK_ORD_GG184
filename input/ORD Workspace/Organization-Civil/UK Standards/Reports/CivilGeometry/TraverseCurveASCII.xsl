<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="linearUnit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">ft</xsl:when>
            <xsl:otherwise>m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="areaUnit1">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">sq ft</xsl:when>
            <xsl:otherwise>sq m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="areaUnit2">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">ac</xsl:when>
            <xsl:otherwise>hec</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

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

                    <xsl:text>                        Traverse with Curve Data Report&#xd;&#xd;</xsl:text>
                    <xsl:value-of select="cif:date()"/>
                    <xsl:text>&#xd;</xsl:text>

                    <xsl:for-each select="GeometryProject">
                        <xsl:text>   Project: </xsl:text>
                        <xsl:value-of select="@name"/>

                        <xsl:for-each select="HorizontalAlignment">
                            <xsl:text>&#xd; Alignment: </xsl:text>
                            <xsl:value-of select="@name"/>
                            <xsl:text>&#xd;&#xd;</xsl:text>
                            <xsl:text>OCCUPIED    BEARING        DISTANCE         X             Y        ELEVATION&#xd;</xsl:text>
                            <xsl:text>--------    -------        --------   ------------  ------------  ------------&#xd;&#xd;</xsl:text>
                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                            <xsl:if test="@area &gt; 0">
                                <xsl:text>&#xd;AREA   (</xsl:text><xsl:value-of select="$areaUnit1"/><xsl:text>) = </xsl:text><xsl:value-of select="cif:columnDoubleFormat(number(@area), 12)"/>
                                <xsl:choose>
                                    <xsl:when test="//@linearUnits = 'Imperial'">
                                        <xsl:text>&#xd;AREA      (</xsl:text><xsl:value-of select="$areaUnit2"/><xsl:text>) = </xsl:text><xsl:value-of select="cif:columnDoubleFormat(number(@area div 43560), 12)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>&#xd;AREA    (</xsl:text><xsl:value-of select="$areaUnit2"/><xsl:text>) = </xsl:text><xsl:value-of select="cif:columnDoubleFormat(number(@area div 10000), 12)"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text>&#xd;PERIMETER (</xsl:text><xsl:value-of select="$linearUnit"/><xsl:text>) = </xsl:text><xsl:value-of select="cif:columnDoubleFormat(number(@perimeter), 12)"/>
                            </xsl:if>
                            <xsl:text>&#xd;</xsl:text>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 7)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 26)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 14)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@elevation), 14)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@direction))), 22)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 13)"/>
        <xsl:text>&#xd;&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 7)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 26)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 17)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 14)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@elevation), 14)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 7)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 26)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 14)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@elevation), 14)"/>
        <xsl:text>&#xd;         Delta:</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:angularFormat(number(@delta))), 16)"/>
        <xsl:text>&#xd;        Radius:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 14)"/>
        <xsl:text>&#xd;           Arc:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 14)"/>
        <xsl:text>&#xd;         Chord:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@chord), 14)"/>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@chordDirection))), 16)"/>
        <xsl:text>&#xd;       Tangent:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@tangentLength), 14)"/>
        <xsl:text>&#xd;&#xd;</xsl:text>
        <xsl:choose>
            <xsl:when test="Center/@name">
                <xsl:value-of select="cif:columnFormat(string(Center/@name), 7)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>  Radius Point:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@easting), 28)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@northing), 14)"/>
        <xsl:text>&#xd;&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 7)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 26)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 17)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 14)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@elevation), 14)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 7)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 26)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 14)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@elevation), 14)"/>
        <xsl:text>&#xd;  Start Radius:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@startRadius), 14)"/>
        <xsl:text>&#xd;    End Radius:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@endRadius), 14)"/>
        <xsl:text>&#xd;       Tangent:</xsl:text>
        <xsl:choose>
            <xsl:when test="@compound = 'false'">
                <xsl:choose>
                    <xsl:when test="@startRadius &gt; @endRadius">
                        <xsl:value-of select="cif:columnDoubleFormat(number(@shortTangent), 14)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cif:columnDoubleFormat(number(@longTangent), 14)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@startRadius &gt; @endRadius">
                        <xsl:value-of select="cif:columnDoubleFormat(number(@longTangent), 14)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cif:columnDoubleFormat(number(@shortTangent), 14)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#xd;&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 7)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 26)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 17)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 14)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@elevation), 14)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
       <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>    You must select at least one Civil horizontal element&#xd;</xsl:text>
        <xsl:text>    to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
