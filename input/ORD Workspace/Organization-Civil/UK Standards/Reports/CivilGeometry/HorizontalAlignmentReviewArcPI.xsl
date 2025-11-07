<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
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
                                <h2 lang="en">Horizontal Alignment Curve Set Review Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/>
                                    <br/>
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
                                            <th align="right" lang="en" style="font-size: 80%">&#xa0; </th>
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
    <xsl:template match="CurvesetPoint[@pointType != 'PI']">
        <xsl:choose>
            <xsl:when test="@pointType = 'POB'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type: Point of Beginning
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(GeometryPoint/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="GeometryPoint/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'POE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type: Point of End
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(GeometryPoint/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="GeometryPoint/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'CIRCLE'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type: Circular
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(GeometryPoint/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="GeometryPoint/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: Circular
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Center/@pointType))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStopElement]/End/station/@externalStationName))"/>
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
                    <td align="left" lang="en">
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection='cw'">Right</xsl:if>
                        <xsl:if test="../../HorizontalElements/*[@elementNumber = current()/@curveSetStartElement]/@rotationDirection = 'ccw'">Left</xsl:if>
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
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'chord'">
                            Chorded Length:
                        </xsl:if>
                    </td>
                    <td align="right">
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'chord'">
                            <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/End/station/@internalStation - ../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/Start/station/@internalStation))"/>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        <xsl:choose>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'arc'">
                                Degree of Curvature (Arc):
                            </xsl:when>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@curvatureDefinition = 'chord'">
                                Degree of Curvature (Chord):
                            </xsl:when>
                            <xsl:otherwise>
                                Degree of Curvature:
                            </xsl:otherwise>
                        </xsl:choose>
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
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE SPIRAL'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type: Spiral Curve Spiral
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(GeometryPoint/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="GeometryPoint/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
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
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: Circular
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@pointType))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/@northing))"/>
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
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/@curvatureDefinition = 'chord'">
                            Chorded Length:
                        </xsl:if>
                    </td>
                    <td align="right">
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/@curvatureDefinition = 'chord'">
                            <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/End/station/@internalStation - ../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+1]/Start/station/@internalStation))"/>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        <xsl:choose>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'arc'">
                                Degree of Curvature (Arc):
                            </xsl:when>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'chord'">
                                Degree of Curvature (Chord):
                            </xsl:when>
                            <xsl:otherwise>
                                Degree of Curvature:
                            </xsl:otherwise>
                        </xsl:choose>
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
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
            </xsl:when>
            <xsl:when test="@pointType = 'SPIRAL CIRCLE COMPOUND-SPIRAL CIRCLE SPIRAL'">
                <tr>
                    <td align="left" lang="en">
                        <br/>Curve Set Type: Spiral Curve Spiral Curve Spiral
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(GeometryPoint/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="GeometryPoint/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/Start/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/PI/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@northing))"/>
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
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: Circular
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/End/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Center/@pointType))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@northing))"/>
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
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'chord'">
                            Chorded Length:
                        </xsl:if>
                    </td>
                    <td align="right">
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'chord'">
                            <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/End/station/@internalStation - ../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/Start/station/@internalStation))"/>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        <xsl:choose>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'arc'">
                                Degree of Curvature (Arc):
                            </xsl:when>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@curvatureDefinition = 'chord'">
                                Degree of Curvature (Chord):
                            </xsl:when>
                            <xsl:otherwise>
                                Degree of Curvature:
                            </xsl:otherwise>
                        </xsl:choose>
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
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/Start/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/PI/station/@externalStationName))"/>
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
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 2]/@ks))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: Circular
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@name"/> )
                    </td>
                    <td/>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/Center/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Radius:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@radius))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Delta:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@delta))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/@curvatureDefinition = 'chord'">
                            Chorded Length:
                        </xsl:if>
                    </td>
                    <td align="right">
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/@curvatureDefinition = 'arc'">
                        </xsl:if>
                        <xsl:if test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/@curvatureDefinition = 'chord'">
                            <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/End/station/@internalStation - ../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement+3]/Start/station/@internalStation))"/>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">
                        <xsl:choose>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@curvatureDefinition = 'arc'">
                                Degree of Curvature (Arc):
                            </xsl:when>
                            <xsl:when test="../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@curvatureDefinition = 'chord'">
                                Degree of Curvature (Chord):
                            </xsl:when>
                            <xsl:otherwise>
                                Degree of Curvature:
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@degreeOfCurve))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@tangentLength))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@chord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@middleOrdinate))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">External:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 3]/@externalDistance))"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">&#xa0;</td>
                </tr>
                <tr>
                    <td align="left" lang="en">
                        <br/>Element: <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@type"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/Start/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/PI/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:pointType(string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/@pointType))"/>
                    </td>
                    <td align="right">
                        ( <xsl:value-of select="../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/@name"/> )
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/station/@externalStation),
                                                                string(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/End/@northing))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Length:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@length))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Angle:</td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@thetaAngle))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Constant:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@aConstant))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@longTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Short Tangent:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@shortTangent))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Long Chord:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@longChord))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Xs:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@xs))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">Ys:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@ys))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">P:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@p))"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2" lang="en">K:</td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement + 4]/@ks))"/>
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
                You must select at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
