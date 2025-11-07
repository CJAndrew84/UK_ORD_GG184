<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:key name="groupingkey" match="DuplicatePoint" use="concat(ReferencePoint/@easting, '|', ReferencePoint/@northing)" />
    <!-- Terrain Duplicate Points Report -->    
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Terrain Duplicate Points Report</title>
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
                                <h2 lang="en">Terrain Duplicate Points Report</h2>
                                <p lang="en">
                                    Report Created: &#xa0;<xsl:value-of select="cif:date()"/><br/>
                                    Time: &#xa0;<xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Duplicate Points -->
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="DuplicatePoints">
        <table align="center" border="1" cellpadding="2" cellspacing="0">
            <thead style="display:table-header-group">
                <tr>
                    <th lang="en" valign="bottom">Easting (X)</th>
                    <th lang="en" valign="bottom">Northing (Y)</th>
                    <th lang="en" valign="bottom">Level Difference</th>
                    <th lang="en" valign="bottom">Level</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="DuplicatePoint[generate-id(.)=generate-id(key('groupingkey', concat(ReferencePoint/@easting, '|', ReferencePoint/@northing))[1])]"/>
            </tbody>
        </table>
        <hr />                                                               
    </xsl:template>
    <xsl:template match="DuplicatePoint">
        <tr>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(ReferencePoint/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(ReferencePoint/@northing))"/>
            </td>
            <td align="left">
                <xsl:value-of select="cif:distanceFormat(number(@levelDifference))"/>
            </td>
            <td align="left">
                <xsl:value-of select="cif:distanceFormat(number(@level))"/>
            </td>            
        </tr>
        <xsl:for-each select="key('groupingkey', concat(ReferencePoint/@easting, '|', ReferencePoint/@northing))[position() != 1]">
            <tr >
                <td colspan="2" />
                <td align="left">
                    <xsl:value-of select="cif:distanceFormat(number(@levelDifference))"/>
                </td>
                <td align="left">
                    <xsl:value-of select="cif:distanceFormat(number(@level))"/>
                </td>
            </tr>
        </xsl:for-each>   
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
			<h4 lang="en">Notes</h4>
			<p class="normal1" lang="en">
				This style sheet reports all the Crossing Feature Points in a Civil Terrain.
			</p>
			<p class="normal1" lang="en">
				You must create the Crossing Feature Points for this report by selecting <em>
					Terrain Modelling &gt; Report Duplicate Points
					&gt; Report
				</em>.
			</p>
			<p class="small" lang="en">
				<em>&#xa9; 2018 Bentley Systems, Inc</em>
			</p>
        </div>
    </xsl:template>
</xsl:stylesheet>
