<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
	<xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
	<xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
	<xsl:template match="/">
		<xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
				<title lang="en">Aquaplaning Report</title>
			</head>
			<body>
				<xsl:choose>
					<xsl:when test="$xslShowHelp = 'true'">
						<xsl:call-template name="StyleSheetHelp"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="InRoads">
							<center>
								<h2 lang="en">Aquaplaning Report</h2>
								<p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/>
									<br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
								</p>
								<table class="margin" cellpadding="2" width="80%">
									<td align="center" lang="en" style="font-size: 80%; border-bottom:1px solid black;">
										<strong>Note:&#xa0; </strong>All units in this report are in
										<xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
										<xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
										unless specified otherwise.
									</td>
								</table>

							</center>
								<xsl:for-each select="FlowLineElements/FlowLineElement">
								<table class="margin" cellpadding="2" width="90%">
									<tbody>
										<tr>
											<th align="right" lang="en">Flowline Rainfall Intensity:&#xa0; </th>
											<td align="left" colspan="2">
												<xsl:if test="//@linearUnits = 'Imperial'"><xsl:value-of select="@RainfallIntensity * 12"/> inch/hour</xsl:if>
												<xsl:if test="//@linearUnits = 'Metric'"><xsl:value-of select="@RainfallIntensity * 1000"/> mm/hour</xsl:if>
											</td>
										</tr>
										<tr>
											<th align="right" lang="en">Texture Depth:&#xa0; </th>
											<td align="left" colspan="2">
												<xsl:value-of select="@TextureDepth"/>
											</td>
										</tr>
										<tr>
											<th align="right" lang="en">Formula:</th>
											<td align="left" colspan="2">
												<xsl:value-of select="@CurrentFormula"/>
											</td>
										</tr>
										<tr>
											<th align="right" lang="en">Using Equal Area Slope?:&#xa0; </th>
											<td align="left" colspan="2">
												<xsl:value-of select="@UsingEqualAreaSlope"/>
											</td>
										</tr>
										<tr>
											<th align="right" lang="en">Surface Name:&#xa0; </th>
											<td align="left" colspan="2">
												<xsl:value-of select="@SurfaceName"/>
											</td>
										</tr>
									</tbody>
								</table>
								<hr/>
								<!--xsl:for-each select="//FlowlinePoint"-->
									<table cellspacing="4" width="100%">
										<thead style="display:table-header-group">
											<tr>
												<th colspan="8" lang="en">- - - - - - - - Flowline Points - - - - - - -</th>
											</tr>
											<tr>
												<th class="underline" lang="en" valign="bottom">Gallaway Film Depth</th>
												<th class="underline" lang="en" valign="bottom">Road Research Lab Film Depth</th>
												<th class="underline" lang="en" valign="bottom">Film Depth Difference</th>
												<th class="underline" lang="en" valign="bottom">Slope (%)</th>
												<th class="underline" lang="en" valign="bottom">Distance Along</th>
												<th class="underline" lang="en" valign="bottom">X</th>
												<th class="underline" lang="en" valign="bottom">Y</th>
												<th class="underline" lang="en" valign="bottom">Z (original surface)</th>
											</tr>
										</thead>
										
										<tbody>
											<xsl:for-each select="FlowlinePoint">
												<tr>
													<td align="right">
														<xsl:value-of select="@GallawayFilmDepth"/>
													</td>
													<td align="right">
														<xsl:value-of select="@RRLFilmDepth"/>
													</td>
													<td align="right">
														<xsl:value-of select="@FilmDepthDifference"/>
													</td>
													<td align="right">
														<xsl:value-of select="cif:gradeFormat(number(@Slope))"/>
													</td>
													<td align="right">
														<xsl:value-of select="cif:distanceFormat(number(@DistanceAlong))"/>
													</td>
													<td align="right">
														<xsl:value-of select="cif:ordinateFormat(number(@X))"/>
													</td>
													<td align="right">
														<xsl:value-of select="cif:ordinateFormat(number(@Y))"/>
													</td>
													<td align="right">
														<xsl:value-of select="cif:ordinateFormat(number(@OriginalZ))"/>
													</td>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
								<!--/xsl:for-each-->
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
                You must create an aquaplaning model for this report by selecting <em>
                    OpenRoads Modeling &gt; XML
                    Terrain &gt; Aquaplaning
                </em>.
            </p>
			<p class="small" lang="en">
				<em>&#xa9; 2018 Bentley Systems, Inc</em>
			</p>
		</div>
	</xsl:template>
</xsl:stylesheet>
