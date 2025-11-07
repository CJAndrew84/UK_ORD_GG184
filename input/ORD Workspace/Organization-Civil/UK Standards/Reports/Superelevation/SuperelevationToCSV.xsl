<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">

        <xsl:choose>
            <xsl:when test="$xslShowHelp = 'true'">
                <xsl:call-template name="StyleSheetHelp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="InRoads">
                    <xsl:for-each select="RoadwayDesigner">
                        <xsl:for-each select="SuperelevationSections/SuperelevationSection">
                            <xsl:for-each select="SuperelevationObjects/SuperelevationObject">
                                <xsl:for-each select="SuperelevationTransitions">
                                    <xsl:apply-templates/>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="SuperelevationTransition">
        <xsl:value-of select="../../@name"/>
        <xsl:text>,</xsl:text>

        <xsl:value-of select="cif:stationFormat(number(@externalStation), string(@externalStationName))"/>
        <xsl:text>,</xsl:text>

        <xsl:value-of select="@crossSlope"/>
        <xsl:text>,</xsl:text>

        <xsl:choose>
            <xsl:when test="@pivotEdge = 'LeftEdge'">
                <xsl:text>LS,</xsl:text>
            </xsl:when>
            <xsl:when test="@pivotEdge = 'RightEdge'">
                <xsl:text>RS,</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> ,</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
            <xsl:when test="@type = 'NormalCrown'">
                <xsl:text>NC,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'NormalCrownIn'">
                <xsl:text>NCIN,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'NormalCrownOut'">
                <xsl:text>NCOUT,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'FullSuper'">
                <xsl:text>FS,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'FullSuperIn'">
                <xsl:text>FSIN,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'FullSuperOut'">
                <xsl:text>FSOUT,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'ReverseCrown'">
                <xsl:text>RC,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'ReverseCrownIn'">
                <xsl:text>RCIN,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'ReverseCrownOut'">
                <xsl:text>RCOUT,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'LevelCrown'">
                <xsl:text>LC,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'LevelCrownIn'">
                <xsl:text>LCIN,</xsl:text>
            </xsl:when>
            <xsl:when test="@type = 'LevelCrownOut'">
                <xsl:text>LCOUT,</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>U,</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
            <xsl:when test="@transitionType = 'Linear'">
                <xsl:text>L,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'BiquadraticReverseCurve'">
                <xsl:text>BRC,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'ParabolicCurve'">
                <xsl:text>PC,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'CubicReverse'">
                <xsl:text>CRC,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'CircularReverseCurve'">
                <xsl:text>CRC,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'ParabolicReverseCurve'">
                <xsl:text>PRC,</xsl:text>
            </xsl:when>
            <xsl:when test="@transitionType = 'SymmetricalReverseCurve'">
                <xsl:text>SRS,</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>L,</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="cif:distanceFormat(number(0.0))"/>

        <xsl:text>&#xd;</xsl:text>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                Converts the superelevation to a .csv file format.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>