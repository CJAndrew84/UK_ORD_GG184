<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <!-- Variable to hold unit string -->
    <xsl:variable name="unit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'"> feet</xsl:when>
            <xsl:otherwise> meters</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Horizontal Alignment Legal Description from Reference -->
    <xsl:output method="text" media-type="text/plain" encoding="iso-8859-1"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <xsl:choose>
            <xsl:when test="$xslShowHelp = 'true'">
                <xsl:call-template name="StyleSheetHelp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="InRoads">
                    <xsl:text/>
                    <xsl:text>             Horizontal Alignment Legal Description from Reference&#xd;</xsl:text>
                    <xsl:text>                      Report Created:  </xsl:text><xsl:value-of select="cif:date()"/><xsl:text> &#xa0;</xsl:text>
                    <xsl:value-of select="cif:time()"/><xsl:text>&#xd;&#xd;</xsl:text>
                    <xsl:for-each select="GeometryProject">
                        <xsl:text>              Project:  </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>          Description:  </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>         Input Factor:  </xsl:text><xsl:value-of select="../@inputGridScaleFactor"/><xsl:text>&#xd;</xsl:text>
                        <xsl:text>--------------------------------------------------------------------------------&#xd;</xsl:text>
                        <xsl:for-each select="HorizontalAlignment">
                            <xsl:text>       Alignment Name:  </xsl:text><xsl:value-of select="@name"/><xsl:text>&#xd;</xsl:text>
                            <xsl:text>Alignment Description:  </xsl:text><xsl:value-of select="@description"/><xsl:text>&#xd;</xsl:text>
                            <xsl:text>  Reference Alignment:  </xsl:text><xsl:value-of select="//legalReference/@referenceAlignment"/><xsl:text>&#xd;&#xd;</xsl:text>
                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                            <xsl:if test="@area &gt; 0">
                                <xsl:text>and the POINT OF BEGINNING.&#xd;&#xd;</xsl:text>
                                <xsl:text>The above described parcel contains </xsl:text>
                                <xsl:if test="//@linearUnits = 'Imperial'">
                                    <xsl:value-of select="cif:acreFormat(number(@area) div 43560)"/><xsl:text> acres (</xsl:text>
                                    <xsl:value-of select="cif:acreFormat(number(@area))"/><xsl:text> sq. ft.)&#xd;&#xd;&#xd;</xsl:text>
                                </xsl:if>
                                <xsl:if test="//@linearUnits = 'Metric'">
                                    <xsl:value-of select="cif:acreFormat(number(@area) div 10000)"/><xsl:text> hectares (</xsl:text>
                                    <xsl:value-of select="cif:acreFormat(number(@area))"/><xsl:text> sq. m.)&#xd;&#xd;&#xd;</xsl:text>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Horizontal Line -->
    <xsl:template match="HorizontalLine">
        <xsl:if test="position() = 1">
            <xsl:text>Commencing at </xsl:text>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <xsl:value-of select="Start/@name"/><xsl:text>,&#xd;</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>a point,&#xd;</xsl:text></xsl:otherwise>
            </xsl:choose>
            <xsl:text>said point being the POINT OF BEGINNING;&#xd;</xsl:text>
        </xsl:if>
        <xsl:text>thence </xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@direction))"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
        <xsl:value-of select="$unit"/>
        <xsl:choose>
            <xsl:when test="End/@name">
                <xsl:text> to a point </xsl:text><xsl:value-of select="End/@name"/><xsl:text>&#xd;</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>&#xd;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Horizontal Circle -->
    <xsl:template match="HorizontalCircle">
        <xsl:if test="position() = 1">
            <xsl:text>Commencing at </xsl:text>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <xsl:value-of select="Start/@name"/><xsl:text>,&#xd;</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>a point,&#xd;</xsl:text></xsl:otherwise>
            </xsl:choose>
            <xsl:text>said point being the POINT OF BEGINNING;&#xd;</xsl:text>
        </xsl:if>
        <xsl:text>thence along an arc </xsl:text>
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
        <xsl:value-of select="$unit"/>
        <xsl:if test="Start/legalReference/@offset &gt;= 0"><xsl:text> to the right</xsl:text></xsl:if>
        <xsl:if test="Start/legalReference/@offset &lt; 0"><xsl:text> to the left</xsl:text></xsl:if>
        <xsl:text>, having&#xd;</xsl:text>
        <xsl:text>a radius of </xsl:text><xsl:value-of select="cif:distanceFormat(number(@radius))"/>
        <xsl:value-of select="$unit"/><xsl:text> the chord of which is&#xd;</xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
        <xsl:value-of select="$unit"/>
        <xsl:choose>
            <xsl:when test="End/@name">
                <xsl:text> to a point </xsl:text><xsl:value-of select="End/@name"/><xsl:text>&#xd;</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>&#xd;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Horizontal Spiral -->
    <xsl:template match="HorizontalSpiral">
        <xsl:if test="position() = 1">
            <xsl:text>Commencing at </xsl:text>
            <xsl:choose>
                <xsl:when test="Start/@name">
                    <xsl:value-of select="Start/@name"/><xsl:text>,&#xd;</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>a point,&#xd;</xsl:text></xsl:otherwise>
            </xsl:choose>
            <xsl:text>said point being the POINT OF BEGINNING;&#xd;</xsl:text>
        </xsl:if>
        <xsl:text>thence along a spiral </xsl:text>
        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
        <xsl:value-of select="$unit"/>
        <xsl:if test="Start/legalReference/@offset &gt;= 0"><xsl:text> to the right</xsl:text></xsl:if>
        <xsl:if test="Start/legalReference/@offset &lt; 0"><xsl:text> to the left</xsl:text></xsl:if>
        <xsl:text>, the chord&#xd;</xsl:text>
        <xsl:text>of which is </xsl:text>
        <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="cif:distanceFormat(number(@longChord))"/>
        <xsl:value-of select="$unit"/>
        <xsl:choose>
            <xsl:when test="End/@name">
                <xsl:text> to a point </xsl:text><xsl:value-of select="End/@name"/><xsl:text>&#xd;</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>&#xd;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <xsl:text>Notes&#xd;&#xd;</xsl:text>
        <xsl:text>    You must include at least one horizontal alignment in&#xd;</xsl:text>
        <xsl:text>    the Include field on the Tools &gt; XML Reports &gt; Legal&#xd;</xsl:text>
        <xsl:text>    Description command or the Tools &gt; XML Reports &gt;&#xd;</xsl:text>
        <xsl:text>    Geometry command to get results from this report.&#xd;&#xd;</xsl:text>
        <xsl:text>    This report requires a reference alignment to be&#xd;</xsl:text>
        <xsl:text>    specified in the Reference Alignments &gt; Include field&#xd;</xsl:text>
        <xsl:text>    on the Tools &gt; XML Reports &gt; Legal Description command&#xd;</xsl:text>
        <xsl:text>    for a complete report.&#xd;&#xd;</xsl:text>
        <xsl:text>    This report requires the horizontal alignment points to&#xd;</xsl:text>
        <xsl:text>    have names for a complete report.&#xd;&#xd;</xsl:text>
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
