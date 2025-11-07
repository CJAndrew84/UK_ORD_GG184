<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Terrain Crossing Features Report -->    
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Terrain Crossing Features Report</title>
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
                                <h2 lang="en">Terrain Crossing Features Report</h2>
                                <p lang="en">
                                    Report Created: &#xa0;<xsl:value-of select="cif:date()"/><br/>
                                    Time: &#xa0;<xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- crossing features -->
                            <xsl:for-each select="CrossingFeatures">
                                <table align="center" border="1" cellpadding="2" cellspacing="0">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th lang="en" valign="bottom">Easting (X)</th>
                                            <th lang="en" valign="bottom">Northing (Y)</th>
                                            <th lang="en" valign="bottom">Elevation on Feature 1</th>
                                            <th lang="en" valign="bottom">Elevation on Feature 2</th>
                                            <th lang="en" valign="bottom">Elevation Difference</th>
                                            <th lang="en" valign="bottom">Feature 1 Type</th>
                                            <th lang="en" valign="bottom">Feature 2 Type</th>
                                        </tr>
                                    </thead>
                                    <tbody>
				        <xsl:for-each select="Crossing">
				            <tr>
                                                <td align="right">
                                                    <xsl:value-of select="cif:ordinateFormat(number(IntersectionPoint/@easting))"/>
                                                </td>
                                                <td align="right">
                                                    <xsl:value-of select="cif:ordinateFormat(number(IntersectionPoint/@northing))"/>
                                                </td>
                                                <td align="left">
			                            <xsl:value-of select="cif:distanceFormat(number(@levelOnFeature1))"/>
				                </td>
				                <td align="left">
					            <xsl:value-of select="cif:distanceFormat(number(@levelOnFeature2))"/>
				                </td>
				                <td align="left">
					            <xsl:value-of select="cif:distanceFormat(number(@levelDifference))"/>
				                </td>
				                <td align="left">
					            <xsl:value-of select="@feature1"/>
				                </td>
				                <td align="left">
					            <xsl:value-of select="@feature2"/>
				                </td>
				            </tr>
				        </xsl:for-each>
                                    </tbody>
                                </table>
                                <hr />                                                               
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
				This style sheet reports all the Crossing Feature Points in a Civil Terrain.
			</p>
			<p class="normal1" lang="en">
				You must create the Crossing Feature Points for this report by selecting <em>
					Terrain Modelling &gt; Report Crossing Features
					&gt; Report
				</em>.
			</p>
			<p class="small" lang="en">
				<em>&#xa9; 2018 Bentley Systems, Inc</em>
			</p>
        </div>
    </xsl:template>
</xsl:stylesheet>
