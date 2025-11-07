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
    <!-- Right-of-Way Takes Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Right-of-Way Takes Report</title>
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
                                <h2 lang="en">Right-of-Way Takes Report</h2>
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
                                <xsl:for-each select="HorizontalAlignment">
                                    <table cellpadding="2" cellspacing="2" width="80%">
                                        <tbody>
                                            <tr>
                                                <th align="left" lang="en">Parcel</th>
                                                <td colspan="4">
                                                    <xsl:value-of select="@name"/>&#xa0; <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr><td colspan="5"><hr/></td></tr>
                                            <tr>
                                                <th class="underline" lang="en" valign="top">Point</th>
                                                <th class="underline" colspan="2" lang="en" valign="top">Offset /<br/>Distance</th>
                                                <th class="underline" lang="en" valign="top">Station /<br/>Bearing</th>
                                                <th class="underline" lang="en" valign="top">Alignment</th>
                                            </tr>
                                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                            <tr>
                                                <td lang="en" valign="bottom"><br/>Required R/W =</td>
                                                <td colspan="4" valign="bottom">
                                                    <xsl:choose>
                                                        <xsl:when test="//@linearUnits = 'Imperial'">
                                                            <xsl:value-of select="cif:areaFormat(number(@area))"/> SF
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="cif:areaFormat(number(@area))"/> m2
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td lang="en">Required R/W =</td>
                                                <td colspan="4">
                                                    <xsl:choose>
                                                        <xsl:when test="//@linearUnits = 'Imperial'">
                                                            <xsl:value-of select="cif:acreFormat(number(@area div 43560))"/> Acres
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="cif:acreFormat(number(@area div 10000))"/> Hectares
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><hr/></td>
                                            </tr>
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
    <!-- Alignment Linear Data -->
    <xsl:template match="HorizontalLine">
        <tr>
            <td class="sidepad" align="right"><xsl:value-of select="Start/@name"/></td>
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
                <xsl:otherwise>
                    <td colspan="2">&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
            </td>
            <td class="sidepad">
                <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
            </td>
        </tr>
        <tr>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
            </td>
        </tr>
        <tr style="line-height:20%;"><td colspan="5">&#xa0;</td></tr>
        <xsl:if test="position() = last()">
            <tr>
                <td class="sidepad" align="right"><xsl:value-of select="End/@name"/></td>
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
                    <xsl:otherwise>
                        <td colspan="2">&#xa0;</td>
                    </xsl:otherwise>
                </xsl:choose>
                <td class="sidepad" align="center" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </td>
                <td class="sidepad"><xsl:value-of select="End/legalReference/@referenceAlignment"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- Alignment Circular Data -->
    <xsl:template match="HorizontalCircle">
        <tr>
            <td class="sidepad" align="right"><xsl:value-of select="Start/@name"/></td>
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
                <xsl:otherwise>
                    <td colspan="2">&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
            </td>
            <td class="sidepad">
                <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
            </td>
        </tr>
        <tr>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
            </td>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
            </td>
        </tr>
        <tr style="line-height:20%;"><td colspan="5">&#xa0;</td></tr>
        <xsl:if test="position() = last()">
            <tr>
                <td class="sidepad" align="right"><xsl:value-of select="End/@name"/></td>
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
                    <xsl:otherwise>
                        <td colspan="2">&#xa0;</td>
                    </xsl:otherwise>
                </xsl:choose>
                <td class="sidepad" align="center" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </td>
                <td class="sidepad"><xsl:value-of select="End/legalReference/@referenceAlignment"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- Alignment Spiral Data -->
    <xsl:template match="HorizontalSpiral">
        <tr>
            <td class="sidepad" align="right"><xsl:value-of select="Start/@name"/></td>
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
                <xsl:otherwise>
                    <td colspan="2">&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/legalReference/station/@externalStation), string(Start/legalReference/station/@externalStationName))"/>
            </td>
            <td class="sidepad">
                <xsl:value-of select="Start/legalReference/@referenceAlignment"/>
            </td>
        </tr>
        <tr>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
            </td>
            <td class="sidepad">&#xa0;</td>
            <td class="sidepad" align="center" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
            </td>
        </tr>
        <tr style="line-height:20%;"><td colspan="5">&#xa0;</td></tr>
        <xsl:if test="position() = last()">
            <tr>
                <td class="sidepad" align="right"><xsl:value-of select="End/@name"/></td>
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
                    <xsl:otherwise>
                        <td colspan="2">&#xa0;</td>
                    </xsl:otherwise>
                </xsl:choose>
                <td class="sidepad" align="center" nowrap="nowrap">
                    <xsl:value-of select="cif:stationFormat(number(End/legalReference/station/@externalStation), string(End/legalReference/station/@externalStationName))"/>
                </td>
                <td class="sidepad"><xsl:value-of select="End/legalReference/@referenceAlignment"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one closed horizontal alignment in the <em>Include</em> field on 
                the <em>Tools &gt; XML Reports &gt; Legal Description</em> or the <em>Tools &gt; XML 
                Reports &gt; Geometry</em> command to get results from this report.
            </p>
            <p class="normal1" lang="en">
                This report requires a reference alignment to be specified in the <em>Reference Alignments 
                &gt; Include</em> field on the <em>Tools &gt; XML Reports &gt; Legal Description</em> 
                command for a complete report.
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
