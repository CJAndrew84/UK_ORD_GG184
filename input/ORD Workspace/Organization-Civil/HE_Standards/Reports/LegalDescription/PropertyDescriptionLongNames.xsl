<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif" xmlns:inr="inr">
    <xsl:include href="../format.xsl"/>
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Variable to hold unit string -->
    <xsl:variable name="unit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'"> feet</xsl:when>
            <xsl:otherwise> meters</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Property Description Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html lang="en">
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Property Description</title>
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
                                <h2 lang="en">Property Description</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
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
                                                <xsl:value-of select="$unit"/> unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Horizontal Alignment Data -->
                                <div style="margin-left:0.5in;margin-right:0.5in">
                                    <xsl:for-each select="HorizontalAlignment">
                                        <table cellpadding="2">
                                            <tbody>
                                                <tr>
                                                    <th align="right" valign="bottom"><br/>Alignment Name:&#xa0; </th>
                                                    <td align="left" valign="bottom"><xsl:value-of select="@name"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en" valign="top">Alignment Description:&#xa0; </th>
                                                    <td align="left" valign="top"><xsl:value-of select="@description"/><br/>&#xa0;</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                        <br/><br/>
                                        <xsl:if test="@area > 0">
                                            The above described parcel contains &#xb1;
                                            <xsl:if test="//@linearUnits = 'Imperial'">
                                                <xsl:value-of select="cif:acreFormat(number(@area) div 43560)"/> acres
                                                (<xsl:value-of select="cif:areaFormat(number(@area))"/> sq. ft.)
                                            </xsl:if>
                                            <xsl:if test="//@linearUnits = 'Metric'">
                                                <xsl:value-of select="cif:acreFormat(number(@area) div 10000)"/> hectares
                                                (<xsl:value-of select="cif:areaFormat(number(@area))"/> sq. m.)
                                            </xsl:if>
                                        </xsl:if>
                                        <br style="line-height:200%"/>&#xa0;
                                    </xsl:for-each>
                                </div>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <!-- Alignment Linear Data -->
    <xsl:template match="HorizontalLine">
        <xsl:choose>
            <xsl:when test="position() = 1">
                Beginning at a point
                <xsl:if test="Start/legalReference">
                    <xsl:if test="Start/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence
                <xsl:value-of select="inr:convertDirectionToName(number(@direction))"/>
                (<xsl:value-of select="cif:directionFormat(number(@direction), 2)"/>)
                a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="position() = last()">
                thence <xsl:value-of select="inr:convertDirectionToName(number(@direction))"/>
                (<xsl:value-of select="cif:directionFormat(number(@direction),  2)"/>)
                a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
                <xsl:if test="../../@area > 0"> and the POINT OF BEGINNING.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                thence <xsl:value-of select="inr:convertDirectionToName(number(@direction))"/>
                (<xsl:value-of select="cif:directionFormat(number(@direction),  2)"/>)
                a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Alignment Circular Data -->
    <xsl:template match="HorizontalCircle">
        <xsl:choose>
            <xsl:when test="position() = 1">
                Beginning at a point
                <xsl:if test="Start/legalReference">
                    <xsl:if test="Start/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence along an arc
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@radius), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@radius), 2)"/>)
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@chord), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@chord), 2)"/>)
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="position() = last()">
                thence along an arc
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@radius), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@radius), 2)"/>)
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@chord), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@chord), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="../../@area > 0"> and the POINT OF BEGINNING.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                thence along an arc
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@radius), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@radius), 2)"/>)
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@chord), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@chord), 2)"/>)
                <xsl:value-of select="$unit"/>,
                <xsl:if test="position() = last()"> and the POINT OF BEGINNING.</xsl:if>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Alignment Spiral Data -->
    <xsl:template match="HorizontalSpiral">
        <xsl:choose>
            <xsl:when test="position() = 1">
                Beginning at a point
                <xsl:if test="Start/legalReference">
                    <xsl:if test="Start/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence along a spiral
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@longChord), 2)))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="position() = last()">
                thence along a spiral
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@longChord), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@longChord), 2)"/>)
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
                <xsl:if test="../../@area > 0"> and the POINT OF BEGINNING.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                thence along a spiral
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@length), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@length), 2)"/>)
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="inr:convertDirectionToName(number(@chordDirection))"/>
                (<xsl:value-of select="cif:directionFormat(number(@chordDirection),  2)"/>)
                for a distance of
                <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(@longChord), 2)))"/>
                (<xsl:value-of select="cif:distanceFormat(number(@longChord), 2)"/>)
                <xsl:value-of select="$unit"/>,
                <xsl:if test="position() = last()"> and the POINT OF BEGINNING.</xsl:if>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="inr:convertDistanceToName(string(cif:distanceFormat(number(0 - End/legalReference/@offset), 2)))"/>
                        (<xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset), 2)"/>)
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="End/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="End/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment in the <em>Include</em> field on the 
                <em>Tools &gt; XML Reports &gt; Legal Description</em> or the <em>Tools &gt; XML Reports 
                &gt; Geometry</em> command to get results from this report.
            </p>
            <p class="normal1" lang="en">
                This report works with or without a reference alignment specified in the <em>Reference 
                Alignments &gt; Include</em> field on the <em>Tools &gt; XML Reports &gt; Legal 
                Description</em>.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
    <msxsl:script implements-prefix="inr" language="JScript">
        <![CDATA[
            function ChangeNumberToName(numString)
            {
                var decimalIndex = numString.indexOf(".");
                var strBFDec = "";
                var strAFDec = "";
                var strTemp="";
                if( numString.indexOf(unescape("%b0")) != -1)
                    return degreeName(numString);
                if(decimalIndex==-1)
                {
                    strBFDec = numString;
                    strAFDec = "";
                }
                else
                {
                    strBFDec = numString.substring(0,decimalIndex);
                    strAFDec = numString.substring(decimalIndex+1,decimalIndex+3);
                }
                switch(strBFDec.length)
                {
                    case 1:
                        strTemp=singleDigitName(strBFDec);
                        break;
                    case 2:
                        strTemp=doubleDigitName(strBFDec);
                        break;
                    case 3:
                        strTemp=hundredsDigitName(strBFDec);
                        break;
                    case 4:
                        strTemp=thousandsDigitName(strBFDec);
                        break;
                    case 5:
                        strTemp=tenThousandsDigitName(strBFDec);
                        break;
                    default:
                        strTemp="error in whole number;"
                        break;
                }
                switch(strAFDec.length)
                {
                    case 1:
                        strTemp+=tenthsDigitName(strAFDec);
                        break;
                    case 2:
                        strTemp+=hundredthsDigitName(strAFDec);
                        break;
                    default:
                        strTemp="error in decimal number";
                        break;
                }
                return strTemp;
             }
            function singleDigitName(digit)
            {
                var digitName="";
                switch(digit)
                {
                    case '0':
                        digitName = "Zero";
                        break;
                    case '1':
                        digitName = "One";
                        break;
                    case '2':
                        digitName = "Two";
                        break;
                    case '3':
                        digitName = "Three";
                        break;
                    case '4':
                        digitName = "Four";
                        break;
                    case '5':
                        digitName = "Five";
                        break;
                    case '6':
                        digitName = "Six";
                        break;
                    case '7':
                        digitName = "Seven";
                        break;
                    case '8':
                        digitName = "Eight";
                        break;
                    case '9':
                        digitName = "Nine";
                        break;
                    default:
                        digitName = "Error in single digit"
                        break;
                }
                return digitName;
            }
            function doubleDigitName(digit)
            {
                var digitName="";
                if (digit.length < 2) 
                {
                    return "" + singleDigitName(digit);
                }
                if(digit.charAt(0)=='0')
                {
                    return singleDigitName( digit.charAt(1) );
                }
                else if(digit.charAt(0)=='1')
                {
                    switch(digit)
                    {
                        case '10':
                            return "Ten";
                        case '11':
                            return "Eleven";
                        case '12':
                            return "Twelve";
                        case '13':
                            return "Thirteen";
                        case '14':
                            return "Fourteen";
                        case '15':
                            return "Fifteen";
                        case '16':
                            return "Sixteen";
                        case '17':
                            return "Seventeen";
                        case '18':
                            return "Eighteen";
                        case '19':
                            return "Nineteen";
                        default:
                            return "Error in double digit";
                    }
                }
                else
                {
                    switch(digit.charAt(0))
                    {
                        case '2':
                            if(digit.charAt(1)!='0')
                                digitName += "Twenty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Twenty ";
                            break;
                        case '3':
                            if(digit.charAt(1)!='0')
                                digitName += "Thirty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Thirty ";
                            break;
                        case '4':
                            if(digit.charAt(1)!='0')
                                digitName += "Forty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Forty ";
                            break;
                        case '5':
                            if(digit.charAt(1)!='0')
                                digitName += "Fifty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Fifty ";
                            break;
                        case '6':
                            if(digit.charAt(1)!='0')
                                digitName += "Sixty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Sixty ";
                            break;
                        case '7':
                            if(digit.charAt(1)!='0')
                                digitName += "Seventy-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Seventy ";
                            break;
                        case '8':
                            if(digit.charAt(1)!='0')
                                digitName += "Eighty-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Eighty ";
                            break;
                        case '9':
                            if(digit.charAt(1)!='0')
                                digitName += "Ninety-" + singleDigitName(digit.charAt(1));
                            else
                                digitName = "Ninety ";
                            break;
                        default:
                            digitName="Error in double digit";
                            break;
                    }
                }
                return digitName;
            }
            function hundredsDigitName(digit)
            {
                var digitName="";
                if(digit.charAt(0)!=0)
                {
                    digitName=singleDigitName(digit.charAt(0));
                    digitName+=" Hundred ";
                }
                if(digit.charAt(1)!=0||digit.charAt(2)!=0)
                    digitName+=doubleDigitName(digit.substr(1));
                return digitName;
            }
            function thousandsDigitName(digit)
            {
                var digitName="";
                if(digit.charAt(0)!=0)
                {
                    digitName=singleDigitName(digit.charAt(0));
                    digitName+=" Thousand ";
                }
                if(digit.charAt(1)!=0||digit.charAt(2)!=0||digit.charAt(3)!=0)
                    digitName+=hundredsDigitName(digit.substr(1));
                return digitName;
            }
            function tenThousandsDigitName(digit)
            {
                var digitName="";
                if (digit.charAt(0) != 0) 
                {
                    digitName=doubleDigitName(digit.substr(0,2));
                    digitName+=" Thousand ";
                }
                if (digit.charAt(2) != 0 || digit.charAt(3) != 0 || digit.charAt(4) != 0) 
                {
                    digitName+=hundredsDigitName(digit.substr(2));
                }
                return digitName;
            }
            function tenthsDigitName(digit)
            {
                var digitName=" and ";
                if(digit.charAt(0)=='0')
                    return "";
                if( digit.charAt(0)=='1')
                {
                    digitName+=singleDigitName(digit);
                    return digitName+=" Tenth";
                }
                else
                {
                    digitName+=singleDigitName(digit);
                    return digitName+=" Tenths";
                }
            }
            function hundredthsDigitName(digit)
            {
                var digitName=" and ";
                if(digit.charAt(1)=='0')
                {
                    if(digit.charAt(0)=='0')
                        return "";
                    else if( digit.charAt(0)=='1' )
                        return tenthsDigitName(digit.charAt(0));
                }
                if(digit.charAt(0)=='0')
                    digitName+=singleDigitName(digit.charAt(1));
                else
                    digitName+=doubleDigitName(digit);
                if(digit.charAt(0)=='0' && digit.charAt(1)=='1')
                    return digitName+=" Hundredth";
                else
                    return digitName+=" Hundredths";
            }
            function degreeName(strDegree)
            {
                var degreeIndex = strDegree.indexOf(unescape("%b0"));
                var minuteIndex = strDegree.indexOf("'");
                var decimalIndex = strDegree.indexOf(".");
                var degreeName = "";
                degreeName = doubleDigitName(strDegree.substring(0,degreeIndex)) + " degrees ";
                degreeName += doubleDigitName(strDegree.substring(degreeIndex+1,minuteIndex)) + " minutes ";
                degreeName += doubleDigitName(strDegree.substring(minuteIndex+1,decimalIndex));
                
                if( strDegree.substring(minuteIndex+1,strDegree.length-1) == 0 )
                    degreeName += " seconds";
                else
                    degreeName += hundredthsDigitName(strDegree.substring(decimalIndex+1,strDegree.length-1)) + " seconds";
                return degreeName;
            }
            // This function converts a numeral distance to spelled out names
            function convertDistanceToName(data)
            {
                return "" + ChangeNumberToName(data);
            }
            // This function sets the format of directional information.
            // n - value from XML
            // format - (1 - "ddd^mm'ss.s", 2 - "ddd.ddd")
            // precision - the number of digits after the decimal point
            // mode - (1 - Bearing, 2 - Bearings from North Only,
            //         3 - North Azimuth, 4 - South Azimuth)
            function convertDirectionToName(n)
            {
            var format = 1;
            var precision = 2;
            var mode = 1;
            var method = 1;
                // Make sure we have a valid number
                if (!isNaN(n))
                {
                    // this adds 360 to a negative number until it becomes positive
                    while (n < 0)
                    {
                        n += (2 * Math.PI);
                    }
                    // this subtracts 360 if the number is greater than 360
                    while (n >= (2 * Math.PI))
                    {
                        n -= (2 * Math.PI);
                    }
                    //mode 1 - Bearing, mode 2 - North Bearing
                    if (mode == 1 || mode == 2)
                    {
                        var decdeg = (n * 180) / Math.PI;
                        //identifies the quadrant
                        if (decdeg <= 90)
                        {
                            var strAngle = angularFormat(n, format, precision, method);
                            return "North " + ChangeNumberToName(strAngle)+ " East";
                        }
                        //identifies the quadrant
                        if (90 < decdeg && decdeg <= 180)
                        {
                            n = Math.PI - n;
                            var strAngle = angularFormat(n, format, precision, method);
                            if(mode == 1)
                            {
                                return "South " + ChangeNumberToName(strAngle) + " East";
                            }
                            else
                            {
                                return "North " + ChangeNumberToName(strAngle) + " West";
                            }
                        }
                        //identifies the quadrant 
                        if (180 < decdeg && decdeg < 270)
                        {
                            n -= Math.PI;
                            var strAngle = angularFormat(n, format, precision, method);
                            if(mode == 1)
                            {
                                return "South " + ChangeNumberToName(strAngle) + " West";
                            }
                            else
                            {
                                return "North " + ChangeNumberToName(strAngle) + " East";
                            }
                        }
                        //identifies the quadrant
                        if (270 <= decdeg && decdeg < 360)
                        {
                            n = (2.0 * Math.PI) - n;
                            var strAngle = angularFormat(n, format, precision, method);
                            return "North " + ChangeNumberToName(strAngle) + " West";
                        }
                    }
                    // mode 3 - North Azimuth
                    if (mode == 3)
                    {
                        var strAngle = angularFormat(n, format, precision, method);
                        return "" + ChangeNumberToName(strAngle);
                    }
                    // mode 4 - South Azimuth
                    if (mode == 4)
                    {
                        n = n + Math.PI;
                        if ( n >= (2.0 * Math.PI) )
                        {
                            n = n - (2.0 * Math.PI);
                        }
                        var strAngle = angularFormat(n, format, precision, method);
                        return "" + ChangeNumberToName(strAngle);
                     }
                }
                return "";
            }
        ]]>
    </msxsl:script>
</xsl:stylesheet>
