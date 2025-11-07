<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>

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
                    <xsl:for-each select="HorizontalAlignment">
                        <xsl:text>*       </xsl:text>
                        <xsl:value-of select="cif:columnFormat('Easting', 16)"/>
                        <xsl:value-of select="cif:columnFormat('Northing', 16)"/>
                        <xsl:value-of select="cif:columnFormat('Radius', 16)"/>
                        <xsl:value-of select="cif:columnFormat('Leading Spiral', 16)"/>
                        <xsl:value-of select="cif:columnFormat('Trailing Spiral', 16)"/>
                        <xsl:for-each select="HorizontalCurveSets">
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="CurvesetPoint">
        <xsl:choose>
            <xsl:when test="@pointType = 'POB'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'PI'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'CIRCLE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius), 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'SPIRAL CIRCLE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'CIRCLE SPIRAL'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@length), 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'SPIRAL CIRCLE SPIRAL'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStartElement]/@length), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalSpiral[@elementNumber = current()/@curveSetStopElement]/@length), 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'CIRCLE CIRCLE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:text>&#xd;        </xsl:text>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
            </xsl:when>

            <xsl:when test="@pointType = 'CIRCLE CIRCLE CIRCLE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/PI/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:text>&#xd;        </xsl:text>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/PI/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 1]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:text>&#xd;        </xsl:text>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 2]/PI/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 2]/PI/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(../../HorizontalElements/HorizontalCircle[@elementNumber = current()/@curveSetStartElement + 2]/@radius), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
            </xsl:when>
            
            <xsl:when test="@pointType = 'POE'">
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@easting), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(number(GeometryPoint/@northing), 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
                <xsl:value-of select="cif:columnDoubleFormat(0.0, 4, 16)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
