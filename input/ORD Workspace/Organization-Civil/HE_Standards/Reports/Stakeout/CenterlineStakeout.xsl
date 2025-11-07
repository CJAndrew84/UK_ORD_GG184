<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Centerline Stakeout Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Centerline Stakeout Report</title>
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
                                <h2 lang="en">Centerline Stakeout Report</h2>
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
                                            <th align="right" lang="en">Traverse Alignment:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="//StakeoutPoint/@alignment"/></td>
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
                                <hr />
                                <table class="margin" cellpadding="2" cellspacing="2" width="80%">
                                    <tbody>
                                        <xsl:for-each select="HorizontalAlignment[StakeoutPoints/StakeoutPoint]">
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Centerline Alignment:</th>
                                                <td align="left" colspan="4"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Offset From<br />Centerline</th>
                                                <th class="underline" lang="en" valign="bottom">BS</th>
                                                <th class="underline" lang="en" valign="bottom">OC</th>
                                                <th class="underline" lang="en" valign="bottom">FS Station</th>
                                                <th class="underline" lang="en" valign="bottom">FS Station Type</th>
                                                <th class="underline" lang="en" valign="bottom">Angle Right</th>
                                                <th class="underline" lang="en" valign="bottom">Distance</th>
                                            </tr>
                                            <xsl:for-each select="StakeoutPoints/StakeoutPoint">
                                                <tr>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:distanceFormat(number(foresightPoint/point/@offset))"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="backsightPoint/@name"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="occupiedPoint/@name"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:stationFormat(number(foresightPoint/point/station/@externalStation), string(foresightPoint/point/station/@externalStationName))"/></td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="foresightPoint/point/@type"/>
                                                    </td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:angularFormat(number(@rightAngle))"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:distanceFormat(number(@distance))"/></td>
                                                </tr>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                        <xsl:for-each select="CogoPoints[StakeoutPoints]">
                                            <tr>
                                                <th align="left" colspan="2" lang="en">Cogo Points:</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Offset From<br />Centerline</th>
                                                <th class="underline" lang="en" valign="bottom">BS</th>
                                                <th class="underline" lang="en" valign="bottom">OC</th>
                                                <th class="underline" lang="en" valign="bottom">FS Station</th>
                                                <th class="underline" lang="en" valign="bottom">Angle Right</th>
                                                <th class="underline" lang="en" valign="bottom">Distance</th>
                                            </tr>
                                            <xsl:for-each select="StakeoutPoints/StakeoutPoint">
                                                <tr>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:distanceFormat(number(foresightPoint/point/@offset))"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="backsightPoint/@name"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="occupiedPoint/@name"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:stationFormat(number(foresightPoint/point/station/@externalStation), string(foresightPoint/point/station/@externalStationName))"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:angularFormat(number(@rightAngle))"/></td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:distanceFormat(number(@distance))"/></td>
                                                </tr>
                                            </xsl:for-each>
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
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must create stakeout points for this report by selecting <em>Tools &gt; XML Reports 
                &gt; Stakeout</em>.
            </p>
            <p class="normal1" lang="en">
                You must include either a horizontal alignment or a backsight and foresight point on the 
                <em>General</em> leaf in the <em>From</em> group.
                <br/><strong>Note:&#xa0;</strong> A backsight and foresight point are required for a complete 
                report.
            </p>
            <p class="normal1" lang="en">
                You must toggle on at least one option in the <em>Include Horizontal Points</em> group or 
                key-in a value in the <em>Interval</em> option on the <em>General</em> leaf.
            </p>
            <p class="normal1" lang="en">
                You must also include at least one horizontal alignment on the <em>Horizontal Alignments
                </em> leaf or one cogo point on the <em>Cogo Points</em> leaf or one feature on the <em>
                Features</em> leaf.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
