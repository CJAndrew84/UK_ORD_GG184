<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Horizontal Elements XYZ Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Horizontal Elements XYZ Report</h2>
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
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@description"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@file"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
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

                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <xsl:for-each select="HorizontalAlignment">
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Name:</th>
                                                <td align="left" colspan="5"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Point</th>
                                                <th class="underline" lang="en">Easting (X)</th>
                                                <th class="underline" lang="en">Northing (Y)</th>
                                                <th class="underline" lang="en">Elevation</th>
                                                <th class="underline" lang="en">Chainage</th>
                                                <th class="underline" lang="en">Direction</th>
                                                <th class="underline" lang="en">Radius</th>
                                            </tr>
                                            <xsl:for-each select="HorizontalElements">
                                                <xsl:sort select="//@internalStation" data-type="number"/>
                                                <xsl:apply-templates/>
                                            </xsl:for-each>
                                            <tr><td colspan="7">&#xa0;</td></tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <xsl:variable name="startStation" select="Start/station/@internalStation"/>
        <xsl:variable name="endStation" select="End/station/@internalStation"/>
        <xsl:for-each select="Start">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@direction))"/>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="../../HorizontalEventPoints">
            <xsl:variable name="list1" select="*/HorizontalEventPoint[GeometryPoint/station/@internalStation &gt; $startStation]"/>
            <xsl:for-each select="$list1[GeometryPoint/station/@internalStation &lt; $endStation]">
                <tr>
                    <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                    </td>
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:directionFormat(number(@tangentialDirection))"/>
                    </td>
                    <td/>
                </tr>
            </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="End">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@direction))"/>
                </td>
                <td/>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:variable name="startStation" select="Start/station/@internalStation"/>
        <xsl:variable name="endStation" select="End/station/@internalStation"/>
        <xsl:for-each select="Start">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@tangentialDirectionStart))"/>
                </td>
                <xsl:choose>
                    <xsl:when test="../@rotationDirection = 'ccw'">
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(-1 * ../@radius))"/>
                        </td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(../@radius))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
        <xsl:choose>
            <xsl:when test="@rotationDirection = 'ccw'">
                <xsl:for-each select="../../HorizontalEventPoints">
                    <xsl:variable name="list1" select="*/HorizontalEventPoint[GeometryPoint/station/@internalStation &gt; $startStation]"/>
                    <xsl:for-each select="$list1[GeometryPoint/station/@internalStation &lt; $endStation]">
                        <tr>
                            <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@tangentialDirection))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(-1 * @radius))"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="../../HorizontalEventPoints">
                    <xsl:variable name="list1" select="*/HorizontalEventPoint[GeometryPoint/station/@internalStation &gt; $startStation]"/>
                    <xsl:for-each select="$list1[GeometryPoint/station/@internalStation &lt; $endStation]">
                        <tr>
                            <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@tangentialDirection))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="End">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@tangentialDirectionStart))"/>
                </td>
                <xsl:choose>
                    <xsl:when test="../@rotationDirection = 'ccw'">
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(-1 * ../@radius))"/>
                        </td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(../@radius))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:variable name="startStation" select="Start/station/@internalStation"/>
        <xsl:variable name="endStation" select="End/station/@internalStation"/>
        <xsl:for-each select="Start">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@tangentialDirectionStart))"/>
                </td>
                <xsl:choose>
                    <xsl:when test="../@rotationDirection = 'ccw'">
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(-1 * ../@startRadius))"/>
                        </td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(../@startRadius))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
        <xsl:choose>
            <xsl:when test="@rotationDirection = 'ccw'">
                <xsl:for-each select="../../HorizontalEventPoints">
                    <xsl:variable name="list1" select="*/HorizontalEventPoint[GeometryPoint/station/@internalStation &gt; $startStation]"/>
                    <xsl:for-each select="$list1[GeometryPoint/station/@internalStation &lt; $endStation]">
                        <tr>
                            <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@tangentialDirection))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(-1 * @radius))"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="../../HorizontalEventPoints">
                    <xsl:variable name="list1" select="*/HorizontalEventPoint[GeometryPoint/station/@internalStation &gt; $startStation]"/>
                    <xsl:for-each select="$list1[GeometryPoint/station/@internalStation &lt; $endStation]">
                        <tr>
                            <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                            </td>
                            <td class="sidepad" align="right">
                                <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@tangentialDirection))"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="End">
            <tr>
                <td class="sidepad" align="left"><xsl:call-template name="Number"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@easting))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@northing))"/></td>
                <td class="sidepad" align="right"><xsl:value-of select="cif:ordinateFormat(number(@elevation))"/></td>
                <td class="sidepad" align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(station/@externalStation), string(station/@externalStationName))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:directionFormat(number(../@tangentialDirectionEnd))"/>
                </td>
                <xsl:choose>
                    <xsl:when test="../@rotationDirection = 'ccw'">
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(-1 * ../@endRadius))"/>
                        </td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(../@endRadius))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="Number">
        <xsl:number count="Start | End | HorizontalEventPoint" level="any"/>
    </xsl:template>
    
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil horizontal geometry element to get results from this report.  
                This report numbers the points consecutively.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
