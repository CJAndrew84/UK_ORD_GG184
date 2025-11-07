<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:strip-space elements="*"/>
    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <xsl:choose>
            <xsl:when test="$xslShowHelp = 'true'">
                <xsl:call-template name="StyleSheetHelp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="InRoads/GeometryProject">
                    <xsl:text/>
                    <xsl:text>* BENTLEY HORIZONTAL ALIGNMENT REVIEW&#xd;</xsl:text>
                    <xsl:text>* &#xd;</xsl:text>
                    <xsl:for-each select="HorizontalAlignment">
                        <xsl:text>* Alignment name: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* Alignment description: </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* Alignment style: </xsl:text><xsl:value-of select="@style"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* &#xd;</xsl:text>
                        <xsl:value-of select="cif:columnFormat('CHAINAGE',47)"/>
                        <xsl:value-of select="cif:columnFormat('X',16)"/>
						<xsl:value-of select="cif:columnFormat('Y',20)"/>
                        <xsl:text>&#xd;</xsl:text>
                        <xsl:for-each select="HorizontalElements">
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="HorizontalLine">
        <xsl:text>Element: Linear</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(Start/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@easting)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@northing)), 20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <xsl:value-of select="cif:columnFormat('EQNBK',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@backStation), string(@backEquation)), 32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)), 20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)), 20)"/>
                <xsl:text>&#xd;</xsl:text>
                <xsl:value-of select="cif:columnFormat('EQNAHD',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@aheadStation), string(@aheadEquation)),32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)),20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)),20)"/>
                <xsl:text>&#xd;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(End/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@easting)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@northing)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangential Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@direction)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangential Length:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:text>Element: Circular</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)),15)"/>
        <xsl:text>(          )</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@easting)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@northing)), 20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="PI">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(PI/@pointType)),15)"/>
            <xsl:text>(Actual HIP)</xsl:text>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@easting)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(../../HorizontalCurveSets/CurvesetPoint[@curveSetStartElement + 1 = current()/@elementNumber]/GeometryPoint/@northing)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Center/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(Center/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Center/@easting)),40)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Center/@northing)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <xsl:value-of select="cif:columnFormat('EQNBK',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@backStation), string(@backEquation)), 32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)), 20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)), 20)"/>
                <xsl:text>&#xd;</xsl:text>
                <xsl:value-of select="cif:columnFormat('EQNAHD',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@aheadStation), string(@aheadEquation)),32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)),20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)),20)"/>
                <xsl:text>&#xd;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(End/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@easting)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@northing)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Radius:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@radius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Delta:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:angularFormat(number(@delta)),20)"/>
        <xsl:if test="@rotationDirection='cw'"><xsl:text> Right</xsl:text></xsl:if>
        <xsl:if test="@rotationDirection='ccw'"><xsl:text> Left</xsl:text></xsl:if>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="@curvatureDefinition = 'arc'">
            <xsl:value-of select="cif:columnFormat('Degree of Curvature(Arc):',27)"/>
        </xsl:if>
        <xsl:if test="@curvatureDefinition = 'chord'">
            <xsl:value-of select="cif:columnFormat('Degree of Curvature(Chord):',27)"/>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:angularFormat(number(@degreeOfCurve)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Length:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@tangentLength)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Chord:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@chord)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Middle Ordinate:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@middleOrdinate)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('External:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@externalDistance)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@tangentialDirectionStart)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Radial Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@radialDirectionStart)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Chord Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@chordDirection)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Radial Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@radialDirectionEnd)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@tangentialDirectionEnd)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:text>Element: </xsl:text>
        <xsl:choose>
            <xsl:when test="@compound = 'false'">
                <xsl:value-of select="@type"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Compound </xsl:text>
                <xsl:value-of select="@type"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(Start/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(Start/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(Start/station/@externalStation), string(Start/station/@externalStationName)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@easting)), 20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(Start/@northing)), 20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PI/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(PI/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PI/station/@externalStation), string(PI/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PI/@easting)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PI/@northing)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <xsl:value-of select="cif:columnFormat('EQNBK',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@backStation), string(@backEquation)), 32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)), 20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)), 20)"/>
                <xsl:text>&#xd;</xsl:text>
                <xsl:value-of select="cif:columnFormat('EQNAHD',15)"/>
                <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(@aheadStation), string(@aheadEquation)),32)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@easting)),20)"/>
                <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(GeometryPoint/@northing)),20)"/>
                <xsl:text>&#xd;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(End/@pointType)),15)"/>
        <xsl:text>(</xsl:text><xsl:value-of select="cif:columnFormat(string(End/@name),10)"/><xsl:text>)</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(End/station/@externalStation), string(End/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@easting)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(End/@northing)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Entrance Radius:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@startRadius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Radius:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@endRadius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Length:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Angle:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:angularFormat(number(@thetaAngle)),20)"/>
        <xsl:if test="@rotationDirection='cw'"> Right</xsl:if>
        <xsl:if test="@rotationDirection = 'ccw'"> Left</xsl:if>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Constant:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@aConstant)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Long Tangent:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@longTangent)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Short Tangent:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@shortTangent)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Long Chord:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@longChord)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Xs:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@xs)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Ys:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@ys)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('P:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@p)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('K:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@ks)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@tangentialDirectionStart)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Radial Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@radialDirectionStart)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Chord Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@chordDirection)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Radial Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@radialDirectionEnd)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Direction:',27)"/>
        <xsl:value-of select="cif:columnFormat(cif:directionFormat(number(@tangentialDirectionEnd)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
       <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
