<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Horizontal Regression Points Review Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Horizontal Regression Points Review Report</h2>
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
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/>
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

                                <xsl:for-each select="HorizontalAlignment">
                                    <table class="margin" width="90%">
                                        <thead>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Name:&#xa0; </th>
                                                <td align="left" colspan="4"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Regression Line Name:&#xa0; </th>
                                                <td align="left" colspan="4"><xsl:value-of select="RegressionPoints/@regressionLineName"/></td>
                                            </tr>
                                        </thead>

                                        <xsl:for-each select="RegressionPoints">
                                            <tbody>
                                                <tr><td colspan="9">&#xa0;</td></tr>
                                                <tr>
                                                    <th class="underline" lang="en" align="left">Point Index</th>
                                                    <th class="underline" lang="en" align="right">X</th>
                                                    <th class="underline" lang="en" align="right">Y</th>
                                                    <th class="underline" lang="en" align="right">Elevation</th>
                                                    <th class="underline" lang="en" align="right">Instantaneous Radius</th>
                                                    <th class="underline" lang="en" align="right">Tangential Direction</th>
                                                    <th class="underline" lang="en" align="right">Radial Direction</th>
                                                    <th class="underline" lang="en" align="center">Point Type</th>
                                                    <th class="underline" lang="en" align="right">Chainage</th>
                                                    <th class="underline" lang="en" align="right">Slew</th>
                                                </tr>
                                                <xsl:for-each select="RegressionPoint">
                                                    <tr>
                                                        <td align="left">
                                                            <xsl:value-of select="@index"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(regressionLinePoint/point/@easting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(regressionLinePoint/point/@northing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(regressionLinePoint/point/@elevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(regressionLinePoint/@instantaneousRadius))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:directionFormat(number(regressionLinePoint/@tangentialDirection))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:directionFormat(number(regressionLinePoint/@radialDirection))"/>
                                                        </td>
                                                        <td align="center">
                                                            <xsl:value-of select="centerLinePoint/point/@type"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@slew))"/>
                                                        </td>
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
        <xsl:text>Copyright 2018 Bentley Systems, Inc&#xd;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
