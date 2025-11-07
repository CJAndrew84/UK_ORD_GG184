<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Traverse Points Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Traverse Points Report</h2>
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

                                <table class="margin" width="90%">
                                    <xsl:for-each select="HorizontalAlignment">
                                        <thead>
                                            <tr>
                                                <th align="right" lang="en" width="25%"><br/>Alignment Name:&#xa0; </th>
                                                <td align="left" valign="bottom" width="75%"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" lang="en">Alignment Description:&#xa0; </th>
                                                <td align="left"><xsl:value-of select="@description"/></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="2">
                                                    <table width="100%">
                                                        <thead>
                                                            <tr>
                                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Point<br/>Type</th>
                                                                <th colspan="2" lang="en" valign="bottom">- - - - Back - - - -</th>
                                                                <th colspan="2" lang="en" valign="bottom">- - - - Ahead - - - -</th>
                                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Deflection</th>
                                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Angle<br/>Left</th>
                                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Angle<br/>Right</th>
                                                            </tr>
                                                            <tr>
                                                                <th class="underline" lang="en" valign="bottom">Distance</th>
                                                                <th class="underline" lang="en" valign="bottom">Direction</th>
                                                                <th class="underline" lang="en" valign="bottom">Distance</th>
                                                                <th class="underline" lang="en" valign="bottom">Direction</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <xsl:for-each select="HorizontalTraversePoints/HorizontalTraversePoint">
                                                                <tr>
                                                                    <td><xsl:value-of select="cif:pointType(string(TraversePoint/@pointType))"/></td>
                                                                    <xsl:choose>
                                                                        <xsl:when test="@distanceBack">
                                                                            <td align="right">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceBack))"/>
                                                                            </td>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:value-of select="cif:directionFormat(number(@directionBack))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td colspan="2">&#xa0;</td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                    <xsl:choose>
                                                                        <xsl:when test="@distanceAhead">
                                                                            <td align="right">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceAhead))"/>
                                                                            </td>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:value-of select="cif:directionFormat(number(@directionAhead))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td colspan="2">&#xa0;</td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                    <xsl:choose>
                                                                        <xsl:when test="@deflection">
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:value-of select="cif:angularFormat(number(@deflection))"/>
                                                                            </td>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:value-of select="cif:angularFormat(number(@angleLeft))"/>
                                                                            </td>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:value-of select="cif:angularFormat(number(@angleRight))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td colspan="3">&#xa0;</td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </xsl:for-each>
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
                You must select at least one Civil horizontal geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
