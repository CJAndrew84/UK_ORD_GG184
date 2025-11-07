<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
  <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
  <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
  <xsl:template match="/">
    <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
        <title lang="en">Horizontal Alignment Review Report</title>
      </head>
      <body>
        <xsl:choose>
          <xsl:when test="$xslShowHelp = 'true'">
            <xsl:call-template name="StyleSheetHelp"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="InRoads">
              <center>
                <h2 lang="en">Horizontal Alignment Review Report</h2>
                <p lang="en">
                  Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                  Time:&#xa0; <xsl:value-of select="cif:time()"/>
                </p>
              </center>

              <xsl:for-each select="GeometryProject">
                <table class="margin" cellpadding="2" width="90%">
                  <tbody>
                    <tr>
                      <th align="right" lang="en">Project:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="@name"/>
                      </td>
                    </tr>
                    <tr>
                      <th align="right" lang="en">Description:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="@description"/>
                      </td>
                    </tr>
                    <tr>
                      <th align="right" lang="en">File Name:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="@file"/>
                      </td>
                    </tr>
                    <tr>
                      <th align="right" lang="en">Last Revised:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/>
                      </td>
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
                <hr/>

                <table class="margin" width="90%">
                  <colgroup span="5">
                    <col width="18%"/>
                    <col width="13%"/>
                    <col width="25%"/>
                    <col width="22%"/>
                    <col width="22%"/>
                  </colgroup>
                  <xsl:for-each select="HorizontalAlignment">
                    <tbody>
                      <tr>
                        <th align="right" colspan="2" lang="en">
                          <br />Alignment Name:&#xa0;
                        </th>
                        <td align="left" colspan="3" valign="bottom">
                          <xsl:value-of select="@name"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right" colspan="2" lang="en">Alignment Description:&#xa0;</th>
                        <td align="left" colspan="3">
                          <xsl:value-of select="@description"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right" colspan="2" lang="en">Alignment Style:&#xa0;</th>
                        <td align="left" colspan="3">
                          <xsl:value-of select="@style"/>
                        </td>
                      </tr>
                      <tr>
                        <th colspan="2"/>
                        <th align="right" class="underline" lang="en">Chainage</th>
                        <th align="right" class="underline" lang="en">X</th>
                        <th align="right" class="underline" lang="en">Y</th>
                      </tr>
                      <xsl:apply-templates/>
                    </tbody>
                  </xsl:for-each>
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
      <td align="left" colspan="5" lang="en">
        <br/>Element: Linear
      </td>
    </tr>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( Start/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="Start/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
      </td>
    </tr>
    <xsl:if test="StationEquation">
      <xsl:for-each select="StationEquation">
        <tr>
          <td align="right" colspan="2" lang="en">EQNBK</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">EQNAHD</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( End/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="End/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangential Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@direction))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangential Length:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="HorizontalCircle">
    <tr>
      <td align="left" colspan="5" lang="en">
        <br/>Element: Circular
      </td>
    </tr>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( Start/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="Start/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
      </td>
    </tr>
    <xsl:if test="PI">
		 <xsl:choose>
			<xsl:when test="cif:pointType(string(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/@pointType)) = 'SPIRAL CIRCLE SPIRAL'">
				<tr>
					<td align="right">
						<strong><xsl:value-of select="cif:pointType(string(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@pointType))"/></strong>
					</td>
					<td align="right">
					   <strong>( Actual HIP )</strong>
					</td>
					<td align="right">
						<strong><xsl:value-of select="cif:stationFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/></strong>
					</td>
					<td align="right">
						<strong><xsl:value-of select="cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@easting))"/></strong>
					</td>
					<td align="right">
						<strong><xsl:value-of select="cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@northing))"/></strong>
					</td>
				</tr>
			</xsl:when>
			<xsl:when test="cif:pointType(string(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement = current()/@elementNumber]/@pointType)) = 'CIRCLE'">
				<tr>
					<td align="right">
					  <xsl:value-of select="cif:pointType( string( PI/@pointType ))"/>
					</td>
					<td align="right">
					  ( Arc HIP )
					</td>
					<td align="right">
					  <xsl:value-of select="cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
					</td>
					<td align="right">
					  <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
					</td>
					<td align="right">
					  <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
					</td>
				</tr>
			</xsl:when>
		</xsl:choose>
    </xsl:if>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( Center/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="Center/@name"/> )
      </td>
      <td />
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Center/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Center/@northing))"/>
      </td>
    </tr>
    <xsl:if test="StationEquation">
      <xsl:for-each select="StationEquation">
        <tr>
          <td align="right" colspan="2" lang="en">EQNBK</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">EQNAHD</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( End/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="End/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Radius:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Delta:</td>
      <td align="right">
        <xsl:value-of select="cif:angularFormat(number(@delta))"/>
      </td>
      <td align="left" lang="en">
        <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
        <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
      </td>
    </tr>
    <tr>
		<td align="right" colspan="2" lang="en">
			<xsl:choose>
				<xsl:when test="@curvatureDefinition = 'arc'">
					Degree of Curvature (Arc):
				</xsl:when>
				<xsl:when test="@curvatureDefinition = 'chord'">
					Degree of Curvature (Chord):
				</xsl:when>
				<xsl:otherwise>
					Degree of Curvature:
				</xsl:otherwise>
			</xsl:choose>
		</td>
      <td align="right">
        <xsl:value-of select="cif:angularFormat(number(@degreeOfCurve))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Length:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
      </td>
    </tr>
    <tr>
		<td align="right" colspan="2" lang="en">
			<xsl:if test="@curvatureDefinition = 'arc'">
			</xsl:if>
			<xsl:if test="@curvatureDefinition = 'chord'">
				Chorded Length:
			</xsl:if>
		</td>
		<td align="right">
			<xsl:if test="@curvatureDefinition = 'arc'">
			</xsl:if>
			<xsl:if test="@curvatureDefinition = 'chord'">
				<xsl:value-of select="cif:distanceFormat(number(End/station/@internalStation - Start/station/@internalStation))"/>
			</xsl:if>
		</td>
	</tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangent:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Chord:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Middle Ordinate:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@middleOrdinate))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">External:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@externalDistance))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangent Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Radial Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Chord Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Radial Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangent Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="HorizontalSpiral">
    <tr>
      <td align="left" colspan="5" lang="en">
        <br/>Element:
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
    </tr>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( Start/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="Start/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
      </td>
    </tr>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( PI/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="PI/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat( number(PI/station/@externalStation), string(PI/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
      </td>
    </tr>
    <xsl:if test="StationEquation">
      <xsl:for-each select="StationEquation">
        <tr>
          <td align="right" colspan="2" lang="en">EQNBK</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">EQNAHD</td>
          <td align="right">
            <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:if>
    <tr>
      <td align="right">
        <xsl:value-of select="cif:pointType( string( End/@pointType ))"/>
      </td>
      <td align="right">
        ( <xsl:value-of select="End/@name"/> )
      </td>
      <td align="right">
        <xsl:value-of select="cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
      </td>
      <td align="right">
        <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Entrance Radius:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@startRadius))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Exit Radius:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@endRadius))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Length:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Angle:</td>
      <td align="right">
        <xsl:value-of select="cif:angularFormat(number(@thetaAngle))"/>
      </td>
      <td lang="en">
        <xsl:if test="@rotationDirection='cw'">Right</xsl:if>
        <xsl:if test="@rotationDirection = 'ccw'">Left</xsl:if>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Constant:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@aConstant))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Long Tangent:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Short Tangent:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Long Chord:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Xs:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@xs))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Ys:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@ys))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">P:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@p))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">K:</td>
      <td align="right">
        <xsl:value-of select="cif:distanceFormat(number(@ks))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangent Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Radial Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Chord Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Radial Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
      </td>
    </tr>
    <tr>
      <td align="right" colspan="2" lang="en">Tangent Direction:</td>
      <td align="right">
        <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
      </td>
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
