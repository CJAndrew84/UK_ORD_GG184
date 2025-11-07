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
    <!-- Property Description Report (extended to fully spell out North, East, West and South -->
    <!-- and Degrees, Minutes and Seconds) -->
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
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
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
                                            The above described parcel contains 
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
                <xsl:value-of select="inr:fullDirectionFormat(number(@direction))"/>
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
                thence <xsl:value-of select="inr:fullDirectionFormat(number(@direction))"/>
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
                thence <xsl:value-of select="inr:fullDirectionFormat(number(@direction))"/>
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
                <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
                <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
                <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
                the chord of which is <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
                the chord of which is <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
                the chord of which is <xsl:value-of select="inr:fullDirectionFormat(number(@chordDirection))"/>
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
    <msxsl:script implements-prefix="inr" language="JScript">
        <![CDATA[
            // This function sets the format of directional information with
            // North, East, South and West spelled out fully.
            // n - value from XML
            // format - (1 - "ddd^mm'ss.s", 2 - "ddd.ddd")
            // precision - the number of digits after the decimal point
            // mode - (1 - Bearing, 2 - Bearings from North Only,
            //         3 - North Azimuth, 4 - South Azimuth)
            function fullDirectionFormat(n)
            {
            var format = 1;
            var mode = 1;
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
                            var strAngle = fullAngularFormat(n);
                            return "North " + strAngle + " East";
                        }
                        //identifies the quadrant
                        if (90 < decdeg && decdeg <= 180)
                        {
                            n = Math.PI - n;
                            var strAngle = fullAngularFormat(n);
                            if(mode == 1)
                            {
                                return "South " + strAngle + " East";
                            }
                            else
                            {
                                return "North " + strAngle + " West";
                            }
                        }
                        //identifies the quadrant 
                        if (180 < decdeg && decdeg < 270)
                        {
                            n -= Math.PI;
                            var strAngle = fullAngularFormat(n);
                            if(mode == 1)
                            {
                                return "South " + strAngle + " West";
                            }
                            else
                            {
                                return "North " + strAngle + " East";
                            }
                        }
                        //identifies the quadrant
                        if (270 <= decdeg && decdeg < 360)
                        {
                            n = (2.0 * Math.PI) - n;
                            var strAngle = fullAngularFormat(n);
                            return "North " + strAngle + " West";
                        }
                    }
                    // mode 3 - North Azimuth
                    if (mode == 3)
                    {
                        var strAngle = fullAngularFormat(n);
                        return strAngle;
                    }
                    // mode 4 - South Azimuth
                    if (mode == 4)
                    {
                        n = n + Math.PI;
                        if ( n >= (2.0 * Math.PI) )
                        {
                            n = n - (2.0 * Math.PI);
                        }
                        var strAngle = fullAngularFormat(n);
                        return strAngle;
                     }
                }
                return "";
             }
            // This function sets the format of angular information with
            // Degrees, Minutes and Seconds spelled out fully.
            // n - value from xml
            // format - (1 - "ddd^mm'ss.s", 2 - "ddd.ddd")
            // formatMethod - (1 - Degrees, 2 - Grads, 3 - Radians)
            // precision - the number of digits after the decimal point
            function fullAngularFormat(n)
            {
            var format = 1;
            var precision = 1;
            var formatMethod = 1;
                // Checking to see if the number is valid
                if (!isNaN(n))
                {
                    // converts from Radians to Degrees and formats the
                    // value
                    if (formatMethod == 1)
                    {
                        var decdeg = (n * 180) / Math.PI;
                        // format 1 - this converts the number to
                        // "ddd^mm'ss.s"
                        if (format == 1)
                        {
                            // takes only the whole number (ddd)
                            var deg = Math.floor(decdeg);
                            
                            // multiplies the decimal portion time 60 to get the minutes.
                            var decmin = (decdeg - deg) * 60;
                            
                            // takes only the whole part of that number (mm')
                            var min = Math.floor(decmin);
                            
                            // multiplies the decimal portion time 60 to get the seconds.
                            var decsec = (decmin - min) * 60;
                            
                            // this calls the function that gives the number the correct precision
                            var str = formatNumber(decsec, precision);
                            
                            if (  str.substring(0,2) == "60" )
                            {
                                decsec = 0;
                                str = formatNumber(decsec, precision);
                                min = min+1;
                                if ( min == 60 )
                                {
                                    min = 0;
                                    deg = deg + 1;
                                }
                            }
                                
                            if ( min < 10 )
                            {
                                min = "0" + min;
                            }
                            var sec = str;
                            if ( sec < 10 )
                            {
                                sec = "0" + sec;
                            }
                            return deg + " Degrees " + min + " Minutes " + sec + " Seconds";
                        }
                        // format 2 - "ddd.ddd"
                        if (format == 2)
                        {
                            // this calls the function that gives the
                            // number the correct precision
                            var str = formatNumber(decdeg, precision);
                            str = str + unescape("%b0");
                            return str;
                        }
                    }
                    //converts Radians to Grads
                    if (formatMethod == 2)
                    {
                        var radtograd = (n * 200) / Math.PI;
                        var grad = formatNumber(radtograd, precision);
                        return grad;
                    }
                    // value in Radians needs to be formated
                    if (formatMethod == 3)
                    {
                        // this calls the function that gives the number the correct precision
                        var radian = formatNumber(n, precision);
                        return radian;
                    }
                }
                return 985;
             }
        ]]>
    </msxsl:script>
</xsl:stylesheet>
