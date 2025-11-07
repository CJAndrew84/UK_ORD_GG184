<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Horizontal Alignment Curve Set Review Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Horizontal Alignment Curve Set Review Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <!-- Report Title -->
                                <h2 lang="en">Horizontal Alignment Curve Set Review Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/>
                                    <br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
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
                                                <xsl:value-of select="../@inputGridScaleFactor"/>
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
                                <!-- Horizontal Alignment Data -->
                                <table class="margin" width="90%">
                                    <colgroup span="5">
                                        <col width="18%"/>
                                        <col width="13%"/>
                                        <col width="25%"/>
                                        <col width="22%"/>
                                        <col width="22%"/>
                                    </colgroup>
                                    <xsl:for-each select="HorizontalAlignment[HorizontalCurveSets]">
                                        <tbody>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Name:&#xa0;</th>
                                                <td align="left" colspan="3" valign="bottom">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Description:&#xa0;</th>
                                                <td align="left" colspan="3">
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Style:&#xa0;</th>
                                                <td align="left" colspan="3">
                                                    <xsl:value-of select="@style"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th/>
                                                <th/>
                                                <th align="right" class="underline" lang="en">Chainage</th>
                                                <th align="right" class="underline" lang="en">X</th>
                                                <th align="right" class="underline" lang="en">Y</th>
                                            </tr>
                                            <xsl:apply-templates/>
                                            <tr>
                                                <td colspan="5">&#xa0;</td>
                                            </tr>
                                        </tbody>
                                    </xsl:for-each>
                                </table>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <!-- Horizontal Curve Set Point Data -->
    <xsl:template match="CurvesetPoint[@pointType != 'POB' and @pointType != 'POE' and @pointType != 'PI']">
        <xsl:choose>
            <xsl:when test="@pointType = 'CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Entrance Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@startRadius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Exit Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@endRadius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'CIRCLE SPIRAL'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE SPIRAL'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@thetaAngle))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@aConstant))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@shortTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longChord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@xs))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ys))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@p))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ks))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'CIRCLE CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@delta))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@degreeOfCurve))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@tangentLength))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@chord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@middleOrdinate))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@externalDistance))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'CIRCLE CIRCLE CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@delta))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@degreeOfCurve))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@tangentLength))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@chord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@middleOrdinate))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@externalDistance))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE COMPOUND-SPIRAL CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Start/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/PI/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@thetaAngle))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@aConstant))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@shortTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longChord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@xs))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ys))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@p))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ks))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE COMPOUND-SPIRAL CIRCLE SPIRAL CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type:</td>
                    <td align="left" colspan="4" valign="bottom">
                        <xsl:value-of select="@pointType"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="GeometryPoint/@type"/>
                    </td>
                    <td align="right"> ( <xsl:value-of select="GeometryPoint/@name"/> )</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/station/@externalStation), string(Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@type"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation), string(End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Total Central Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                    </td>
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">First Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthStart))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Second Subtangent Distance:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@tangentLengthEnd))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@external))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Spiral Type:</td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@type"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@thetaAngle))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@thetaAngle))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@aConstant))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@aConstant))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@shortTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@shortTangent))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@longChord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longChord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@xs))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@xs))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ys))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ys))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@p))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@p))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@ks))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ks))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@delta))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@length))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        Degree of Curvature
                        (<xsl:value-of select="../../@curvatureDefinition"/>):
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@degreeOfCurve))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@tangentLength))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@chord))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@middleOrdinate))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@externalDistance))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@externalDistance))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr>
                    <td align="left" colspan="2" lang="en" style="color:red">*** Unsupported element ***</td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment with at least one curve to get 
                results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
