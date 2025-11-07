<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Curve Data Table -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Curve Data Table</title>
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
                                <h2 lang="en">Curve Data Table</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
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
                                <hr/><br/>
                                <table border="1" cellpadding="2" cellspacing="0">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th lang="en" colspan="6">CURVE DATA</th>
                                        </tr>
                                        <tr>
                                            <th class="sidepad" lang="en">NO.</th>
                                            <th class="sidepad" lang="en">RADIUS</th>
                                            <th class="sidepad" lang="en">DELTA</th>
                                            <th class="sidepad" lang="en">LENGTH</th>
                                            <th class="sidepad" lang="en">TANGENT</th>
                                            <th class="sidepad" lang="en">ALIGNMENT</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Horizontal Alignment Data -->
                                        <xsl:for-each select="HorizontalAlignment">
                                            <xsl:for-each select="HorizontalElements">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>
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
    <!-- Horizontal Circular Data -->
    <xsl:template match="HorizontalCircle">
        <tr>
            <td class="sidepad" align="center" lang="en">
                C<xsl:call-template name="eleNumber"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
            </td>
            <td class="sidepad" align="right" style="white-space:nowrag">
                <xsl:value-of select="cif:angularFormat(number(@delta))"/>
            </td>
            <td class="sidepad" align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td class="sidepad" align="right" style="white-space:nowrap">
                <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
            </td>
            <td class="sidepad" align="center">
                <xsl:value-of select="../../@name"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="eleNumber">
        <xsl:number count="HorizontalCircle" level="any"/>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
