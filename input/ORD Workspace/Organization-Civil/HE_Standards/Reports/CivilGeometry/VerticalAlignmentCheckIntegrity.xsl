<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Simple Vertical Integrity Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Simple Vertical Integrity Report</h2>
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
                                                    <th lang="en" align="left" class="underline">Element</th>
                                                    <th lang="en" align="left" class="underline">
                                                        Point<br/>Type
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Start<br/>Chainage
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Start<br/>Elevation
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Start<br/>Gradient
                                                    </th>
                                                    <th lang="en" align="left" class="underline">
                                                        Point<br/>Type
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        End<br/>Chainage
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        End<br/>Elevation
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        End<br/>Gradient
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Length
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Chainage<br/>Difference<br/>(End to Next)
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Elevation<br/>Difference<br/>(End to Next)
                                                    </th>
                                                    <th lang="en" align="right" class="underline">
                                                        Gradient<br/>Difference<br/>(End to Next)
                                                    </th>
                                                </tr>
                                                <xsl:apply-templates select="//VerticalLine | //VerticalCircle | //VerticalSymmetricalParabola | //VerticalUnsymmetricalParabola"/>
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
            <td align="left" lang="en">Linear</td>
            <td align="left">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@grade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@grade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'VerticalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@grade - following-sibling::*[1]/@grade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@grade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalSymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@grade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalUnsymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation) - following-sibling::*[1]/VerticalStart/@elevation)"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@grade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalCircle">
        <tr>
            <td align="left" lang="en">Circular</td>
            <td align="left">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'VerticalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@grade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalSymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalUnsymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation) - following-sibling::*[1]/VerticalStart/@elevation)"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalSymmetricalParabola">
        <tr>
            <td align="left" lang="en">Parabola</td>
            <td align="left">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@verticalCurveLength))"/>
            </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'VerticalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@grade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalSymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalUnsymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation) - following-sibling::*[1]/VerticalStart/@elevation)"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalUnsymmetricalParabola">
        <tr>
            <td align="left" lang="en">Parabola</td>
            <td align="left">
                <xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@startGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:gradeFormat(number(@endGrade))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@startVerticalCurveLength + @endVerticalCurveLength))"/>
            </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'VerticalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@grade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalSymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation - following-sibling::*[1]/VerticalStart/@elevation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'VerticalUnsymmetricalParabola']">
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(VerticalEnd/station/@internalStation - following-sibling::*[1]/VerticalStart/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation) - following-sibling::*[1]/VerticalStart/@elevation)"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:gradeFormat(number(@endGrade - following-sibling::*[1]/@startGrade))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one Civil vertical geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
