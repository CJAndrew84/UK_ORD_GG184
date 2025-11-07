<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Station Equations Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Station Equations Report</h2>
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
                                    <colgroup span="5">
                                        <col width="18%"/>
                                        <col width="13%"/>
                                        <col width="25%"/>
                                        <col width="22%"/>
                                        <col width="22%"/>
                                    </colgroup>
                                    <xsl:for-each select="HorizontalAlignment">
                                        <tbody>
                                            <tr>
                                                <th align="right" colspan="2" lang="en"><br />Alignment Name:&#xa0;</th>
                                                <td align="left" colspan="3" valign="bottom"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Description:&#xa0;</th>
                                                <td align="left" colspan="3"><xsl:value-of select="@description"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Alignment Style:&#xa0;</th>
                                                <td align="left" colspan="3"><xsl:value-of select="@style"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" class="underline" lang="en">Internal Chainage</th>
                                                <th align="right" class="underline" lang="en">Back Chainage</th>
                                                <th align="right" class="underline" lang="en">Ahead Chainage</th>
                                                <th align="right" class="underline" lang="en">X</th>
                                                <th align="right" class="underline" lang="en">Y</th>
                                            </tr>
                                            <xsl:apply-templates/>
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
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(GeometryPoint/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalCircle">
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(GeometryPoint/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template match="HorizontalSpiral">
        <xsl:if test="StationEquation">
            <xsl:for-each select="StationEquation">
                <tr>
                    <td align="right">
                        <xsl:value-of select="cif:distanceFormat(number(GeometryPoint/station/@internalStation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@backStation), string(@backEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:stationFormat(number(@aheadStation), string(@aheadEquation))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@easting))"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="cif:ordinateFormat(number(GeometryPoint/@northing))"/>
                    </td>
                </tr>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must select at least one Civil horizontal geometry element containing at least one station equation to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
