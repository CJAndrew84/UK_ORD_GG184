<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Profile Chainage Elevation Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>

                                <h2 lang="en">Profile Chainage Elevation Report</h2>
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

                                <xsl:for-each select="HorizontalAlignment">
                                    <table class="margin" width="45%">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <td colspan="3" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; Alignment Name:&#xa0; </strong>
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" lang="en">
                                                    <strong>Alignment Description:&#xa0; </strong>
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; &#xa0;Alignment Style:&#xa0; </strong>
                                                    <xsl:value-of select="@style"/><br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="underline" align="center" lang="en">Chainage</th>
                                                <th class="underline" align="center" lang="en">Elevation</th>
                                                <th class="underline" align="center" lang="en">Gradient</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="HorizontalEventPoints/*/HorizontalEventPoint">
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(GeometryPoint/station/@externalStation), string(GeometryPoint/station/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@elevation))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:gradeFormat(number(@grade))"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
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
                You must select at least one Civil vertical geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
