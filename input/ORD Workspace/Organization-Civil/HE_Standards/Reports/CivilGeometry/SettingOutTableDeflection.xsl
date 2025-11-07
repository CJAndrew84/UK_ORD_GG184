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
                <title lang="en">Setting Out Table Expanded</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads/GeometryProject/HorizontalAlignment">
                            <p lang="en"><strong>Alignment:&#xa0; <xsl:value-of select="@name"/></strong></p>
                            <table border="1" cellpadding="2" cellspacing="0" width="100%">
                                <thead style="display:table-header-group">
                                    <tr>
                                        <th lang="en" valign="bottom">CURVE<br/>NAME</th>
                                        <th lang="en" valign="bottom">POINT</th>
                                        <th lang="en" valign="bottom">CHAINAGE<br/>(<xsl:value-of select="$unit"/>)</th>
                                        <th lang="en" valign="bottom">X<br/>(<xsl:value-of select="$unit"/>)</th>
                                        <th lang="en" valign="bottom">Y<br/>(<xsl:value-of select="$unit"/>)</th>
                                        <th lang="en" valign="bottom">ELEMENT</th>
                                        <th lang="en" valign="bottom">LENGTH<br/>(<xsl:value-of select="$unit"/>)</th>
                                        <th lang="en" valign="bottom">DEFLECTION<br/>ANGLE</th>
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
        <tr style="font-size: 75%;">
            <td>&#xa0;</td>
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
        </tr>
        <tr style="font-size: 75%;">
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td class="sidepad" align="center">STRAIGHT</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <xsl:choose>
                <xsl:when test="position() != 1 and preceding-sibling::*[1][name() = 'HorizontalLine']">
                    <td class="sidepad" align="left" nowrap="nowrap">
                        <xsl:choose>
                            <xsl:when test="//TraversePoint/@easting = current()/Start/@easting and //TraversePoint/@northing = current()/Start/@northing and //TraversePoint/@pointType = current()/Start/@pointType">
                                <xsl:choose>
                                    <xsl:when test="//TraversePoint[@easting = current()/Start/@easting and @northing = current()/Start/@northing and @pointType = current()/Start/@pointType]/../@deflection &lt; 0">
                                        <xsl:value-of select="cif:angularFormat(number(-1 * //TraversePoint[@easting = current()/Start/@easting and @northing = current()/Start/@northing and @pointType = current()/Start/@pointType]/../@deflection))"/> Left
                                    </xsl:when>
                                    <xsl:when test="//TraversePoint[@easting = current()/Start/@easting and @northing = current()/Start/@northing and @pointType = current()/Start/@pointType]/../@deflection &gt; 0">
                                        <xsl:value-of select="cif:angularFormat(number(//TraversePoint[@easting = current()/Start/@easting and @northing = current()/Start/@northing and @pointType = current()/Start/@pointType]/../@deflection))"/> Right
                                    </xsl:when>
                                    <xsl:otherwise>&#xa0;</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>&#xa0;</xsl:otherwise>
                        </xsl:choose>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td>&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
        <xsl:if test="End[@pointType = 'POE']">
            <tr style="font-size: 75%;">
                <td>&#xa0;</td>
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
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:if test="//CurvesetPoint/@curveSetStartElement = current()/@elementNumber">
            <tr style="font-size: 75%;">
                <td>&#xa0;</td>
                <td class="sidepad" align="center">
                    <xsl:value-of select="cif:pointType(string(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@pointType))"/>
                </td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/station/@externalStation), string(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@easting))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@northing))"/>
                </td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td class="sidepad" align="left" nowrap="nowrap">
                    <xsl:value-of select="cif:angularFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/@delta))"/>
                    <xsl:choose>
                        <xsl:when test="@rotationDirection = 'ccw'"> Left</xsl:when>
                        <xsl:otherwise> Right</xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </xsl:if>
        <tr style="font-size: 75%;">
            <td>&#xa0;</td>
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
        </tr>
        <tr style="font-size: 75%;">
            <xsl:choose>
                <xsl:when test="//CurvesetPoint/@curveSetStartElement &lt;= current()/@elementNumber and //CurvesetPoint/@curveSetStopElement &gt;= current()/@elementNumber">
                    <td class="sidepad" align="center">
                        <xsl:value-of select="//CurvesetPoint[@curveSetStartElement &lt;= current()/@elementNumber][@curveSetStopElement &gt;= current()/@elementNumber]/@curveSetID"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>&#xa0;</xsl:otherwise>
            </xsl:choose>
            <td class="sidepad" align="center"><xsl:value-of select="cif:pointType(string(Center/@pointType))"/></td>
            <td>&#xa0;</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@easting))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@northing))"/>
            </td>
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
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:if test="//CurvesetPoint/@curveSetStartElement = current()/@elementNumber">
            <tr style="font-size: 75%;">
                <td>&#xa0;</td>
                <td class="sidepad" align="center">
                    <xsl:value-of select="cif:pointType(string(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@pointType))"/>
                </td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/station/@externalStation), string(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/station/@externalStationName))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@easting))"/>
                </td>
                <td class="sidepad" align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/GeometryPoint/@northing))"/>
                </td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td class="sidepad" align="left" nowrap="nowrap">
                    <xsl:value-of select="cif:angularFormat(number(//CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/@delta))"/>
                    <xsl:choose>
                        <xsl:when test="@rotationDirection = 'ccw'"> Left</xsl:when>
                        <xsl:otherwise> Right</xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </xsl:if>
        <tr style="font-size: 75%;">
            <td>&#xa0;</td>
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
        </tr>
        <tr style="font-size: 75%;">
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td class="sidepad" align="center">SPIRAL</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td>&#xa0;</td>
        </tr>
        <xsl:if test="position() = last()">
            <tr style="font-size: 75%;">
                <td>&#xa0;</td>
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
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="normal1" lang="en">
                This report is not suitable for some complex curve combinations; One example of such a curve is the 
                SPIRAL-CURVE-SPIRAL-CURVE-SPIRAL-CURVE-SPIRAL combination.&#xa0; There are other complex 
                combinations which may also not produce a suitable report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
