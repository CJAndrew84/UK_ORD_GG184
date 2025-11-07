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
    <!-- Parcel Layout Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title>Parcel Layout Report</title>
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
                                <h2>Parcel Layout Report</h2>
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
                                        <table cellpadding="2" cellspacing="2">
                                            <tbody>
                                                <tr>
                                                    <th align="left" colspan="2" valign="bottom"><br/>Layout Points from Chain </th>
                                                    <td align="left" colspan="2" valign="bottom">
                                                        <xsl:value-of select="HorizontalElements/*/Start/legalReference/@referenceAlignment"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="underline" valign="bottom">To<br/>Point</th>
                                                    <th class="underline" valign="bottom">Station</th>
                                                    <th class="underline" colspan="2" valign="bottom">Offset<br/>Distance</th>
                                                </tr>
                                                <xsl:apply-templates mode="point"/>
                                            </tbody>
                                        </table>
                                        <br/>
                                        <p lang="en"><strong>Description of <xsl:value-of select="@name"/></strong></p>
                                        <xsl:apply-templates mode="element" select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                        <br/>
                                        <xsl:if test="@area > 0">
                                            Containing
                                            <xsl:if test="//@linearUnits = 'Imperial'">
                                                <xsl:value-of select="cif:areaFormat(number(@area))"/> sf
                                                (<xsl:value-of select="cif:acreFormat(number(@area div 43560))"/> acres)
                                            </xsl:if>
                                            <xsl:if test="//@linearUnits = 'Metric'">
                                                <xsl:value-of select="cif:areaFormat(number(@area))"/> m2
                                                (<xsl:value-of select="cif:acreFormat(number(@area div 10000))"/> hectares)
                                            </xsl:if>
                                            more or less.
                                        </xsl:if>
                                        <br/><br/>
                                    </xsl:for-each>
                                </div>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <!-- Alignment Point Data -->
    <xsl:template match="HorizontalLine | HorizontalCircle | HorizontalSpiral" mode="point">
        <tr>
            <td class="sidepad" align="right"><xsl:value-of select="Start/@name"/></td>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
            </td>
            <xsl:choose>
                <xsl:when test="Start/legalReference/@offset &lt; 0">
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:distanceFormat(number(-1 * Start/legalReference/@offset))"/>
                    </td>
                    <td class="sidepad">L</td>
                </xsl:when>
                <xsl:when test="Start/legalReference/@offset &gt; 0">
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset))"/>
                    </td>
                    <td class="sidepad">R</td>
                </xsl:when>
                <xsl:when test="Start/legalReference/@offset = 0">
                    <td class="sidepad" align="right">
                        <xsl:value-of select="cif:distanceFormat(number(Start/legalReference/@offset))"/>
                    </td>
                    <td class="sidepad">&#xa0;</td>
                </xsl:when>
                <xsl:otherwise><td colspan="2">&#xa0;</td></xsl:otherwise>
            </xsl:choose>
        </tr>
        <xsl:if test="position() = last()">
            <tr>
                <td class="sidepad" align="right"><xsl:value-of select="End/@name"/></td>
                <td class="sidepad" align="center" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </td>
                <xsl:choose>
                    <xsl:when test="End/legalReference/@offset &lt; 0">
                        <td class="sidepad" align="right">
                            <xsl:value-of select="cif:distanceFormat(number(-1 * End/legalReference/@offset))"/>
                        </td>
                        <td class="sidepad">L</td>
                    </xsl:when>
                    <xsl:when test="End/legalReference/@offset &gt; 0">
                        <td class="sidepad" align="right">
                            <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                        </td>
                        <td class="sidepad">R</td>
                    </xsl:when>
                    <xsl:when test="End/legalReference/@offset = 0">
                        <td class="sidepad" align="right">
                            <xsl:value-of select="cif:distanceFormat(number(End/legalReference/@offset))"/>
                        </td>
                        <td class="sidepad">&#xa0;</td>
                    </xsl:when>
                    <xsl:otherwise><td colspan="2">&#xa0;</td></xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- Alignment Linear Data -->
    <xsl:template match="HorizontalLine" mode="element">
        <xsl:choose>
            <xsl:when test="position() = 1">
                From the point of Beginning.<br/>Thence
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                for
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
            </xsl:when>
            <xsl:when test="position() = last()">
                to a point on the boundary, thence
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="../../@area > 0"> to the Point of Beginning.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                to a point on the boundary, thence
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Alignment Circular Data -->
    <xsl:template match="HorizontalCircle" mode="element">
        <xsl:choose>
            <xsl:when test="position() = 1">
                From the point of Beginning.<br/>Thence
                along an arc
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
            </xsl:when>
            <xsl:when test="position() = last()">
                to the beginning of a curve, thence along said curve for an arc distance of
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
                <xsl:if test="../../@area > 0"> to the Point of Beginning.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                to the beginning of a curve, thence along said curve for an arc distance of
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
                <xsl:if test="position() = last()"> to the Point of Beginning.</xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Alignment Spiral Data -->
    <xsl:template match="HorizontalSpiral" mode="element">
        <xsl:choose>
            <xsl:when test="position() = 1">
                From the point of Beginning.<br/>Thence 
                along a spiral
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
            </xsl:when>
            <xsl:when test="position() = last()">
                to the beginning of a spiral, thence along said spiral for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="../../@area > 0"> to the Point of Beginning.</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                to the beginning of a spiral, thence along said spiral for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                <xsl:value-of select="$unit"/>
                <xsl:if test="@rotationDirection = 'cw'"> to the right, </xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'"> to the left, </xsl:if>
                the chord of which is <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                for a distance of
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
                <xsl:value-of select="$unit"/>,
                <xsl:if test="position() = last()"> to the Point of Beginning.</xsl:if>
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
                This report requires a reference alignment to be specified in the <em>Reference Alignments 
                &gt; Include</em> field on the <em>Tools &gt; XML Reports &gt; Legal Description</em> 
                command for a complete report.&#xa0; It is not suitable for multiple reference alignments.
            </p>
            <p class="normal1" lang="en">
                This report requires the horizontal alignment points to have names for a complete report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
