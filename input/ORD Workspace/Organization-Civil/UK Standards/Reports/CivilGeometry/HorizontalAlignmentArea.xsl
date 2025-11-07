<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!--Area Report-->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!--Title displayed in browser Title Bar-->
                <title lang="en">Area Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <!--Report Title-->
                                <h2 lang="en">Area Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!--Project Data-->
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
                                <hr/>
                                <table class="margin" cellpadding="2" width="50%">
                                    <thead>
                                        <tr>
                                            <xsl:if test="//@linearUnits = 'Imperial'">
                                                <th class="underline" lang="en">Lot</th>
                                                <th class="underline" lang="en">Area (sq ft)</th>
                                                <th class="underline" lang="en">Area (acres)</th>
                                                <th class="underline" lang="en">Perimeter (ft)</th>
                                            </xsl:if>
                                            <xsl:if test="//@linearUnits =   'Metric'">
                                                <th class="underline" lang="en">Lot</th>
                                                <th class="underline" lang="en">Area (sq m)</th>
                                                <th class="underline" lang="en">Area (hectares)</th>
                                                <th class="underline" lang="en">Perimeter (m)</th>
                                            </xsl:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!--Horizontal Alignment Data-->
                                        <xsl:for-each select="HorizontalAlignment[@area > 0]">
                                            <tr>
                                                <td class="sidepad" align="left"><xsl:value-of select="@name"/></td>
                                                <td class="sidepad" align="right">
                                                    <xsl:value-of select="cif:areaFormat(number(@area))"/>
                                                </td>
                                                <td class="sidepad" align="right">
                                                    <xsl:if test="//@linearUnits = 'Imperial'">
                                                        <xsl:value-of select="cif:acreFormat(number(@area) div 43560)"/>
                                                    </xsl:if>
                                                    <xsl:if test="//@linearUnits = 'Metric'">
                                                        <xsl:value-of select="cif:acreFormat(number(@area) div 10000)"/>
                                                    </xsl:if>
                                                </td>
                                                <td class="sidepad" align="right">
                                                    <xsl:value-of select="cif:distanceFormat(number(@perimeter))"/>
                                                </td>
                                            </tr>
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
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil closed horizontal geometry element (or ability to close by connecting the initial and ending point) to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
