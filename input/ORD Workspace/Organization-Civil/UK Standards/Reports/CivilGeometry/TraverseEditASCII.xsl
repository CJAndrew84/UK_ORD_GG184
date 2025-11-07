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
            <xsl:otherwise>ha</xsl:otherwise>
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
                    <xsl:text>Traverse Edit Report&#xd;&#xd;</xsl:text>

                    <xsl:for-each select="GeometryProject">
                        <xsl:text>Project:     </xsl:text><xsl:value-of select="@name"/>

                        <xsl:for-each select="HorizontalAlignment">
                            <xsl:text>&#xd;Alignment:   </xsl:text><xsl:value-of select="@name"/>
                            <xsl:text>&#xd;Description: </xsl:text><xsl:value-of select="@description"/>
                            <xsl:text>&#xd;&#xd;</xsl:text>
                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle"/>
                            <xsl:if test="@eastingClosingError">
                                <xsl:text>X Error:    </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@eastingClosingError))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Y Error:     </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@northingClosingError))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Closing Direction: </xsl:text>
                                <xsl:value-of select="cif:directionFormat(number(@closingDirection))"/>
                                <xsl:text>&#xd;Closing Distance:  </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@closingDistance))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Closed Area:       </xsl:text>
                                <xsl:value-of select="cif:areaFormat(number(@area))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$areaUnit1"/>
                                <xsl:text> (</xsl:text>
                                <xsl:choose>
                                    <xsl:when test="//@linearUnits = 'Imperial'">
                                        <td align="right">
                                            <xsl:value-of select="cif:areaFormat(number(@area div 43560))"/>
                                        </td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td align="right">
                                            <xsl:value-of select="cif:areaFormat(number(@area div 10000))"/>
                                        </td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:text> </xsl:text><xsl:value-of select="$areaUnit2"/><xsl:text>)</xsl:text>
                                <xsl:text>&#xd;Perimeter:         </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@perimeter))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Precision:         </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@closingPrecision))"/>
                                <xsl:text>&#xd;</xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 6)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 8)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 41)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@elevation), 13)"/>
        <xsl:text>&#xd; </xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@direction))), 22)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 6)"/>
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 8)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 41)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 16)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@elevation), 13)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 6)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 8)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 41)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@elevation), 13)"/>
        <xsl:text>&#xd;       Radius:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 28)"/>
        <xsl:text>&#xd;       Delta:</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:angularFormat(number(@delta))), 30)"/>
        <xsl:text>&#xd;       Length:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 28)"/>
        <xsl:if test="@tangentLength != -1.">
            <xsl:text>&#xd;       Chord:</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(@chord), 29)"/>
            <xsl:text>&#xd;       Tangent:</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(@tangentLength), 27)"/>
            <xsl:text>&#xd;       Middle Ordinate:</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(@middleOrdinate), 19)"/>
            <xsl:text>&#xd;       External:</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(@externalDistance), 26)"/>
            <xsl:text>&#xd;       </xsl:text>
            <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
            <xsl:text> (Radial)</xsl:text>
        </xsl:if>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Center/@pointType)), 6)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="Center/@name">
                <xsl:value-of select="cif:columnFormat(string(Center/@name), 8)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@easting), 41)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@northing), 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@elevation), 13)"/>
        <xsl:text>&#xd;       </xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
        <xsl:text> (Chord )</xsl:text>
        <xsl:text>&#xd;       </xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
        <xsl:text> (Radial)&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 6)"/>
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 8)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('    ', '    ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 41)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 16)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@elevation), 13)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>    You must select at least one Civil horizontal element&#xd;</xsl:text>
        <xsl:text>to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>    Note:  This report is NOT SUITABLE for alignments&#xd;</xsl:text>
        <xsl:text>    containing spirals.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
