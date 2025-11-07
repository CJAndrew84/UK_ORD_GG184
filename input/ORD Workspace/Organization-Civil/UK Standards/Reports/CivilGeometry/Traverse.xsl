<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:variable name="linearUnit">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">ft</xsl:when>
            <xsl:otherwise>m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="areaUnit1">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">sq ft</xsl:when>
            <xsl:otherwise>sq m</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="areaUnit2">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">ac</xsl:when>
            <xsl:otherwise>hec</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Traverse Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Traverse Report</h2>
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

                                <table class="margin" width="75%">
                                    <xsl:for-each select="HorizontalAlignment">
                                        <thead>
                                            <tr>
                                                <th align="right" lang="en"><br />Alignment Name:&#xa0; </th>
                                                <td align="left" valign="bottom"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" lang="en" width="40%">Alignment Description:&#xa0; </th>
                                                <td align="left" width="60%"><xsl:value-of select="@description"/></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="2">
                                                    <table width="100%">
                                                        <tr><td colspan="4">&#xa0;</td></tr>
                                                        <xsl:for-each select="HorizontalElements">
                                                            <xsl:apply-templates select="//HorizontalLine | //HorizontalCircle | //HorizontalSpiral"/>
                                                        </xsl:for-each>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr><td colspan="4">&#xa0;</td></tr>
                                            <tr>
                                                <td colspan="2">
                                                    <xsl:if test="@eastingClosingError">
                                                        <table width="80%">
                                                            <tr>
                                                                <th align="left" lang="en">X Error: &#xa0;</th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@eastingClosingError))"/>
                                                                </td>
                                                                <td><xsl:value-of select="$linearUnit"/></td>
                                                                <td colspan="2">&#xa0;</td>
                                                            </tr>
                                                            <tr>
                                                                <th align="left" lang="en">Y Error: &#xa0;</th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@northingClosingError))"/>
                                                                </td>
                                                                <td><xsl:value-of select="$linearUnit"/></td>
                                                                <td colspan="2">&#xa0;</td>
                                                            </tr>
                                                            <tr>
                                                                <th align="left" lang="en">Closing Direction: &#xa0;</th>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:directionFormat(number(@closingDirection))"/>
                                                                </td>
                                                                <td colspan="3">&#xa0;</td>
                                                            </tr>
                                                            <tr>
                                                                <th align="left" lang="en">Closing Distance: &#xa0;</th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@closingDistance))"/>
                                                                </td>
                                                                <td><xsl:value-of select="$linearUnit"/></td>
                                                                <td colspan="2">&#xa0;</td>
                                                            </tr>
                                                            <xsl:if test="@area">
                                                                <tr>
                                                                    <th align="left" lang="en">Closed Area: &#xa0;</th>
                                                                    <td align="right">
                                                                        <xsl:value-of select="cif:areaFormat(number(@area))"/>
                                                                    </td>
                                                                    <td style="white-space:nowrap"><xsl:value-of select="$areaUnit1"/></td>
                                                                    <xsl:choose>
                                                                        <xsl:when test="//@linearUnits = 'Imperial'">
                                                                            <td align="right">
                                                                                <xsl:value-of select="cif:areaFormat(number(@area div 43560))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td align="right">
                                                                                <xsl:value-of select="cif:areaFormat(number(@area div 10000))"/>
                                                                            </td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                    <td style="white-space:nowrap"><xsl:value-of select="$areaUnit2"/></td>
                                                                </tr>
                                                                <tr>
                                                                    <th align="left" lang="en">Perimeter: &#xa0;</th>
                                                                    <td align="right">
                                                                        <xsl:value-of select="cif:distanceFormat(number(@perimeter))"/>
                                                                    </td>
                                                                    <td><xsl:value-of select="$linearUnit"/></td>
                                                                    <td colspan="2">&#xa0;</td>
                                                                </tr>
                                                            </xsl:if>
                                                            <tr>
                                                                <th align="left" lang="en">Precision: &#xa0;</th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@closingPrecision))"/>
                                                                </td>
                                                                <td>&#xa0;</td>
                                                                <td colspan="2">&#xa0;</td>
                                                            </tr>
                                                        </table>
                                                    </xsl:if>
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

    <xsl:template match="HorizontalLine">
        <tr>
            <td>
                <xsl:value-of select="cif:pointType(string(Start/@pointType))"/>
                <xsl:if test="Start/@name">
                    (<xsl:value-of select="Start/@name"/>)
                </xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
            </td>
            <td colspan="2">&#xa0;</td>
        </tr>
        <xsl:if test="position() = last()">
            <tr>
                <td>
                    <xsl:value-of select="cif:pointType(string(End/@pointType))"/>
                    <xsl:if test="End/@name">
                        (<xsl:value-of select="End/@name"/>)
                    </xsl:if>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <tr>
            <td>
                <xsl:value-of select="cif:pointType(string(Start/@pointType))"/>
                <xsl:if test="Start/@name">
                    (<xsl:value-of select="Start/@name"/>)
                </xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
            </td>
            <td colspan="2">&#xa0;</td>
        </tr>
        <tr>
            <td>
                <xsl:value-of select="cif:pointType(string(Center/@pointType))"/>
                <xsl:if test="Center/@name">
                    (<xsl:value-of select="Center/@name"/>)
                </xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Center/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
            </td>
            <td colspan="2">&#xa0;</td>
        </tr>
        <xsl:if test="position() = last()">
            <tr>
                <td>
                    <xsl:value-of select="cif:pointType(string(End/@pointType))"/>
                    <xsl:if test="End/@name">
                        (<xsl:value-of select="End/@name"/>)
                    </xsl:if>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="HorizontalSpiral">
        <tr>
            <td>
                <xsl:value-of select="cif:pointType(string(Start/@pointType))"/>
                <xsl:if test="Start/@name">
                    (<xsl:value-of select="Start/@name"/>)
                </xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(Start/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
            </td>
            <td align="right">
                <xsl:choose>
                    <xsl:when test="@compound = 'false'">
                        <xsl:choose>
                            <xsl:when test="@startRadius &gt; @endRadius">
                                <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="@startRadius &gt; @endRadius">
                                <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="2">&#xa0;</td>
        </tr>
        <tr>
            <td>
                <xsl:value-of select="cif:pointType(string(PI/@pointType))"/>
                <xsl:if test="PI/@name">
                    (<xsl:value-of select="PI/@name"/>)
                </xsl:if>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@northing))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PI/@elevation))"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
            </td>
            <td align="right">
                <xsl:choose>
                    <xsl:when test="@compound = 'false'">
                        <xsl:choose>
                            <xsl:when test="@startRadius &gt; @endRadius">
                                <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="@startRadius &gt; @endRadius">
                                <xsl:value-of select="cif:distanceFormat(number(@shortTangent))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="cif:distanceFormat(number(@longTangent))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="2">&#xa0;</td>
        </tr>
        <xsl:if test="position() = last()">
            <tr>
                <td>
                    <xsl:value-of select="cif:pointType(string(End/@pointType))"/>
                    <xsl:if test="End/@name">
                        (<xsl:value-of select="End/@name"/>)
                    </xsl:if>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@easting))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@northing))"/>
                </td>
                <td align="right">
                    <xsl:value-of select="cif:ordinateFormat(number(End/@elevation))"/>
                </td>
            </tr>
        </xsl:if>
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
