<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:strip-space elements="*"/>
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <!-- Variables to hold unit strings -->
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
    <!-- Variables to hold Direction Method, Format, Precision and Mode -->
    <xsl:variable name="mapCheckAngularMethod">
        <xsl:choose>
            <xsl:when test="//@angularUnits = 'Grads'">2</xsl:when>
            <xsl:when test="//@angularUnits = 'Radians'">3</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="mapCheckAngularFormat">
        <xsl:choose>
            <xsl:when test="//@directionFormat = 'Decimal Degrees'">2</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="mapCheckDirectionFormat">
        <xsl:choose>
            <xsl:when test="//@directionFormat = 'Decimal Degrees'">2</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="mapCheckDirectionModeFormat">
        <xsl:choose>
            <xsl:when test="//@directionMode = 'North Bearing'">2</xsl:when>
            <xsl:when test="//@directionMode = 'North Azimuth'">3</xsl:when>
            <xsl:when test="//@directionMode = 'South Azimuth'">4</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Map Check ASCII Report -->
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
                    <!-- Report Title -->
                    <xsl:text>Map Check Report&#xd;&#xd;</xsl:text>
                    <!-- Project Data -->
                    <xsl:for-each select="GeometryProject">
                        <xsl:text>Project:     </xsl:text><xsl:value-of select="@name"/>
                        <!-- Horizontal Alignment Data -->
                        <xsl:for-each select="HorizontalAlignment">
                            <xsl:text>&#xd;Alignment:   </xsl:text><xsl:value-of select="@name"/>
                            <xsl:text>&#xd;Description: </xsl:text><xsl:value-of select="@description"/>
                            <xsl:text>&#xd;&#xd;</xsl:text>
                            <xsl:text> Type      Point Name\                             X               Y         Elevation&#xd;</xsl:text>
                            <xsl:text>             Direction              Length&#xd;</xsl:text>
                            <xsl:text>-----  ---------------  ------------------  ---------------  --------------  ----------&#xd;</xsl:text>
                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle"/>
                            <xsl:if test="@northingClosingError">
                                <xsl:text>X/Easting Error:    </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@eastingClosingError))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Y/Northing Error:     </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@northingClosingError))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Closing Direction: </xsl:text>
                                <xsl:value-of select="cif:directionFormat(number(@closingDirection))"/>
                                <xsl:text>&#xd;Closing Distance:  </xsl:text>
                                <xsl:value-of select="cif:distanceFormat(number(@closingDistance))"/>
                                <xsl:text> </xsl:text><xsl:value-of select="$linearUnit"/>
                                <xsl:if test="@area">
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
                                </xsl:if>
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
    <!-- Horizontal Line Data -->
    <xsl:template match="HorizontalLine">
        <xsl:value-of select="cif:columnFormat(string(Start/@type), 6)"/>
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
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@direction))), 21)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:value-of select="cif:columnFormat(string(End/@type), 6)"/>
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
    <!-- Horizontal Circle Data -->
    <xsl:template match="HorizontalCircle">
        <xsl:value-of select="cif:columnFormat(string(Start/@type), 6)"/>
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
        <xsl:value-of select="cif:columnFormat(string(Center/@type), 6)"/>
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
        <xsl:text> (Chord)</xsl:text>
        <xsl:text>&#xd;       </xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
        <xsl:text> (Radial)&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:value-of select="cif:columnFormat(string(End/@type), 6)"/>
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
        <xsl:text>    This report may be used with data from the Geometry &gt;&#xd;</xsl:text>
        <xsl:text>    Utilities &gt; Traverse Edit command or the Tools &gt;&#xd;</xsl:text>
        <xsl:text>    XML Reports &gt; Map Check command.&#xd;&#xd;</xsl:text>
        <xsl:text>    To use the Traverse Edit command, first select Tools &gt;&#xd;</xsl:text>
        <xsl:text>    Application Add-Ins and toggle on the Traverse Edit&#xd;</xsl:text>
        <xsl:text>    Add-In.  Generate the data by selecting the Map Check&#xd;</xsl:text>
        <xsl:text>    button.&#xd;&#xd;</xsl:text>
        <xsl:text>    If you are using the Map Check reports command, you&#xd;</xsl:text>
        <xsl:text>    must include at least one horizontal alignment in the&#xd;</xsl:text>
        <xsl:text>    Include field on the Tools &gt; XML Reports &gt; Map Check&#xd;</xsl:text>
        <xsl:text>    command to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>    Note:  Most of the linear and direction values in the&#xd;</xsl:text>
        <xsl:text>    body of this report do not use the settings from the&#xd;</xsl:text>
        <xsl:text>    Tools &gt; Format Options command on the Report Browser&#xd;</xsl:text>
        <xsl:text>    menu.  Only the Northing/Easting values and the values&#xd;</xsl:text>
        <xsl:text>    in the footer use these settings.  If you are using the&#xd;</xsl:text>
        <xsl:text>    Traverse Edit command, the precision settings for&#xd;</xsl:text>
        <xsl:text>    linear and direction values in the body of the report&#xd;</xsl:text>
        <xsl:text>    come from the Tools &gt; Options as do the direction&#xd;</xsl:text>
        <xsl:text>    format and mode.  If you are using the Map Check&#xd;</xsl:text>
        <xsl:text>    reports command, the precision settings for linear and&#xd;</xsl:text>
        <xsl:text>    direction values in the body of the report come from&#xd;</xsl:text>
        <xsl:text>    the Tools &gt; XML Reports &gt; Map Check command and the&#xd;</xsl:text>
        <xsl:text>    direction format and mode, again, come from the Tools &gt;&#xd;</xsl:text>
        <xsl:text>    Options command.&#xd;&#xd;</xsl:text>
        <xsl:text>    Note:  This report is not suitable for alignments&#xd;</xsl:text>
        <xsl:text>    containing spirals.&#xd;&#xd;</xsl:text>
        <xsl:text>Civil Tools Note&#xd;&#xd;</xsl:text>
        <xsl:text>    The precision settings for linear and direction values in&#xd;</xsl:text>
        <xsl:text>    the body of the report come from the Design File Settings.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
