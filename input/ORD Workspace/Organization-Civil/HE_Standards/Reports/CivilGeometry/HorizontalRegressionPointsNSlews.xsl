<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif" xmlns:inr="inr">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:variable name="slewDiagramMax">
        <xsl:for-each select="//RegressionPoints/RegressionPoint">
            <xsl:sort select="@slew" data-type="number"/>
            <xsl:if test="position() = last()">
                <xsl:value-of select="@slew"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="slewDiagramMin">
        <xsl:for-each select="//RegressionPoints/RegressionPoint">
            <xsl:sort select="@slew" data-type="number"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="@slew"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="slewRange">
        <xsl:choose>
            <xsl:when test="$slewDiagramMax &gt;= (-1 * $slewDiagramMin)">
                <xsl:value-of select="$slewDiagramMax"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="-1 * $slewDiagramMin"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Horizontal Regression Points and Slews Review Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Horizontal Regression Points and Slews Review Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>

                            <xsl:for-each select="GeometryProject">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@name"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@description"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@file"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>

                                <xsl:for-each select="HorizontalAlignment">
                                    <table class="margin" width="90%">
                                        <thead>
                                            <tr>
                                                <th align="right" lang="en" width="30%">Alignment Name:&#xa0; </th>
                                                <td align="left" width="70%">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" lang="en">Alignment Description:&#xa0; </th>
                                                <td align="left">
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="2">&#xa0;</td>
                                            </tr>
                                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                        </tbody>
                                    </table>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <tr>
            <td colspan="2">
                <table width="80%">
                    <colgroup span="5">
                        <col width="18%"/>
                        <col width="13%"/>
                        <col width="25%"/>
                        <col width="22%"/>
                        <col width="22%"/>
                    </colgroup>
                    <tr>
                        <th />
                        <th />
                        <th align="right" class="underline" lang="en">Chainage</th>
                        <th align="right" class="underline" lang="en">X</th>
                        <th align="right" class="underline" lang="en">Y</th>
                    </tr>
                    <tr>
                        <td align="left" colspan="5" lang="en">Type:&#xa0; Linear</td>
                    </tr>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="Start/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="Start/@name">
                                <td align="right">
                                    (<xsl:value-of select="Start/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
                        </td>
                    </tr>
                    <xsl:if test="StationEquation">
                        <xsl:for-each select="StationEquation">
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNBK</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNAHD</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:if>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="End/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="End/@name">
                                <td align="right">
                                    (<xsl:value-of select="End/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangential Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangential Length:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <tr>
            <td colspan="2">
                <table width="80%">
                    <colgroup span="5">
                        <col width="18%"/>
                        <col width="13%"/>
                        <col width="25%"/>
                        <col width="22%"/>
                        <col width="22%"/>
                    </colgroup>
                    <tr>
                        <th />
                        <th />
                        <th align="right" class="underline" lang="en">Chainage</th>
                        <th align="right" class="underline" lang="en">X</th>
                        <th align="right" class="underline" lang="en">Y</th>
                    </tr>
                    <tr>
                        <td align="left" colspan="5" lang="en">Type:&#xa0; Circular</td>
                    </tr>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="Start/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="Start/@name">
                                <td align="right">
                                    (<xsl:value-of select="Start/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
                        </td>
                    </tr>
                    <xsl:if test="PI">
                        <tr>
                            <td align="right">
                                <xsl:value-of select="PI/@type"/>
                            </td>
                            <xsl:choose>
                                <xsl:when test="PI/@name">
                                    <td align="right">
                                        (<xsl:value-of select="PI/@name"/>)
                                    </td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <td align="right">
                                <xsl:value-of select="cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
                            </td>
                        </tr>
                    </xsl:if>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="Center/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="Center/@name">
                                <td align="right">
                                    (<xsl:value-of select="Center/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td />
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Center/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Center/@northing))"/>
                        </td>
                    </tr>
                    <xsl:if test="StationEquation">
                        <xsl:for-each select="StationEquation">
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNBK</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNAHD</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:if>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="End/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="End/@name">
                                <td align="right">
                                    (<xsl:value-of select="End/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Radius:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Delta:</td>
                        <td align="right">
                            <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                        </td>
                        <td align="left" lang="en">
                            <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
                            <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">
                            <xsl:choose>
                                <xsl:when test="@curvatureDefinition = 'arc'">
                                    Degree of Curvature (Arc):
                                </xsl:when>
                                <xsl:when test="@curvatureDefinition = 'chord'">
                                    Degree of Curvature (Chord):
                                </xsl:when>
                                <xsl:otherwise>
                                    Degree of Curvature:
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:angularFormat(number(@degreeOfCurve))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Length:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangent:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Chord:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@middleOrdinate))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">External:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@externalDistance))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangent Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Radial Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Chord Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Radial Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangent Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <tr>
            <td colspan="2">
                <table width="80%">
                    <colgroup span="5">
                        <col width="18%"/>
                        <col width="13%"/>
                        <col width="25%"/>
                        <col width="22%"/>
                        <col width="22%"/>
                    </colgroup>
                    <tr>
                        <th />
                        <th />
                        <th align="right" class="underline" lang="en">Chainage</th>
                        <th align="right" class="underline" lang="en">X</th>
                        <th align="right" class="underline" lang="en">Y</th>
                    </tr>
                    <tr>
                        <td align="left" colspan="5" lang="en">
                            <br/>Type:&#xa0;
                            <xsl:choose>
                                <xsl:when test="@compound = 'false'">
                                    <xsl:value-of select="@type"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> Compound </xsl:text>
                                    <xsl:value-of select="@type"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="Start/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="Start/@name">
                                <td align="right">
                                    (<xsl:value-of select="Start/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="PI/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="PI/@name">
                                <td align="right">
                                    (<xsl:value-of select="PI/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
                        </td>
                    </tr>
                    <xsl:if test="StationEquation">
                        <xsl:for-each select="StationEquation">
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNBK</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" lang="en">EQNAHD</td>
                                <td align="right">
                                    <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:if>
                    <tr>
                        <td align="right">
                            <xsl:value-of select="End/@type"/>
                        </td>
                        <xsl:choose>
                            <xsl:when test="End/@name">
                                <td align="right">
                                    (<xsl:value-of select="End/@name"/>)
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td align="right">
                            <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                        </td>
                        <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Entrance Radius:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@startRadius))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Exit Radius:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@endRadius))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Length:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Angle:</td>
                        <td align="right">
                            <xsl:value-of select="cif:angularFormat(number(@thetaAngle))"/>
                        </td>
                        <td lang="en">
                            <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
                            <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Constant:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@aConstant))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Long Tangent:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Short Tangent:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Long Chord:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Xs:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@xs))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Ys:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@ys))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">P:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@p))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">K:</td>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@ks))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangent Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Radial Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Chord Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Radial Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" lang="en">Tangent Direction:</td>
                        <td align="right">
                            <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template name="Headings">
        <tr>
            <th class="underline" align="center" lang="en">Point Index</th>
            <th class="underline" align="right" lang="en">Chainage</th>
            <th class="underline" align="right" lang="en">Slew</th>
            <th class="underline" align="right" lang="en">Left</th>
            <th class="underline" align="center" lang="en">&#124;</th>
            <th class="underline" align="left" lang="en">Right</th>
        </tr>
    </xsl:template>

    <xsl:template name="Data">
        <xsl:variable name="startStation" select="Start/station/@internalStation"/>
        <xsl:variable name="endStation" select="End/station/@internalStation"/>
        <tr>
            <td colspan="2">
                <table width="100%">
                    <colgroup span="6">
                        <col width="14%"/>
                        <col width="14%"/>
                        <col width="14%"/>
                        <col width="25%"/>
                        <col width="1%"/>
                        <col width="25%"/>
                    </colgroup>
                    <xsl:call-template name="Headings"/>
                    <xsl:for-each select="ancestor::*/RegressionPoints/RegressionPoint/regressionLinePoint/point">
                        <xsl:if test="(station/@internalStation &gt;= $startStation) and (station/@internalStation &lt;= $endStation)">
                            <tr>
                                <td align="center">
                                    <xsl:value-of select="(../../@index)"/>
                                </td>
                                <td align="right" style="white-space:nowrap;">
                                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:distanceFormat(number(../../@slew))"/>
                                </td>
                                <td align="right">
                                    <xsl:if test="(../../@slew &lt; 0.0)">
                                        <xsl:call-template name="Diagram"/>
                                    </xsl:if>
                                </td>
                                <td align="center">
                                    <xsl:if test="../../@slew = 0.0">=</xsl:if>
                                    <xsl:if test="not(../../@slew = 0.0)">&#124;</xsl:if>
                                </td>
                                <td align="left">
                                    <xsl:if test="(../../@slew &gt; 0.0)">
                                        <xsl:call-template name="Diagram"/>
                                    </xsl:if>
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr/>
            </td>
        </tr>
        <tr>
            <td colspan="2">&#xa0;</td>
        </tr>
    </xsl:template>

    <xsl:template name="Diagram">
        <xsl:if test="../../@slew &lt; 0.0">
            <xsl:call-template name="LessThan0">
                <xsl:with-param name="valuePerSpace" select="number($slewRange div 9)"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="(../../@slew &gt; 0.0)">
            <xsl:call-template name="GreaterThan0">
                <xsl:with-param name="valuePerSpace" select="number($slewRange div 9)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="GreaterThan0">
        <xsl:param name="valuePerSpace"/>
        <xsl:choose>
            <xsl:when test="(number(../../@slew) &gt; 0.0) and (number(../../@slew) &lt;= $valuePerSpace)">
                <xsl:value-of select="inr:leadingFormat('>', 3)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; $valuePerSpace) and (number(../../@slew) &lt;= (2 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 6)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (2 * $valuePerSpace)) and (number(../../@slew) &lt;= (3 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 9)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (3 * $valuePerSpace)) and (number(../../@slew) &lt;= (4 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 12)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (4 * $valuePerSpace)) and (number(../../@slew) &lt;= (5 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 15)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (5 * $valuePerSpace)) and (number(../../@slew) &lt;= (6 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 18)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (6 * $valuePerSpace)) and (number(../../@slew) &lt;= (7 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 21)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (7 * $valuePerSpace)) and (number(../../@slew) &lt;= (8 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 24)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (8 * $valuePerSpace)) and (number(../../@slew) &lt;= (9 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 27)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &gt; (9 * $valuePerSpace)) and (number(../../@slew) &lt;= (slewDiagramMax))">
                <xsl:value-of select="inr:leadingFormat('>', 30)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="LessThan0">
        <xsl:param name="valuePerSpace"/>
        <xsl:choose>
            <xsl:when test="(number(../../@slew) &lt; 0.0) and (number(../../@slew) &gt;= (-1 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 3)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-1 * $valuePerSpace)) and (number(../../@slew) &gt;= (-2 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 6)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-2 * $valuePerSpace)) and (number(../../@slew) &gt;= (-3 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 9)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-3 * $valuePerSpace)) and (number(../../@slew) &gt;= (-4 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 12)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-4 * $valuePerSpace)) and (number(../../@slew) &gt;= (-5 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 15)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-5 * $valuePerSpace)) and (number(../../@slew) &gt;= (-6 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 18)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-6 * $valuePerSpace)) and (number(../../@slew) &gt;= (-7 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 21)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-7 * $valuePerSpace)) and (number(../../@slew) &gt;= (-8 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 24)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-8 * $valuePerSpace)) and (number(../../@slew) &gt;= (-9 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 27)"/>
            </xsl:when>
            <xsl:when test="(number(../../@slew) &lt; (-9 * $valuePerSpace)) and (number(../../@slew) &gt;= (slewDiagramMin))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 30)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>

    <msxsl:script implements-prefix="inr" language="JScript">
        <![CDATA[
            // This Function formats a string with a length, padding with leading spaces
            // strString - String to get formated
            // nLength - Length of returned string
            function leadingFormat( strString, nLength )
            {
                var i = 0;
                var nBlanks = nLength - strString.length;
                for( i = 0; i < nBlanks; i++ )
                    strString = unescape("%a0") + strString;
                return strString;
            }
            // This Function formats a string with a length, padding with trailing spaces
            // strString - String to get formated
            // nLength - Length of returned string
            function trailingFormat( strString, nLength )
            {
                var nBlanks = nLength - strString.length;
                for( var i = 0; i < nBlanks; i++ )
                    strString = strString + unescape("%a0");
                return strString;
            }
        ]]>
    </msxsl:script>
</xsl:stylesheet>
