<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Sight Visibility Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Terrain Check Report</title>
            </head>
            <body>
				<xsl:for-each select="InRoads">
					<center>
						<!-- Report Title -->
						<h1 lang="en">Terrain Check Report</h1>
						<p lang="en">
							Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
							Time:&#xa0; <xsl:value-of select="cif:time()"/>
						</p>
					</center>
					<!-- Sight Visibility Section Data -->
					<xsl:for-each select="TerrainCheckElement">
						<!-- Sight Line Information -->
						<h2 lang="en" align="left" style="color:black;font-size:14px">
							Element Name: <xsl:value-of select="@ElementName"/>
							&#160;&#160;&#160;&#160;Element Type: <xsl:value-of select="@ElementType"/>
							&#160;&#160;&#160;&#160;Tolerance: <xsl:value-of select="cif:distanceFormat(number(//InRoads/TerrainSummaryDataElement/@Tolerance))"/>
						</h2>
						<table class="margin" width="50%">
							<thead style="display:table-header-group" cellpadding="15">
								<tr>
									<th class="underline" align="center" lang="en">X</th>
									<th class="underline" align="center" lang="en">Y</th>
									<th class="underline" align="center" lang="en">Length</th>
									<th class="underline" align="center" lang="en">CheckElevation</th>
									<th class="underline" align="center" lang="en">TerrainElevation</th>
									<th class="underline" align="center" lang="en">ElevationDifference</th>
									<th class="underline" align="center" lang="en">Tolerance</th>
								</tr>
							</thead>
							<xsl:for-each select="TerrainDataElement">
								<tbody>
									<tr>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@xCoordinate))"/>
										</td>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@yCoordinate))"/>
										</td>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@Length))"/>
										</td>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@CheckElevation))"/>
										</td>
										<xsl:choose>
											<xsl:when test="@TerrainElevation = 'External'">
												<td class="sidepad" align="center" nowrap="nowrap" style="color:red;">
													<xsl:value-of select="@TerrainElevation"/>
												</td>
											</xsl:when>
											<xsl:otherwise>
												<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
													<xsl:value-of select="cif:distanceFormat(number(@TerrainElevation))"/>
												</td>
											</xsl:otherwise>
										</xsl:choose>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@ElevationDifference))"/>
										</td>
										<xsl:choose>
											<xsl:when test="@ElevationDifference = 0">
												<td class="sidepad" align="center" nowrap="nowrap" style="color:#00dd00;" lang="en">Within</td>
											</xsl:when>
											<xsl:when test="number(format-number(@ElevationDifference, '#.#########;#.#########')) &lt; //InRoads/TerrainSummaryDataElement/@Tolerance">
												<td class="sidepad" align="center" nowrap="nowrap" style="color:#00dd00;" lang="en">Within</td>
											</xsl:when>
											<xsl:when test="@ElevationDifference = ''">
												<td class="sidepad" align="center" nowrap="nowrap" style="color:black;" lang="en">N/A</td>
											</xsl:when>
											<xsl:otherwise>
												<td class="sidepad" align="center" nowrap="nowrap" style="color:red;" lang="en">Outside</td>
											</xsl:otherwise>
										</xsl:choose>
									</tr>
								</tbody>
							</xsl:for-each>
						</table>
					</xsl:for-each>
					<xsl:for-each select="TerrainSummaryDataElement">
						<p lang="en">
							<br/><font size="+1">Summary:</font><br/><br/>
							Tolerance:&#xa0; <xsl:value-of select="cif:distanceFormat(number(@Tolerance))"/><br/>
							Number of points:&#xa0; <xsl:value-of select="@numPoints"/><br/>
							Number of points above TM surface:&#xa0; <xsl:value-of select="@pointsAbove"/><br/>
							Number of points below TM surface:&#xa0; <xsl:value-of select="@pointsBelow"/><br/>
							Number of points within tolerance of the TM surface:&#xa0; <xsl:value-of select="@pointsEqual"/><br/>
							Number of points external to the TM surface:&#xa0; <xsl:value-of select="@pointsExtern"/><br/>
							<xsl:value-of select="cif:distanceFormat(number(@maxAbove))"/> is the maximum difference above&#xa0; <br/>
							<xsl:value-of select="cif:distanceFormat(number(@maxBelow))"/> is the maximum difference below&#xa0; 
						</p>
					</xsl:for-each>
				</xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
