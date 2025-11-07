<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Cross Section Style Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <left>
                                <h2 lang="en">Cross Section Style Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </left>
                            
                            <xsl:for-each select="GeometryProject">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                     <!--                   <tr>
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@description"/></td>
                                        </tr>   -->
                                        <tr>
                                            <th align="left" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@file"/></td>
                                        </tr>
                                       
                                        <tr>
                                            <th align="left">Horizontal Baseline Alignment:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="HorizontalAlignment/@name"/>
                                            </td>
                                        </tr>
										<tr>
                                            <th align="left" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="concat(HorizontalAlignment/@lastRevisedBy, ' (M/D/Y) ', HorizontalAlignment/@lastRevisedDate)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">Vertical Alignment:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="HorizontalAlignment/VerticalAlignment/@name"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet.</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters.</xsl:if>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr />

                                <table class="margin" cellpadding="2" cellspacing="1" width="90%">
                                    <thead>
                                        <tr>
                                            <th class="underline" align="right" lang="en">Chainage</th>
                                        <!--    <th class="underline" align="right" lang="en">Design Elevation</th>  -->
                                            <th class="underline" align="right" lang="en">X</th>
                                            <th class="underline" align="right" lang="en">Y</th>
											<th class="underline" align="right" lang="en">Z</th>
                                            <th class="underline" align="right" lang="en">Offset</th>
                                            <th class="underline" align="left" lang="en">Element Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										
                                        <xsl:for-each select="//StationOffsetPoint">
                                            <xsl:sort select="centerLinePoint/point/station/@internalStation" data-type="number"/>
                                            <xsl:sort select="@firstOffset" data-type="number"/>
                                            <tr>
                                                <td class="sidepad" align="right" nowrap="nowrap">
                                                    <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                </td>
                                         <!--       <td class="sidepad" align="right">
                                                    <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@elevation))"/>
                                                </td>   -->
                                                <xsl:choose>
													<xsl:when test="../../@name != @offsetAlignmentName">
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(offsetLinePoint/point/@easting))"/>
														</td>
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(offsetLinePoint/point/@northing))"/>
														</td>
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(offsetLinePoint/point/@elevation))"/>
														</td>
													</xsl:when>
													<xsl:otherwise>
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@easting))"/>
														</td>
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@northing))"/>
														</td>
														<td class="sidepad" align="right">
															<xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@elevation))"/>
														</td>
													</xsl:otherwise>
												</xsl:choose>
												<td class="sidepad" align="right">
													<xsl:value-of select="cif:ordinateFormat(number(@firstOffset))"/>
												</td>
                                                <td class="sidepad" align="left">
                                                    <xsl:value-of select="@offsetAlignmentName"/>
                                                </td>
                                            </tr>
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
                You should use Civil Tools and Station Base Report. Select a baseline and all additional features  (including baseline again) that are to be included in the report.
				Output - Chainage, X, Y, Z, Offset, Feature Name
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
