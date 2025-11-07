<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif" xmlns:inr="inr">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:variable name="liftDiagramMax">
        <xsl:for-each select="//RegressionPoints/RegressionPoint">
            <xsl:sort select="@lift" data-type="number"/>
            <xsl:if test="position() = last()">
                <xsl:value-of select="@lift"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="liftDiagramMin">
        <xsl:for-each select="//RegressionPoints/RegressionPoint">
            <xsl:sort select="@lift" data-type="number"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="@lift"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="liftRange">
        <xsl:choose>
            <xsl:when test="$liftDiagramMax &gt;= (-1 * $liftDiagramMin)">
                <xsl:value-of select="$liftDiagramMax"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="-1 * $liftDiagramMin"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Vertical Regression Lift and Lowers Review Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Vertical Regression Lift and Lowers Review Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br />
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

                                <xsl:for-each select="HorizontalAlignment[VerticalAlignment]">
                                    <table class="margin" width="75%">
                                        <colgroup span="4">
                                            <col width="23%"/>
                                            <col width="18%"/>
                                            <col width="31%"/>
                                            <col width="28%"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">
                                                    <br/>Horizontal Alignment:
                                                </th>
                                                <td align="left" colspan="2" valign="bottom">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Horizontal Description:</th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Horizontal Style:</th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@style"/>
                                                </td>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <xsl:for-each select="VerticalAlignment">
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">
                                                        <br/>Vertical Alignment:
                                                    </th>
                                                    <td align="left" colspan="2" valign="bottom">
                                                        <xsl:value-of select="@name"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">Vertical Description:</th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="@description"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">Vertical Style:</th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="@style"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th/>
                                                    <th/>
                                                    <th align="right" class="underline" lang="en">Chainage</th>
                                                    <th align="right" class="underline" lang="en">Elevation</th>
                                                </tr>
                                                <xsl:apply-templates select="//VerticalLine | //VerticalSymmetricalParabola | //VerticalUnsymmetricalParabola | //VerticalCircle | //VerticalClothoid"/>
                                            </xsl:for-each>
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

    <xsl:template match="VerticalLine">
        <tr>
            <td align="left" colspan="4" lang="en">
                <br/>Element: Linear
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <tr>
                <td align="right" colspan="2" lang="en">EQNBK</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" lang="en">EQNAHD</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Tangent Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@grade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Tangent Length:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="VerticalSymmetricalParabola">
        <tr>
            <td align="left" colspan="4" lang="en">
                <br/>Element: Symmetrical Parabola
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(PVI/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <tr>
                <td align="right" colspan="2" lang="en">EQNBK</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" lang="en">EQNAHD</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="TurningPoint">
            <tr>
                <td align="right" colspan="2">
                    <xsl:value-of select="cif:pointType(string(TurningPoint/@pointType))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(TurningPoint/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2" lang="en">Length:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@verticalCurveLength))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Entrance Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Exit Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">r = (g2 - g1) / L:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@rateOfChange))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">K = l / (g2 - g1):</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@kValue))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@midOrdinate))"/>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="VerticalUnsymmetricalParabola">
        <tr>
            <td align="left" colspan="4" lang="en">
                <br/>Element: Unsymmetrical Parabola
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(PVI/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(PVCC/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVCC/station/@externalStation), string(PVCC/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVCC/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <tr>
                <td align="right" colspan="2" lang="en">EQNBK</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" lang="en">EQNAHD</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="TurningPoint">
            <tr>
                <td align="right" colspan="2">
                    <xsl:value-of select="cif:pointType(string(TurningPoint/@pointType))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(TurningPoint/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2" lang="en">Entrance Length:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@startVerticalCurveLength))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Exit Length:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@endVerticalCurveLength))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Entrance Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Exit Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">r = (g2 - g1) / L:</td>
            <td align="right">
                Entrance: &#xa0;<xsl:value-of select="cif:distanceFormat(number(@startRateOfChange))"/>
            </td>
            <td align="right">
                Exit: &#xa0;<xsl:value-of select="cif:distanceFormat(number(@endRateOfChange))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">K = l / (g2 - g1):</td>
            <td align="right">
                Entrance: &#xa0;<xsl:value-of select="cif:distanceFormat(number(@startKValue))"/>
            </td>
            <td align="right">
                Exit: &#xa0;<xsl:value-of select="cif:distanceFormat(number(@endKValue))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@midOrdinate))"/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="VerticalCircle">
        <tr>
            <td align="left" colspan="4" lang="en">
                <br/>Element: Circular
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(PVI/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalCenter/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalCenter/station/@externalStation), string(VerticalCenter/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalCenter/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <tr>
                <td align="right" colspan="2" lang="en">EQNBK</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" lang="en">EQNAHD</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="TurningPoint">
            <tr>
                <td align="right" colspan="2">
                    <xsl:value-of select="cif:pointType(string(TurningPoint/@pointType))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(TurningPoint/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2" lang="en">Radius:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Length:</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Entrance Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Exit Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <hr/>
            </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template match="VerticalClothoid">
        <tr>
            <td align="left" colspan="4" lang="en">
                <br/>Element: Clothoid
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(PVI/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <tr>
                <td align="right" colspan="2" lang="en">EQNBK</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" lang="en">EQNAHD</td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation))"/>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td align="right" colspan="2">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
        </tr>
        <xsl:if test="TurningPoint">
            <tr>
                <td align="right" colspan="2">
                    <xsl:value-of select="cif:pointType(string(TurningPoint/@pointType))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(TurningPoint/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
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
            <td>
                <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
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
            <td align="right" colspan="2" lang="en">Entrance Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2" lang="en">Exit Grade:</td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
        </tr>
        <tr> <td colspan="4"> <hr/> </td>
        </tr>
        <xsl:call-template name="Data"/>
    </xsl:template>

    <xsl:template name="Headings">
        <tr>
            <th class="underline" align="center" lang="en">Point Index</th>
            <th class="underline" align="right" lang="en">Station</th>
            <th class="underline" align="right" lang="en">Lift</th>
            <th class="underline" align="right" lang="en">Down</th>
            <th class="underline" lang="en">&#124;</th>
            <th class="underline" align="left" lang="en">Up</th>
        </tr>
    </xsl:template>

    <xsl:template name="Data">
        <xsl:variable name="startStation" select="VerticalStart/station/@internalStation"/>
        <xsl:variable name="endStation" select="VerticalEnd/station/@internalStation"/>
        <tr>
            <td colspan="4">
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
                    <xsl:for-each select="ancestor::*/RegressionPoints/RegressionPoint/GeometryPoint">
                        <xsl:if test="(station/@internalStation &gt;= $startStation) and (station/@internalStation &lt;= $endStation)">
                            <tr>
                                <td align="center">
                                    <xsl:value-of select="(../@index)"/>
                                </td>
                                <td align="right" style="white-space:nowrap;">
                                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="cif:distanceFormat(number(../@lift))"/>
                                </td>
                                <td align="right">
                                    <xsl:if test="(../@lift &lt; 0.0)">
                                        <xsl:call-template name="Diagram"/>
                                    </xsl:if>
                                </td>
                                <td align="center">
                                    <xsl:if test="../@lift = 0.0">=</xsl:if>
                                    <xsl:if test="not(../@lift = 0.0)">&#124;</xsl:if>
                                </td>
                                <td align="left">
                                    <xsl:if test="(../@lift &gt; 0.0)">
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
            <td colspan="4">
                <hr/>
            </td>
        </tr>
        <tr>
            <td colspan="4">&#xa0;</td>
        </tr>
    </xsl:template>

    <xsl:template name="Diagram">
        <xsl:if test="../@lift &lt; 0.0">
            <xsl:call-template name="Lower">
                <xsl:with-param name="valuePerSpace" select="number($liftRange div 9)"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="(../@lift &gt; 0.0)">
            <xsl:call-template name="Lift">
                <xsl:with-param name="valuePerSpace" select="number($liftRange div 9)"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="Lift">
        <xsl:param name="valuePerSpace"/>
        <xsl:choose>
            <xsl:when test="(number(../@lift) &gt; 0.0) and (number(../@lift) &lt;= $valuePerSpace)">
                <xsl:value-of select="inr:leadingFormat('>', 3)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; $valuePerSpace) and (number(../@lift) &lt;= (2 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 6)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (2 * $valuePerSpace)) and (number(../@lift) &lt;= (3 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 9)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (3 * $valuePerSpace)) and (number(../@lift) &lt;= (4 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 12)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (4 * $valuePerSpace)) and (number(../@lift) &lt;= (5 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 15)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (5 * $valuePerSpace)) and (number(../@lift) &lt;= (6 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 18)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (6 * $valuePerSpace)) and (number(../@lift) &lt;= (7 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 21)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (7 * $valuePerSpace)) and (number(../@lift) &lt;= (8 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 24)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (8 * $valuePerSpace)) and (number(../@lift) &lt;= (9 * $valuePerSpace))">
                <xsl:value-of select="inr:leadingFormat('>', 27)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &gt; (9 * $valuePerSpace)) and (number(../@lift) &lt;= (liftDiagramMax))">
                <xsl:value-of select="inr:leadingFormat('>', 30)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="Lower">
        <xsl:param name="valuePerSpace"/>
        <xsl:choose>
            <xsl:when test="(number(../@lift) &lt; 0.0) and (number(../@lift) &gt;= (-1 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 3)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-1 * $valuePerSpace)) and (number(../@lift) &gt;= (-2 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 6)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-2 * $valuePerSpace)) and (number(../@lift) &gt;= (-3 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 9)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-3 * $valuePerSpace)) and (number(../@lift) &gt;= (-4 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 12)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-4 * $valuePerSpace)) and (number(../@lift) &gt;= (-5 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 15)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-5 * $valuePerSpace)) and (number(../@lift) &gt;= (-6 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 18)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-6 * $valuePerSpace)) and (number(../@lift) &gt;= (-7 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 21)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-7 * $valuePerSpace)) and (number(../@lift) &gt;= (-8 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 24)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-8 * $valuePerSpace)) and (number(../@lift) &gt;= (-9 * $valuePerSpace))">
                <xsl:value-of select="inr:trailingFormat('&lt;', 27)"/>
            </xsl:when>
            <xsl:when test="(number(../@lift) &lt; (-9 * $valuePerSpace)) and (number(../@lift) &gt;= (liftDiagramMin))">
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
