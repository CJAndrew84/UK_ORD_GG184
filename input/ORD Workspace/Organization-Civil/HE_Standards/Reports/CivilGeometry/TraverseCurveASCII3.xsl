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

                    <xsl:text>                        Traverse Report&#xd;</xsl:text>
                    <xsl:text>            Report Created:  </xsl:text>
                    <xsl:value-of select="cif:date()"/>
                    <xsl:text> Time:  </xsl:text>
                    <xsl:value-of select="cif:time()"/>
                    <xsl:text>&#xd;&#xd;</xsl:text>

                    <xsl:for-each select="GeometryProject">
                        <xsl:text>Project:  </xsl:text><xsl:value-of select="@name"/>
                        <xsl:text>&#xd;Description:  </xsl:text><xsl:value-of select="@description"/>
                        <xsl:text>&#xd;File Name:  </xsl:text><xsl:value-of select="@file"/>
                        <xsl:text>&#xd;Last Revised:  </xsl:text>
                        <xsl:value-of select="@lastRevisedBy"/><xsl:text> </xsl:text>
                        <xsl:value-of select="@lastRevisedDate"/>
                        <xsl:text>  Note:  All units in this report are in</xsl:text>
                        <xsl:choose>
                            <xsl:when test="//@linearUnits = 'Metric'"> meters </xsl:when>
                            <xsl:otherwise> feet </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>unless specified otherwise.&#xd;</xsl:text>

                        <xsl:for-each select="HorizontalAlignment">
                            <xsl:text>&#xd;Alignment Name:  </xsl:text>
                            <xsl:value-of select="@name"/>
                            <xsl:text>&#xd;Alignment Description:  </xsl:text>
                            <xsl:value-of select="@description"/>
                            <xsl:text>&#xd;&#xd;</xsl:text>
                            <xsl:text>                                           - - C o o r d i n a t e s - -&#xd;</xsl:text>
                            <xsl:text>Point        Bearing          Distance     X                  Y         &#xd;</xsl:text>
                            <xsl:text>----------   -------------    --------     -----------        -----------&#xd;</xsl:text>
                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                            <xsl:text>&#xd;</xsl:text>
                            <xsl:if test="@eastingClosingError">
                                <xsl:text>Northing Error:  </xsl:text>
                                <xsl:value-of select="cif:columnDoubleFormat(number(@eastingClosingError), 12)"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$linearUnit"/>
                                <xsl:text>     Easting Error:  </xsl:text>
                                <xsl:value-of select="cif:columnDoubleFormat(number(@northingClosingError), 15)"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Closing Direction:  </xsl:text>
                                <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@closingDirection))), 12)"/>
                                <xsl:text>     Closing Distance:  </xsl:text>
                                <xsl:value-of select="cif:columnDoubleFormat(number(@closingDistance), 12)"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$linearUnit"/>
                                <xsl:text>&#xd;Precision:  </xsl:text>
                                <xsl:value-of select="cif:columnDoubleFormat(number(@closingPrecision), 17)"/>
                            </xsl:if>
                            <xsl:text>&#xd;</xsl:text>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <xsl:if test="position() = 1">
            <xsl:text>Start - </xsl:text>
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 3)"/>
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <xsl:value-of select="cif:columnFormat(string(Start/@name), 4)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 36)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 19)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 3)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="End/@name">
                <xsl:value-of select="cif:columnFormat(string(End/@name), 4)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@direction))), 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 11)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 19)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:if test="position() = 1">
            <xsl:text>Start - </xsl:text>
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 3)"/>
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <xsl:value-of select="cif:columnFormat(string(Start/@name), 4)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 36)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 19)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Center/@pointType)), 3)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="Center/@name">
                <xsl:value-of select="cif:columnFormat(string(Center/@name), 4)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@radialDirectionStart))), 16)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 11)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Center/@northing), 19)"/>
        <xsl:text>&#xd;      Delta:</xsl:text>
        <xsl:value-of select="cif:columnFormat(string(cif:angularFormat(number(@delta))), 11)"/>
        <xsl:choose>
            <xsl:when test="@rotationDirection = 'ccw'"><xsl:text>  Left</xsl:text></xsl:when>
            <xsl:otherwise><xsl:text> Right</xsl:text></xsl:otherwise>
        </xsl:choose>
        <xsl:text>  Radius:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 9)"/>
        <xsl:text>      Length:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@length), 10)"/>
        <xsl:text>&#xd;      Tangent:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@tangentLength), 9)"/>
        <xsl:text>        Chord:</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(@chord), 10)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 3)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="End/@name">
                <xsl:value-of select="cif:columnFormat(string(End/@name), 4)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnFormat(string(cif:directionFormat(number(@radialDirectionEnd))), 16)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(@radius), 11)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 17)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 19)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)), 3)"/>
        <xsl:text> (</xsl:text>
        <xsl:choose>
            <xsl:when test="Start/@name">
                <xsl:value-of select="cif:columnFormat(string(Start/@name), 4)"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@easting), 44)"/>
        <xsl:value-of select="cif:columnDoubleFormat(number(Start/@northing), 19)"/>
        <xsl:text>&#xd;&#xd;</xsl:text>
        <xsl:if test="position() = last()">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)), 3)"/>
            <xsl:text> (</xsl:text>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <xsl:value-of select="cif:columnFormat(string(End/@name), 4)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="concat('  ', '  ')"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@easting), 44)"/>
            <xsl:value-of select="cif:columnDoubleFormat(number(End/@northing), 19)"/>
            <xsl:text>&#xd;&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>You must select at least one Civil horizontal element&#xd;</xsl:text>
        <xsl:text>to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
