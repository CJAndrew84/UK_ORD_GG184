<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
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
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html lang="en">
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title>Property Description</title>
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
                                <h2>Property Description</h2>
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
                                                <xsl:value-of select="../@inputGridScaleFactor" />
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
                                                    <th align="right" valign="top">Alignment Description:&#xa0; </th>
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
                        <xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                thence <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                thence <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                        <xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence along an arc
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="../../@area > 0"> and the POINT OF BEGINNING.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                thence along an arc
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                having a radius of
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                <xsl:value-of select="$unit"/>,
                the chord of which is
                <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="position() = last()"> and the POINT OF BEGINNING.</xsl:if>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                        <xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - Start/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:value-of select="$unit"/>
                    <xsl:if test="Start/legalReference/@offset >= 0"> right </xsl:if>
                    <xsl:if test="Start/legalReference/@offset &lt; 0"> left </xsl:if>
                    of <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
                    at Station
                    <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
                </xsl:if>
                thence along a spiral
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="position() = last()"> and the POINT OF BEGINNING.</xsl:if>
                <xsl:if test="End/legalReference">
                    to a point
                    <xsl:if test="End/legalReference/@offset >= 0">
                        <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                    </xsl:if>
                    <xsl:if test="End/legalReference/@offset &lt; 0">
                        <xsl:value-of select="cif:distanceFormat(number(0 - End/legalReference/@offset))"/>
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
</xsl:stylesheet>
