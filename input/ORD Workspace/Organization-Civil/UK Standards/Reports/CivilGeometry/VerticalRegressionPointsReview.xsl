<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Vertical Regression Points Review Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Vertical Regression Points Review Report</h2>
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
                                            <th align="right" colspan="2" lang="en">Alignment Description:&#xa0; </th>
                                            <td align="left" colspan="4"><xsl:value-of select="@description"/></td>
                                        </tr>
                                    </thead>
                                    <xsl:for-each select="VerticalAlignment">
                                        <tbody>
                                            <tr><td colspan="6">&#xa0;</td></tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Vertical Alignment Name:&#xa0; </th>
                                                <td align="left" colspan="4"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Description:&#xa0; </th>
                                                <td align="left" colspan="4"><xsl:value-of select="@description"/></td>
                                            </tr>
                                            <tr><td colspan="9">&#xa0;</td></tr>
                                            <xsl:for-each select="RegressionPoints">
                                                <tr>
                                                    <th class="underline" lang="en" align="left">Point Index</th>
                                                    <th class="underline" lang="en" align="right">Chainage</th>
                                                    <th class="underline" lang="en" align="right">Elevation<br/>(Regression Point)</th>
                                                    <th class="underline" lang="en" align="right">Tangential Gradient</th>
                                                    <th class="underline" lang="en" align="center">Point Type</th>
                                                    <th class="underline" lang="en" align="right">X</th>
                                                    <th class="underline" lang="en" align="right">Y</th>
                                                    <th class="underline" lang="en" align="right">Elevation<br/>(On Profile)</th>
                                                    <th class="underline" lang="en" align="right">Lift</th>
                                                </tr>
                                                <xsl:for-each select="RegressionPoint">
                                                    <tr>
                                                        <td align="left">
                                                            <xsl:value-of select="@index"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:gradeFormat(number(@slope))"/>
                                                        </td>
                                                        <td align="center">
                                                            <xsl:value-of select="GeometryPoint/@type"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@lift))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
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
