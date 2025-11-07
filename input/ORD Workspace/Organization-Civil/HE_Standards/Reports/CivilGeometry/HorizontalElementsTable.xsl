<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Horizontal Elements Table Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Horizontal Elements Table Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br />
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>

                            <xsl:for-each select="GeometryProject">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@description"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@file"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">&#xa0; </th>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/><br/>

                                <table border="1" cellpadding="2" cellspacing="0" width="100%">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th lang="en" valign="bottom">Element</th>
                                            <th lang="en" valign="bottom">Point<br/>Type</th>
                                            <th lang="en" valign="bottom">Point<br/>Number</th>
                                            <th lang="en" valign="bottom">Chainage</th>
                                            <th lang="en" valign="bottom">X</th>
                                            <th lang="en" valign="bottom">Y</th>
                                            <th lang="en" valign="bottom">Radius</th>
                                            <th lang="en" valign="bottom">Length</th>
                                            <th lang="en" valign="bottom">Delta /<br/>Theta</th>
                                            <th lang="en" valign="bottom">Rotation<br/>Direction</th>
                                            <th lang="en" valign="bottom">K</th>
                                            <th lang="en" valign="bottom">P</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="HorizontalAlignment">
                                            <tr>
                                                <th align="left" colspan="2" lang="en">Aligment Name:</th>
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
                                            <tr>
                                                <th align="left" colspan="2" lang="en">Style:</th>
                                                <td colspan="10"><xsl:value-of select="@style"/></td>
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
            <td align="center" lang="en">Tangent</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <td align="right"><xsl:value-of select="Start/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="center" lang="en">Back Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
                <tr>
                    <td align="center" lang="en">Ahead Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
            </xsl:for-each>
        </xsl:if>
        <tr>
            <td align="center" lang="en">Tangent</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <td align="right"><xsl:value-of select="End/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <tr>
            <td align="center" lang="en">Arc</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <td align="right"><xsl:value-of select="Start/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr>
            <td align="center" lang="en">Arc</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(PI/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="PI/@name">
                    <td align="right"><xsl:value-of select="PI/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
					<td align="right" style="white-space:nowrag">
						<xsl:value-of select="cif:angularFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/@delta))"/>
					</td>
					<td align="center" lang="en">
						<xsl:if test="@rotationDirection='cw'">Right</xsl:if>
						<xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
					</td>
					<td>&#xa0;</td>
					<td>&#xa0;</td>
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
					<td align="right">
						<xsl:value-of select="cif:angularFormat(number(@delta))"/>
					</td>
					<td align="center" lang="en">
						<xsl:if test="@rotationDirection='cw'">Right</xsl:if>
						<xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
					</td>
					<td>&#xa0;</td>
					<td>&#xa0;</td>
			</xsl:when>
		</xsl:choose>
        </tr>
        <tr>
            <td align="center" lang="en">Arc</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(Center/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="Center/@name">
                    <td align="right"><xsl:value-of select="Center/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
            <td>&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@northing))"/>
            </td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="center" lang="en">Back Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
                <tr>
                    <td align="center" lang="en">Ahead Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
            </xsl:for-each>
        </xsl:if>
        <tr>
            <td align="center" lang="en">Arc</td>
            <td align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <td align="right"><xsl:value-of select="End/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <tr>
            <td align="center" lang="en">
                <xsl:choose>
                    <xsl:when test="@compound = 'false'">
                        <xsl:value-of select="@type"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> Compound </xsl:text>
                        <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td align="center"><xsl:value-of select="cif:pointType(string(Start/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <td align="right"><xsl:value-of select="Start/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
        <tr>
            <td align="center" lang="en">
                <xsl:choose>
                    <xsl:when test="@compound = 'false'">
                        <xsl:value-of select="@type"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> Compound </xsl:text>
                        <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td align="center"><xsl:value-of select="cif:pointType(string(PI/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="PI/@name">
                    <td align="right"><xsl:value-of select="PI/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
            </td>
            <td>&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:angularFormat(number(@thetaAngle))"/>
            </td>
            <td align="center" lang="en">
                <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
                <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@ks))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@p))"/>
            </td>
        </tr>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="center" lang="en">Back Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
                <tr>
                    <td align="center" lang="en">Ahead Station</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                    <td>&#xa0;</td>
                </tr>
            </xsl:for-each>
        </xsl:if>
        <tr>
            <td align="center" lang="en">
                <xsl:choose>
                    <xsl:when test="@compound = 'false'">
                        <xsl:value-of select="@type"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> Compound </xsl:text>
                        <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td align="center"><xsl:value-of select="cif:pointType(string(End/@pointType))"/></td>
            <xsl:choose>
                <xsl:when test="End/@name">
                    <td align="right"><xsl:value-of select="End/@name"/></td>
                </xsl:when>
                <xsl:otherwise><td>&#xa0;</td></xsl:otherwise>
            </xsl:choose>
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
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
            <td>&#xa0;</td>
        </tr>
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
