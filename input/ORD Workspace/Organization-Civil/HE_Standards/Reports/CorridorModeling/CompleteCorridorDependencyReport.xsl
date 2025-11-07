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
                <title lang="en">Corridor Setup Report</title>
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
                                <h2 lang="en">Complete Corridor Dependency Report</h2>
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
                                <!-- Corridor Information -->
                                <table class="margin" width="95%">								    
									<xsl:for-each select="Corridor">
									<!-- Sort on Name descending -->
									 <xsl:sort select="@name" order="ascending" data-type="text" />
									 <table>
										<tbody>
											<thead style="display:table-header-group">
												<tr>
												    <td  align="left" colspan="7" lang="en"><strong>Corridor:&#xa0; </strong><xsl:value-of select="@name"/></td>
													<tr>
														<td  align="left"><strong>Horizontal Alignment:&#xa0; </strong><xsl:value-of select="@parent1Name"/></td>
													</tr>
													<tr>													
														<td  align="left"><strong>Vertical Alignment:&#xa0;  </strong><xsl:value-of select="@parent2Name"/></td>
													</tr>
												</tr>
											</thead>
											<tr><td>&#xa0;</td></tr>
										</tbody>
									 </table>
                                        <tr>
                                            <td>
												<table>
													<thead style="display:table-header-group">
													   <tr>
															<th align="left" colspan="7" lang="en">Point Controls</th>
														</tr>
														<tr>
															<th  lang="en">Priority</th>
															<th  lang="en">Point Name</th>
															<th  lang="en">Mode</th>
															<th  lang="en">Control Type</th>
															<th  lang="en">Control Name</th>
															<th  lang="en">Control Point Alignment Name</th>
														</tr>
													</thead>										
                                                    <xsl:choose>
                                                        <xsl:when test="HVControl">
															<xsl:for-each select="HVControl">
																<xsl:if test="@controlType = 'CorridorPoint'">
																	<tr>
																		<td  align="left"><strong><xsl:value-of select="@priority"/></strong></td>
																		<td  align="left"><strong><xsl:value-of select="@pointName"/></strong></td>
																		<td  align="left"><strong><xsl:value-of select="@mode"/></strong></td>
																		<td  align="left"><strong><xsl:value-of select="@controlType"/></strong></td>
																		<td  align="left"><strong><xsl:value-of select="@controlName"/></strong></td>
																		<td  align="left"><strong><xsl:value-of select="@controlParentName"/></strong></td>
																	</tr>
																</xsl:if>
																<xsl:if test="@controlType != 'CorridorPoint'">
																	<tr>
																		<td  align="left"><xsl:value-of select="@priority"/></td>
																		<td  align="left"><xsl:value-of select="@pointName"/></td>
																		<td  align="left"><xsl:value-of select="@mode"/></td>
																		<td  align="left"><xsl:value-of select="@controlType"/></td>
																		<td  align="left"><xsl:value-of select="@controlName"/></td>
																		<td  align="left"><xsl:value-of select="@controlParentName"/></td>
																	</tr>
																</xsl:if>
																
                                                            </xsl:for-each>
														
															
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="7" lang="en">No Point Controls used</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
													

                                                    <tr><td>&#xa0;</td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                       
                                       
                                        <tr>
                                            <td>
                                                <table>
													<thead style="display:table-header-group">
														<tr>
															<th align="left" colspan="7" lang="en">Target Aliasing</th>
														</tr>
														<tr>
															<th  align="right">Target Alias Name</th>
															<th  align="right">Target Type</th>
															<th  align="right">Alias Name</th>
														</tr>
													</thead>	
														<xsl:choose>
															<xsl:when test="TargetAlias">
																<xsl:for-each select="TargetAlias">
																	 <td  valign="top"><xsl:value-of select="@name"/></td>
																	 <td  valign="top"><xsl:value-of select="@type"/></td>
																		<xsl:for-each select="Alias">
																			<tr>
																				<td/><td/><td  valign="top"><xsl:value-of select="@name"/></td>
																			</tr>
																		</xsl:for-each>
																</xsl:for-each>		
															</xsl:when>
															<xsl:otherwise>
																<tr>
																	<td colspan="7" lang="en">No Aliasing used</td>
																</tr>
															</xsl:otherwise>
														</xsl:choose>
														
													<tr><td>&#xa0;</td></tr>	
                                                </table>
                                            </td>
                                        </tr>
										<tr>
										    <td>
                                                <table>
													<thead style="display:table-header-group">
														<tr style="page-break-before:always">
															<th align="left" colspan="7" lang="en">Clipping Options</th>
														</tr>
														<tr>
															<th  align="left">Clipping Corridor</th>
															<th  align="left">Clip Option</th>
														</tr>
													</thead>	
														<xsl:choose>
															<xsl:when test="ClippingOption">
																<xsl:for-each select="ClippingOption">
																	<tr>
																		 <td  valign="top"><xsl:value-of select="@clippingCorridor"/></td>
																		 <td  valign="top"><xsl:value-of select="@clipOption"/></td>	
																	</tr>
																</xsl:for-each>		
															</xsl:when>
															<xsl:otherwise>
																<tr>
																	<td align="left" colspan="7" lang="en">No Clipping used</td>
																</tr>
															</xsl:otherwise>
														</xsl:choose>
																										 
                                                </table>
												<hr/>
                                            </td>
                                        </tr>
                                      
                                    </xsl:for-each>
									<!-- </xsl:sort> -->
									
                                </table>
                            <!-- </xsl:for-each> -->
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
                Select a corridor.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
