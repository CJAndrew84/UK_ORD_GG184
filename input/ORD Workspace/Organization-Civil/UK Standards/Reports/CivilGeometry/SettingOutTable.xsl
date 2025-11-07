<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:variable name="unit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">ft</xsl:when>
            <xsl:otherwise>m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Setting Out Table</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads/GeometryProject/HorizontalAlignment">
                            <p lang="en"><u>PRINCIPLE SETTING OUT LINE FOR <xsl:value-of select="@name"/></u></p>
                            <table border="1" cellpadding="2" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th rowspan="2" valign="middle">POINT</th>
                                        <th rowspan="2" valign="middle">CHAINAGE (<xsl:value-of select="$unit"/>)</th>
                                        <th rowspan="2" valign="middle">X (<xsl:value-of select="$unit"/>)</th>
                                        <th rowspan="2" valign="middle">Y (<xsl:value-of select="$unit"/>)</th>
                                        <th rowspan="2" valign="middle">ELEMENT</th>
                                        <th rowspan="2" valign="middle">LENGTH (<xsl:value-of select="$unit"/>)</th>
                                        <th rowspan="2" valign="middle">WCB (0°00'00")<br/><span style="font-size: 75%">(STRAIGHT)</span></th>
                                        <th colspan="2" valign="middle">WCB (0°00'00")</th>
                                    </tr>
                                    <tr>
                                        <th style="font-size: 75%" valign="middle">(R=STARTING ANGLE)</th>
                                        <th style="font-size: 75%" valign="middle">(R=END ANGLE)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="HorizontalElements">
                                        <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <tr style="font-size: 75%">
            <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr style="font-size: 75%">
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td class="sidepad" align="center">STRAIGHT</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
            </td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <xsl:if test="End[@pointType = 'POE']">
            <tr style="font-size: 75%">
                <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <tr style="font-size: 75%">
            <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr style="font-size: 75%">
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <xsl:choose>
                <xsl:when test="@rotationDirection = 'ccw'">
                    <td align="center">
                        R = -<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td align="center">
                        R = +<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td>&#xa0;</td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
            </td>
        </tr>
        <xsl:if test="position() = last()">
            <tr style="font-size: 75%">
                <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <tr style="font-size: 75%">
            <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr style="font-size: 75%">
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td class="sidepad" align="center">SPIRAL</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td>&#xa0;</td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
            </td>
        </tr>
        <xsl:if test="position() = last()">
            <tr style="font-size: 75%">
                <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
               You must include at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
