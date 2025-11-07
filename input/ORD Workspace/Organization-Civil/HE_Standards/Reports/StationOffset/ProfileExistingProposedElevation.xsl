<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Profile Existing and Proposed Elevations Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Profile Existing and Proposed Elevations Report</h2>
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

                                <table class="margin" width="60%">
                                    <xsl:for-each select="HorizontalAlignment[StationOffsetPoints]">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <td colspan="4" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; Alignment Name:&#xa0; </strong>
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" lang="en">
                                                    <strong>Alignment Description:&#xa0; </strong>
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; &#xa0;Alignment Style:&#xa0; </strong>
                                                    <xsl:value-of select="@style"/>
                                                    <br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&#xa0;</td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Chainage</th>
                                                <th class="underline" lang="en">
                                                    Existing<br/>Elevation
                                                </th>
                                                <th class="underline" lang="en">
                                                    Proposed<br/>Elevation
                                                </th>
                                                <th class="underline" lang="en">
                                                    Cut/Fill<br/>Depth
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="StationOffsetPoints/StationOffsetPoint">
                                                <xsl:variable name="cutFillDepth" select="centerLinePoint/point/@elevation - @existingGroundElevation"/>
                                                <xsl:if test="not(@offsetAlignmentName = preceding-sibling::*/@offsetAlignmentName)">
                                                    <tr>
                                                        <td colspan="4" lang="en">
                                                            <strong>
                                                                <br/>Offset (Specified) Alignment: &#xa0;
                                                            </strong>
                                                            <xsl:value-of select="@offsetAlignmentName"/>
                                                            <br/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@existingGroundElevation))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@elevation))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:choose>
                                                            <xsl:when test="$cutFillDepth &lt; 0">
                                                                <xsl:value-of select="cif:ordinateFormat(number(-1 * $cutFillDepth))"/>
                                                                <xsl:text>&#xa0; C</xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="cif:ordinateFormat(number($cutFillDepth))"/>
                                                                <xsl:text>&#xa0; F</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
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
                You must create station offset points for this report by selecting either <em>
                    Tools &gt;
                    XML Reports &gt; Station Base
                </em> or <em>
                    Tools &gt; XML Reports &gt; Station
                    Offset
                </em>.
            </p>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment or one feature on the <em>General</em>
                leaf in the <em>From</em> fields.
            </p>
            <p class="normal1" lang="en">
                You must also include the same horizontal alignment on the <em>Horizontal Alignments</em>
                leaf or feature on the <em>Features</em> leaf.&#xa0; Better results may be obtained if you
                copy the horizontal alignment upon which you wish to report into the surface as a
                non-triangulated feature and select that feature on the <em>Features</em> leaf to provide the
                existing elevations.
            </p>
            <p class="normal1" lang="en">
                You must choose at least one option on the <em>Include</em> leaf (<em>
                    Horizontal On-
                    Alignment Points, Horizontal Event Points, Vertical On-Alignment Points, Vertical Event
                    Points
                </em> or <em>Interval</em>.)
            </p>
            <p class="normal1" lang="en">
                <em>Station Limits</em> only apply to computed data, ie, event points by interval.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
