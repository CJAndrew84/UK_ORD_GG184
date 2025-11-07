<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Simple Horizontal Integrity Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Simple Horizontal Integrity Report</h2>
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

                                <table class="margin" width="95%">
                                    <xsl:for-each select="HorizontalAlignment">
                                        <tbody>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">
                                                    <br />Alignment Name:&#xa0;
                                                </th>
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
                                                <th lang="en" align="left" class="underline">Element</th>
                                                <th lang="en" align="left" class="underline">
                                                    Point<br/>Type
                                                </th>
                                                <th lang="en" align="right" class="underline">Chainage</th>
                                                <th lang="en" align="right" class="underline">
                                                    Start<br/>Easting
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Start<br/>Northing
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Start<br/>Direction
                                                </th>
                                                <th lang="en" align="left" class="underline">
                                                    Point<br/>Type
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    End<br/>Easting
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    End<br/>Northing
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    End<br/>Direction
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Length
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Radius
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Easting<br/>Difference<br/>(End to Next)
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Northing<br/>Difference<br/>(End to Next)
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Angular<br/>Difference<br/>(End to Next)
                                                </th>
                                                <th lang="en" align="right" class="underline">
                                                    Radii<br/>Difference<br/>(End to Next)
                                                </th>
                                            </tr>
                                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
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

    <xsl:template match="HorizontalLine">
        <tr>
            <td align="left" lang="en">Linear</td>
            <td align="left"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@direction))" />
            </td>
           <td align="left"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@direction))" />
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td align="right"> </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@direction - following-sibling::*[1]/@direction))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(0.0))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@direction - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(0.0))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalSpiral']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@direction - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(0.0- following-sibling::*[1]/@startRadius))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <tr>
            <td align="left" lang="en">Circular</td>
            <td align="left"><xsl:value-of select="cif:pointType( string( Start/@pointType ))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))" />
            </td>
            <td align="left"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))" />
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <xsl:choose>
                <xsl:when test="@rotationDirection = 'ccw'">
                    <td align="right">
                        -<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td align="right">
                        +<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@direction))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(0.0))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(0.0))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalSpiral']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@radius - following-sibling::*[1]/@startRadius))"/>
                    </td>
                </xsl:if>
            </xsl:if>
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <tr>
            <td align="left">
                <xsl:value-of select="@type"/>
            </td>
            <td align="left">
                <xsl:value-of select="cif:pointType( string( Start/@pointType ))"/>
            </td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))" />
            </td>
            <td align="left">
                <xsl:value-of select="cif:pointType(string(End/@pointType))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))" />
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td align="right"> </td>

            <xsl:if test="position() != last()">
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalLine']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@direction))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@endRadius - 0.0))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalCircle']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@endRadius - following-sibling::*[1]/@radius))"/>
                    </td>
                </xsl:if>
                <xsl:if test="following-sibling::*[1][name() = 'HorizontalSpiral']">
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@easting - following-sibling::*[1]/Start/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(End/@northing - following-sibling::*[1]/Start/@northing))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:angularFormat(number(@tangentialDirectionEnd - following-sibling::*[1]/@tangentialDirectionStart))" />
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(@endRadius - following-sibling::*[1]/@startRadius))"/>
                    </td>
                </xsl:if>
            </xsl:if>
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
