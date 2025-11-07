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
                                            <tr><td colspan="12">&#xa0;</td></tr>
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

    <xsl:template match="HorizontalLine">
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
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
            <td>&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(@length))"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr>
			<td align="center"><xsl:value-of select="cif:pointType(string(PI/@pointType))"/></td>
            <xsl:choose>
				<xsl:when test="cif:pointType(string(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/@pointType)) = 'SPIRAL CIRCLE SPIRAL'">
						<td align="right">
							<xsl:value-of select="cif:stationFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@easting))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@northing))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:distanceFormat(number(@length))"/>
						</td>
				</xsl:when>
				<xsl:when test="cif:pointType(string(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/@pointType)) = 'CIRCLE'">
						<td align="right">
						  <xsl:value-of select="cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
						</td>
						<td align="right">
						  <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
						</td>
						<td align="right">
						  <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:distanceFormat(number(@radius))"/>
						</td>
						<td align="right">
							<xsl:value-of select="cif:distanceFormat(number(@length))"/>
						</td>
				</xsl:when>
			</xsl:choose>
        </tr>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
    </xsl:template>

	<xsl:template match="HorizontalSpiral">
		<xsl:choose>
		<xsl:when test="End/@pointType = 'SS'">
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
					<xsl:value-of select="cif:distanceFormat(number(../HorizontalSpiral/@startRadius))"/>
				</td>
				<td>&#xa0;</td>
			</tr>
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
		</xsl:choose>
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
