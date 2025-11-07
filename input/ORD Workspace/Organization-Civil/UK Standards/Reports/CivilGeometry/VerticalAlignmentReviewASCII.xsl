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
                    <xsl:text>* BENTLEY VERTICAL ALIGNMENT REVIEW&#xd;</xsl:text>
                    <xsl:text>* &#xd;</xsl:text>
                    <xsl:for-each select="HorizontalAlignment/VerticalAlignment">
                        <xsl:text>* Alignment name: </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* Alignment description: </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* Alignment style: </xsl:text><xsl:value-of select="@style"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>* &#xd;</xsl:text>
                        <xsl:value-of select="cif:columnFormat('CHAINAGE',70)"/>
                        <xsl:value-of select="cif:columnFormat('ELEVATION',20)"/>
                        <xsl:for-each select="VerticalElements">
                            <xsl:text>&#xd;</xsl:text>
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="VerticalLine">
        <xsl:text>Element: Linear</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalStart/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalStart/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:value-of select="cif:columnFormat('EQNBK',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
            <xsl:value-of select="cif:columnFormat('EQNAHD',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalEnd/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalEnd/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@grade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Tangent Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="VerticalSymmetricalParabola">
        <xsl:text>Element: Symmetrical Parabola</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalStart/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalStart/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PVI/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PVI/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:value-of select="cif:columnFormat('EQNBK',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
            <xsl:value-of select="cif:columnFormat('EQNAHD',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation)),20)"/>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalEnd/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalEnd/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="TurningPoint">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(TurningPoint/@pointType)),50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(TurningPoint/@elevation)),20)"/>
        </xsl:if>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@verticalCurveLength)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Entrance Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@startGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@endGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('r = (g2 - g1) / L:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@rateOfChange)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('K = l / (g2 - g1):',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@kValue)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Middle Ordinate:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@midOrdinate)),20)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="VerticalUnsymmetricalParabola">
        <xsl:text>Element: Unsymmetrical Parabola</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalStart/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalStart/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PVI/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PVI/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PVCC/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PVCC/station/@externalStation), string(PVCC/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PVCC/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:value-of select="cif:columnFormat('EQNBK',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
            <xsl:value-of select="cif:columnFormat('EQNAHD',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalEnd/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalEnd/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="TurningPoint">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(TurningPoint/@pointType)),50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(TurningPoint/@elevation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat('Entrance Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@startVerticalCurveLength)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@endVerticalCurveLength)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Entrance Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@startGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@endGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('r = (g2 - g1) / L:',50)"/>
        <xsl:variable name="startRateOfChange">
            <xsl:text>Entrance:&#xa0;</xsl:text>
            <xsl:value-of select="cif:distanceFormat(number(@startRateOfChange))"/>
        </xsl:variable>
        <xsl:variable name="endRateOfChange">
            <xsl:text>Exit:&#xa0;</xsl:text>
            <xsl:value-of select="cif:distanceFormat(number(@endRateOfChange))"/>
        </xsl:variable>
        <xsl:value-of select="cif:columnFormat(string($startRateOfChange),20)"/>
        <xsl:value-of select="cif:columnFormat(string($endRateOfChange),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:variable name="startKValue">
            <xsl:text>Entrance:&#xa0;</xsl:text>
            <xsl:value-of select="cif:distanceFormat(number(@startKValue))"/>
        </xsl:variable>
        <xsl:variable name="endKValue">
            <xsl:text>Exit:&#xa0;</xsl:text>
            <xsl:value-of select="cif:distanceFormat(number(@endKValue))"/>
        </xsl:variable>
        <xsl:value-of select="cif:columnFormat('K = l / (g2 - g1):',50)"/>
        <xsl:value-of select="cif:columnFormat(string($startKValue),20)"/>
        <xsl:value-of select="cif:columnFormat(string($endKValue),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Middle Ordinate:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@midOrdinate)),20)"/>
       <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="VerticalCircle">
        <xsl:text>Element: Circular</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalStart/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalStart/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PVI/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PVI/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalCenter/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalCenter/station/@externalStation), string(VerticalCenter/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalCenter/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:value-of select="cif:columnFormat('EQNBK',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
            <xsl:value-of select="cif:columnFormat('EQNAHD',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalEnd/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalEnd/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="TurningPoint">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(TurningPoint/@pointType)),50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(TurningPoint/@elevation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat('Radius:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@radius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Entrance Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@startGrade)),20)"/>
         <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@endGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template match="VerticalClothoid">
        <xsl:text>Element: Clothoid</xsl:text>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalStart/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalStart/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(PVI/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(PVI/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="StationEquation">
            <xsl:value-of select="cif:columnFormat('EQNBK',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@backStation), string(StationEquation/@backEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
            <xsl:value-of select="cif:columnFormat('EQNAHD',50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(StationEquation/@aheadStation), string(StationEquation/@aheadEquation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat(cif:pointType(string(VerticalEnd/@pointType)),50)"/>
        <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName)),20)"/>
        <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(VerticalEnd/@elevation)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:if test="TurningPoint">
            <xsl:value-of select="cif:columnFormat(cif:pointType(string(TurningPoint/@pointType)),50)"/>
            <xsl:value-of select="cif:columnFormat(cif:stationFormat(number(TurningPoint/station/@externalStation), string(TurningPoint/station/@externalStationName)),20)"/>
            <xsl:value-of select="cif:columnFormat(cif:ordinateFormat(number(TurningPoint/@elevation)),20)"/>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
        <xsl:value-of select="cif:columnFormat('Entrance Radius:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@startRadius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Radius:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@endRadius)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Length:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@length)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Angle:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:angularFormat(number(@thetaAngle)),20)"/>
            <xsl:if test="@rotationDirection='cw'"><xsl:text> Right</xsl:text></xsl:if>
            <xsl:if test="@rotationDirection = 'ccw'"><xsl:text> Left</xsl:text></xsl:if>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Long Tangent:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@longTangent)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Short Tangent:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@shortTangent)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Long Chord:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@longChord)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Xs:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@xs)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Ys:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@ys)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('P:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@p)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('K:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:distanceFormat(number(@ks)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Entrance Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@startGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
        <xsl:value-of select="cif:columnFormat('Exit Grade:',50)"/>
        <xsl:value-of select="cif:columnFormat(cif:gradeFormat(number(@endGrade)),20)"/>
        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>    You must select at least one Civil vertical geometry element &#xd;</xsl:text>
        <xsl:text>    to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>

