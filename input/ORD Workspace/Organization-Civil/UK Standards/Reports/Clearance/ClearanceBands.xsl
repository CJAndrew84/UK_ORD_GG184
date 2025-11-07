<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Clearance Bands Report -->
    <xsl:variable name="uniqueClearanceAlignments" select="//ClearancePoints/ClearancePoint[not(@clearanceAlignmentName = preceding-sibling::ClearancePoint/@clearanceAlignmentName )]/@clearanceAlignmentName "/>
    <xsl:variable name="startLeftBand" select="number(-5.00)"/>
    <xsl:variable name="endRightBand" select="number(5.00)"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Clearance Bands Report</title>
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
                                <h2 lang="en">Clearance Bands Report</h2>
                                <p lang="en">
                                    Report Created: &#xa0;<xsl:value-of select="cif:date()"/><br/>
                                    Time: &#xa0;<xsl:value-of select="cif:time()"/>
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
                                            <td align="left" colspan="2"><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Baseline Alignment:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="HorizontalAlignment/@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%"><xsl:value-of select="../@inputGridScaleFactor" /></td>
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
                                <!-- Clearance Point Data -->
                                <xsl:for-each select="$uniqueClearanceAlignments">
                                    <table class="margin" cellpadding="2" width="90%">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th align="left" colspan="2" lang="en" valign="bottom"><br/>Clearance Alignment:<br/></th>
                                                <td align="left" colspan="4" valign="bottom"><xsl:value-of select="."/></td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Offset<br/>Point</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Description</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Baseline<br/>Station</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Offset</th>
                                                <th colspan="3" lang="en">- - - - - - Offset Point - - - - - -</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">X</th>
                                                <th class="underline" lang="en">Y</th>
                                                <th class="underline" lang="en">Z</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="//ClearancePoint[@clearanceAlignmentName = current()][@firstOffset &gt; ($startLeftBand - 0.0000001) and @firstOffset &lt; $endRightBand + 0.0000001]">
                                                <xsl:sort data-type="number" select="centerLinePoint/point/station/@internalStation"/>
                                                <tr>
                                                    <td align="center"><xsl:value-of select="offsetPoint/@name"/></td>
                                                    <td><xsl:value-of select="offsetPoint/@description"/></td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:distanceFormat(number(@firstOffset))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@easting))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@northing))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@elevation))"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
                                    </table>
                                </xsl:for-each>
                                <!-- Clearance Points from Cogo Data -->
                                <xsl:if test="//ClearancePoint[@origin = 'point']">
                                    <xsl:for-each select="//ClearancePoints">
                                        <table class="margin" cellpadding="2" width="90%">
                                            <thead style="display:table-header-group">
                                                <tr>
                                                    <th class="underline" lang="en" rowspan="2" valign="bottom">Offset<br/>Point</th>
                                                    <th class="underline" lang="en" rowspan="2" valign="bottom">Description</th>
                                                    <th class="underline" lang="en" rowspan="2" valign="bottom">Baseline<br/>Station</th>
                                                    <th class="underline" lang="en" rowspan="2" valign="bottom">Offset</th>
                                                    <th colspan="3" lang="en">- - - - - - Offset Point - - - - - -</th>
                                                </tr>
                                                <tr>
                                                    <th class="underline" lang="en">X</th>
                                                    <th class="underline" lang="en">Y</th>
                                                    <th class="underline" lang="en">Z</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="//ClearancePoint[@origin = 'point'][@firstOffset &gt; ($startLeftBand - 0.0000001) and @firstOffset &lt; $endRightBand + 0.0000001]">
                                                    <xsl:sort data-type="number" select="centerLinePoint/point/station/@internalStation"/>
                                                    <tr>
                                                        <td align="center"><xsl:value-of select="offsetPoint/@name"/></td>
                                                        <td><xsl:value-of select="offsetPoint/@description"/></td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@firstOffset))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@easting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@northing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@elevation))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </table>
                                    </xsl:for-each>
                                </xsl:if>
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
                This style sheet reports data within a band of interest specified in the style sheet 
                itself.&#xa0; The default values are -5.0 and 5.0, but you can change them by changing 
                the values stored in the <code>startLeftBand</code> and <code>startRightBand</code> 
                variables near the top of the style sheet.
            </p>
            <p class="normal1" lang="en">
                You must create clearance points for this report by selecting <em>Tools &gt; XML Reports 
                &gt; Clearance</em>.
            </p>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment or feature on the <em>General</em> leaf 
                in the <em>From</em> fields.
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
