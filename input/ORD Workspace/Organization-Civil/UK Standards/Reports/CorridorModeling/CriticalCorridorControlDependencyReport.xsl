<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Roadway Setup Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Corridor Dependency Report for Sorting in Excel</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads/RoadwayDesigner">
                            <center>
                                <!-- Report Title -->
                                <h2 lang="en">Critical Corridor Control Point Dependencies for Sorting in Excel</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Roadway Designer Data -->
                            <!-- <xsl:for-each select="RoadwayDesigner"> -->
                                <table class="margin" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <th align="left" lang="en">File Name:&#xa0; </th>
                                            <td align="left"><xsl:value-of select="@fileName"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
								<table class="margin" colspan="4" width="75%">
									<thead style="display:table-header-group">
									   <tr>
											<th  lang="en" align="left">Corridor</th>
											<th  lang="en" align="left">Point Control - Corridor Reference</th>
											<th  lang="en" align="left">Clipping Corridors - Corridor Reference</th>
											<th  lang="en" align="left">Target Aliasing - Corridor Reference</th>
										</tr>
									</thead>
									<xsl:for-each select="Corridor">
									 <xsl:sort select="@name" order="ascending" data-type="text" />
									 <xsl:variable name="CorridorName" select="@name"/> 
                                        <tr>
                                            <td colspan="4">						
                                                    <xsl:choose>
                                                        <xsl:when test="HVControl">
															<xsl:for-each select="HVControl">
																<xsl:if test="@controlType = 'CorridorPoint'">
																	<tr>
																	<td  colspan="1" align="left"><xsl:value-of select="$CorridorName"/></td>
																	<td  colspan="1" align="left"><xsl:value-of select="@controlParentName"/></td>
																	</tr>
																</xsl:if>
                                                            </xsl:for-each>
														
															
                                                        </xsl:when>
                                                    </xsl:choose>
													<xsl:choose>
															<xsl:when test="ClippingOption">
																<xsl:for-each select="ClippingOption">
																	<tr>
																		<td  colspan="1" align="left"><xsl:value-of select="$CorridorName"/></td>
																		<td>&#xa0;</td>
																		<td  colspan="1" align="left"><xsl:value-of select="@clippingCorridor"/></td>
																		<td>&#xa0;</td>																		
																	</tr>
																</xsl:for-each>		
															</xsl:when>
													</xsl:choose>
													<xsl:choose>
													<xsl:when test="TargetAlias">
																<xsl:for-each select="TargetAlias">
																		<xsl:for-each select="Alias">
																			<tr>
																				<td  colspan="1" align="left"><xsl:value-of select="$CorridorName"/></td>
																				<td>&#xa0;</td>
																				<td>&#xa0;</td>
																				<td  colspan="1" align="left"><xsl:value-of select="@name"/></td>
																			</tr>
																		</xsl:for-each>
																</xsl:for-each>		
															</xsl:when>
													</xsl:choose>
                                            </td>
                                        </tr>
                                      </xsl:for-each>								
                                </table>
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
                You must open a Roadway Design file by selecting <em>File &gt; Open</em> on the <em>Report 
                Browser</em> menu and setting the <em>Files of type</em> field to <em>Roadway Design 
                (*.ird)</em>.
            </p>
            <p class="normal1" lang="en">
                Export the results into Excel. Import the corridors in the second column first.  
				The corridors in the first column target points in the corridors in the second 
				column.
			</p>
			<p class="normal1" lang="en">		
				Sort the third column next. Import these Prior to processing the corridors in the 
				first column.  These are corridors that are clipped by the corridors in the first column.
			</p>
			<p class="normal1" lang="en">				
				The corridors in the last column should be imported prior to processing also. 
			</p>
			<p class="normal1" lang="en">
				<em> Note:</em>  Once a corridor has been imported it does not have to be re-imported because it
				is in more than one column!				
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
