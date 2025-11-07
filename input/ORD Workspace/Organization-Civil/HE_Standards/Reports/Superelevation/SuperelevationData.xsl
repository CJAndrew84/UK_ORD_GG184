<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Superelevation Data Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Superelevation Data Report</title>
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
                                <h2 lang="en">Superelevation Data Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
                            <xsl:for-each select="RoadwayDesigner">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@fileName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
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
                                <!-- Section Data -->
                                <xsl:for-each select="SuperelevationSections/SuperelevationSection">
                                    <table class="margin" cellpadding="3" width="90%">
                                        <tbody>
                                            <tr>
                                                <th align="left" lang="en" width = "15%">Section Name:&#xa0; </th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" lang="en">Base Horizontal Name:&#xa0; </th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@baseHorizontal"/>
                                                </td>
                                            </tr>
                                            <xsl:if test="Standards">
                                                <tr>
                                                    <th align="left" lang="en">Standards Filename:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@filename"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Design Speed:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@designSpeed"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Pivot Method:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@pivotMethod"/>
                                                    </td>
                                                </tr>
                                                <xsl:if test="Standards/@normalCrossSlope">
                                                    <tr>
                                                        <th align="left" lang="en">Normal Cross Slope:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="cif:gradeFormat(number(Standards/@normalCrossSlope))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="Standards/@eSelection">
                                                    <tr>
                                                        <th align="left" lang="en">E Selection:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="Standards/@eSelection"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="Standards/@lSelection">
                                                    <tr>
                                                        <th align="left" lang="en">L Selection:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="Standards/@lSelection"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                    <!-- Superelevation Control Point Data -->
                                    <table class="margin" cellpadding="3" width="95%">
                                        <xsl:for-each select="SuperelevationObjects/SuperelevationObject">
                                            <tbody>
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">Superelevation:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="@name"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="underline" lang="en" valign="bottom">Chainage</th>
                                                    <th class="underline" lang="en" valign="bottom">Cross Slope</th>
                                                    <th class="underline" lang="en" valign="bottom">Point Type</th>
                                                    <th class="underline" lang="en" valign="bottom">Transition Type</th>
                                                </tr>
                                                <xsl:for-each select="SuperelevationTransitions/SuperelevationTransition">
                                                    <tr>
                                                        <td align="center" nowrap="nowrap">
                                                            <strong>
                                                                <xsl:value-of select="cif:stationFormat(number(@externalStation), string(@externalStationName))"/>
                                                            </strong>
                                                        </td>
                                                        <td align="center">
                                                            <xsl:value-of select="cif:gradeFormat(number(@crossSlope))"/>
                                                        </td>
                                                        <xsl:choose>
                                                            <xsl:when test='@type = "FullSuper"'>
                                                                <td align="center" lang="en">Full Super</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "FullSuperIn"'>
                                                                <td align="center" lang="en">Full Super In</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "FullSuperOut"'>
                                                                <td align="center" lang="en">Full Super Out</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "NormalCrown"'>
                                                                <td align="center" lang="en">Normal Crown</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "NormalCrownIn"'>
                                                                <td align="center" lang="en">Normal Crown In</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "NormalCrownOut"'>
                                                                <td align="center" lang="en">Normal Crown Out</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "ReverseCrown"'>
                                                                <td align="center" lang="en">Reverse Crown</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "ReverseCrownIn"'>
                                                                <td align="center" lang="en">Reverse Crown In</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "ReverseCrownOut"'>
                                                                <td align="center" lang="en">Reverse Crown Out</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "SuperRunoff"'>
                                                                <td align="center" lang="en">Level Crown</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "SuperRunoffIn"'>
                                                                <td align="center" lang="en">Level Crown In</td>
                                                            </xsl:when>
                                                            <xsl:when test='@type = "SuperRunoffOut"'>
                                                                <td align="center" lang="en">Level Crown Out</td>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td align="center" lang="en">Undefined</td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:choose>
                                                            <xsl:when test='preceding-sibling::*'>
                                                                <xsl:choose>
                                                                    <xsl:when test='@transitionType = "Linear"'>
                                                                        <td align="center" lang="en">Linear</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "Parabolic"'>
                                                                        <td align="center" lang="en">Parabolic Curve</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseParabolic"'>
                                                                        <td align="center" lang="en">Reverse Parabolic Curve</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseBiquadratic"'>
                                                                        <td align="center" lang="en">Biquadratic Reverse Curve</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseCubic"'>
                                                                        <td align="center" lang="en">Cubic Reverse Curve</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseParabolicSymmetrical"'>
                                                                        <td align="center" lang="en">Reverse Parabolic Symmetrical Curve</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseParabolicNonSymmetrical1"'>
                                                                        <td align="center" lang="en">Reverse Parabolic Nonsymmetrical Curve 1</td>
                                                                    </xsl:when>
                                                                    <xsl:when test='@transitionType = "ReverseParabolicNonSymmetrical2"'>
                                                                        <td align="center" lang="en">Reverse Parabolic Nonsymmetrical Curve 2</td>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <td align="center" lang="en">Undefined</td>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td align="center" lang="en"></td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </xsl:for-each>
                                    </table>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must have defined superelevation for the section.
            </p>
            <p class="normal1" lang="en">
                You must select at least one superelevation section.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>