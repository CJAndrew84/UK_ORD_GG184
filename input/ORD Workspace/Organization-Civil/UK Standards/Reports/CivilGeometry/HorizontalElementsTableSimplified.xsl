<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <xsl:for-each select="GeometryProject">
                                <table border="1" cellpadding="2" cellspacing="0" width="100%">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th lang="en" valign="bottom">Point Type</th>
                                            <th lang="en" valign="bottom">Chainage</th>
                                            <th lang="en" valign="bottom">X</th>
                                            <th lang="en" valign="bottom">Y</th>
                                            <th lang="en" valign="bottom">Radius</th>
                                            <th lang="en" valign="bottom">Length</th>
                                      <!--      <th lang="en" valign="bottom">Tangent</th>   -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="HorizontalAlignment">
                                            <tr>
                                                <th align="left" colspan="2" lang="en">Alignment Name:</th>
                                                <td colspan="10"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="left" colspan="2" lang="en">Description:</th>
                                                <xsl:choose>
                                                    <xsl:when test="@description">
                                                        <td colspan="10"><xsl:value-of select="@description"/></td>
                                                    </xsl:when>
                                                    <xsl:otherwise><td colspan="10">&#xa0;</td></xsl:otherwise>
                                                </xsl:choose>
                                            </tr>
                                            <xsl:for-each select="HorizontalElements">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>
                                            <tr>
											<td colspan="5" align="right">
											Total Length
											<td align="right">
												<xsl:value-of select="cif:distanceFormat(number(sum(HorizontalElements/*/@length)))"/>
											</td>											
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

	<xsl:template match="HorizontalCircle">
		<xsl:if test="@elementNumber = 1">
		<tr>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@radius))"/>
			</td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/>
			</td>
        </tr>
		</xsl:if>

		<xsl:if test="@elementNumber &gt; 1">
		<tr>
            <td align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@radius))"/>
			</td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/>
			</td>
        </tr>
		</xsl:if>

	</xsl:template>
	
	<xsl:template match="HorizontalSpiral">
		<xsl:if test="@elementNumber = 1">
		<tr>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@startRadius))"/></td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/></td>
        </tr>
		</xsl:if>
		
		<xsl:if test="@elementNumber &gt; 1">
		<tr>
            <td align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@endRadius))"/></td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/></td>
        </tr>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template match="HorizontalLine">
		<xsl:if test="@elementNumber = 1">
		<tr>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
					Straight
			</td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/>
			</td>
        </tr>
		</xsl:if>
		
		<xsl:if test="@elementNumber &gt; 1">
		<tr>
            <td align="center"><xsl:value-of select="string(End/@pointType)"/></td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
            </td>
            <td align="right">
					Straight
			</td>
			<td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/>
			</td>
        </tr>
		</xsl:if>
		
	</xsl:template>
	
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
