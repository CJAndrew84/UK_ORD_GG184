<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Chainage and Offset Along Single Alignment Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Chainage and Offset Along Single Alignment Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
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
                                            <th align="right" lang="en">Baseline (Active) Alignment:</th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="HorizontalAlignment/@name"/>
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

                                <table class="margin" width="90%">
                                    <xsl:for-each select="HorizontalAlignment[StationOffsetPoints]">
                                        <tbody>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Name:&#xa0;</th>
                                                <td align="left" colspan="4" valign="bottom">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Description:&#xa0;</th>
                                                <td align="left" colspan="4">
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Style:&#xa0;</th>
                                                <td align="left" colspan="4">
                                                    <xsl:value-of select="@style"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Point</th>
                                                <th/>
                                                <xsl:if test="not(number(StationOffsetPoints/StationOffsetPoint/@secondOffset) = 0)">
                                                    <th>Distance to</th>
                                                </xsl:if>
                                                <th/>
                                                <th colspan="3" lang="en" nowrap="nowrap">- - - - - - Specified Alignment - - - - - -</th>
                                                <xsl:if test="not(number(StationOffsetPoints/StationOffsetPoint/@secondOffset) = 0)">
                                                    <th colspan="2" lang="en" nowrap="nowrap">- - - - Offset Point - - - -</th>
                                                </xsl:if>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Type</th>
                                                <th align="right" class="underline" lang="en">Chainage</th>
                                                <xsl:if test="not(number(StationOffsetPoints/StationOffsetPoint/@secondOffset) = 0)">
                                                    <th align="right" class="underline" lang="en">Offset Point</th>
                                                </xsl:if>
                                                <th align="right" class="underline" lang="en">Radial Direction</th>
                                                <th align="right" class="underline" lang="en">X</th>
                                                <th align="right" class="underline" lang="en">Y</th>
                                                <th align="right" class="underline" lang="en">Z</th>
                                                <xsl:if test="not(number(StationOffsetPoints/StationOffsetPoint/@secondOffset) = 0)">
                                                    <th align="right" class="underline" lang="en">X</th>
                                                    <th align="right" class="underline" lang="en">Y</th>
                                                </xsl:if>
                                            </tr>
                                            <xsl:for-each select="StationOffsetPoints/StationOffsetPoint">
                                                <xsl:if test="not(@offsetAlignmentName = preceding-sibling::*/@offsetAlignmentName)">
                                                    <tr>
                                                        <td colspan="6" lang="en">
                                                            <strong>
                                                                <br/>Offset (Specified) Alignment: &#xa0;
                                                            </strong>
                                                            <xsl:value-of select="@offsetAlignmentName"/>
                                                            <br/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="centerLinePoint/point/@type"/>
                                                    </td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                    </td>
                                                    <xsl:if test="not(number(@secondOffset) = 0)">
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@secondOffset))"/>
                                                        </td>
                                                    </xsl:if>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:directionFormat(number(centerLinePoint/@radialDirection))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@easting))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@northing))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@elevation))"/>
                                                    </td>
                                                    <xsl:if test="not(number(@secondOffset) = 0)">
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@easting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@northing))"/>
                                                        </td>
                                                    </xsl:if>
                                                </tr>
                                            </xsl:for-each>
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

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must create station offset points for this report by selecting <em>
                    Tools &gt; XML
                    Reports &gt; Station Offset
                </em>.
            </p>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment or one feature on the <em>General</em>
                leaf in the <em>From</em> fields.
            </p>
            <p class="normal1" lang="en">
                You must also include at least one horizontal alignment on the <em>
                    Horizontal Alignments
                </em> leaf or one feature on the <em> Features</em> leaf.
            </p>
            <p class="normal1" lang="en">
                You must choose at least one option on the <em>Include</em> leaf (<em>
                    Horizontal On-
                    Alignment Points, Horizontal Event Points, Vertical On-Alignment Points, Vertical Event
                    Points
                </em> or <em>Interval</em>.)
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
