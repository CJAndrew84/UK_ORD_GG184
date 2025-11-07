<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Terrain Check Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Terrain Elevation Report</title>
            </head>
            <body>
				<xsl:for-each select="InRoads">
					<left>
						<!-- Report Title -->
						<h1 lang="en">Terrain Elevation Report</h1>
						<p lang="en">
							Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
							Time:&#xa0; <xsl:value-of select="cif:time()"/>
						</p>
					</left>
					<table class="margin" width="50%">
							<thead style="display:table-header-group" cellpadding="10">
								<tr>
									<th class="underline" align="center" lang="en">Element</th>
									<th class="underline" align="center" lang="en">X</th>
									<th class="underline" align="center" lang="en">Y</th>
								<!--	<th class="underline" align="center" lang="en">Length</th>  -->
									<th class="underline" align="center" lang="en">Terrain Z</th>
								</tr>
							</thead>
					<!-- Terrain Section Data -->
					<xsl:for-each select="TerrainCheckElement">
					<!-- 	<h2 lang="en" align="left" style="color:black;font-size:14px">
							Element Name: <xsl:value-of select="@ElementName"/>
							&#160;&#160;&#160;&#160;Element Type: <xsl:value-of select="@ElementType"/>
							&#160;&#160;&#160;&#160;Tolerance: <xsl:value-of select="cif:distanceFormat(number(//InRoads/TerrainSummaryDataElement/@Tolerance))"/>
						</h2>   -->
						
							<xsl:for-each select="TerrainDataElement">
								<tbody>
									<tr>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="./../@ElementName"/>
										</td>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@xCoordinate))"/>
										</td>
										<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@yCoordinate))"/>
										</td>
									<!--	<td class="sidepad" align="center" nowrap="nowrap" style="color:black;">
											<xsl:value-of select="cif:distanceFormat(number(@Length))"/>
										</td>  --> 
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
									</tr>
								</tbody>
							</xsl:for-each>
						
					</xsl:for-each>
					</table>
				</xsl:for-each>
            </body>
			<img src="{$xslRootDirectory}/_Themes/engineer/BentleyLogo.png" alt="Bentley Logo" height="50" width="125" />
        </html>
    </xsl:template>
</xsl:stylesheet>