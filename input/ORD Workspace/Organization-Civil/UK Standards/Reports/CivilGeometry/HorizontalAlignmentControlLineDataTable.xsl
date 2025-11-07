<?xml version="1.0" encoding="ISO-8859-2"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Variable to hold unit string -->
    <xsl:variable name="unit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">'</xsl:when>
            <xsl:otherwise>m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Control Line Data -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Control Line Data</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="//HorizontalAlignment">
                            <table border="1" cellpadding="2" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th colspan="12" lang="en" valign="middle">
                                            CONTROL LINE DATA - <xsl:value-of select="@name"/>
                                        </th>
                                    </tr>
                                    <tr style="font-size: 90%">
                                        <th lang="en" rowspan="2" valign="bottom">POINT<br/>ID</th>
                                        <th lang="en" rowspan="2" valign="bottom">BEARING</th>
                                        <th lang="en" rowspan="2" valign="bottom">
                                            DISTANCE<br/>
                                            <xsl:choose>
                                                <xsl:when test="//@linearUnits = 'Imperial'">(FEET)</xsl:when>
                                                <xsl:otherwise>(M)</xsl:otherwise>
                                            </xsl:choose>
                                        </th>
                                        <th lang="en" rowspan="2" valign="bottom">EASTING<br/>(X)</th>
										<th lang="en" rowspan="2" valign="bottom">NORTHING<br/>(Y)</th>
                                        <th colspan="3">&#xa0;</th>
                                        <th colspan="4">&#xa0;</th>
                                    </tr>
                                    <tr style="font-size: 90%">
                                        <th lang="en" valign="bottom">PC</th>
                                        <th lang="en" valign="bottom">PI</th>
                                        <th lang="en" valign="bottom">PT</th>
                                        <th lang="en" valign="bottom">DELTA</th>
                                        <th lang="en" valign="bottom">R</th>
                                        <th lang="en" valign="bottom">L</th>
                                        <th lang="en" valign="bottom">T</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="HorizontalElements">
                                        <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle"/>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                            <br style="line-height:200%"/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <!-- Horizontal Linear Data -->
    <xsl:template match="HorizontalLine">
        <xsl:if test="Start/@pointType = 'POB' or Start/@pointType = 'PI'">
            <tr style="font-size: 75%">
                <td class="sidepad" valign="middle">
                    <xsl:choose>
                        <xsl:when test="Start/@name">
                            <xsl:value-of select="Start/@name"/>
                        </xsl:when>
                        <xsl:otherwise>&#xa0;</xsl:otherwise>
                    </xsl:choose>
                </td>
                <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                    <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                </td>
                <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                    <xsl:choose>
                        <xsl:when test="following-sibling::*[1]/@tangentLengthStart">
                            <xsl:value-of select="cif:distanceFormat(number(@length + following-sibling::*[1]/@tangentLengthStart))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    &#xa0;<xsl:value-of select="$unit"/>
                </td>
                <td class="sidepad" align="right" valign="middle">
                    <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
                </td>
				<td class="sidepad" align="right" valign="middle">
                    <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
                </td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                    <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
            </tr>
        </xsl:if>
        <xsl:if test="position() = last()">
            <tr style="font-size: 75%">
                <td class="sidepad" valign="middle">
                    <xsl:choose>
                        <xsl:when test="End/@name">
                            <xsl:value-of select="End/@name"/>
                        </xsl:when>
                        <xsl:otherwise>&#xa0;</xsl:otherwise>
                    </xsl:choose>
                </td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
				<td class="sidepad" align="right" valign="middle">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                    <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
                <td class="sidepad" align="right" valign="middle">&#xa0;</td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- Horizontal Circular Data -->
    <xsl:template match="HorizontalCircle">
        <tr style="font-size: 75%">
                <td class="sidepad" valign="middle">
                    <xsl:choose>
                        <xsl:when test="PI/@name">
                            <xsl:value-of select="PI/@name"/>
                        </xsl:when>
                        <xsl:otherwise>&#xa0;</xsl:otherwise>
                    </xsl:choose>
                </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:choose>
                    <xsl:when test="not(following-sibling::*[2]/@direction)">
                        <xsl:choose>
                            <xsl:when test="following-sibling::*[3]/@tangentLength">
                                <xsl:value-of select="cif:distanceFormat(number(following-sibling::*[3]/@tangentLength + following-sibling::*[1]/@length + @tangentLength))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:distanceFormat(number(following-sibling::*[1]/@length + @tangentLength))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cif:distanceFormat(number(following-sibling::*[1]/@length + @tangentLength))"/>
                    </xsl:otherwise>
                </xsl:choose>
                &#xa0;<xsl:value-of select="$unit"/>
            </td>
            <td class="sidepad" align="right" valign="middle">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
            </td>
			<td class="sidepad" align="right" valign="middle">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td class="sidepad" align="right" valign="middle">&#xa0;</td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
            </td>
            <td class="sidepad" align="right" valign="middle">
                <xsl:value-of select="cif:angularFormat(number(@delta))"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:choose>
                    <xsl:when test="@rotationDirection = 'ccw'">
                        <xsl:value-of select="cif:distanceFormat(number(-1 * @radius))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                    </xsl:otherwise>
                </xsl:choose>
                &#xa0;<xsl:value-of select="$unit"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                &#xa0;<xsl:value-of select="$unit"/>
            </td>
            <td class="sidepad" align="right" nowrap="nowrap" valign="middle">
                <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
                &#xa0;<xsl:value-of select="$unit"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
