<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))" />
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Vertical Alignment Points with XY Coordinates Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Vertical Alignment Points with XY Coordinates Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br />
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

                                <xsl:for-each select="HorizontalAlignment[VerticalAlignment]">
                                    <table class="margin" width="90%">
                                        <thead>
                                            <tr>
                                                <th align="right" colspan="2" lang="en"><br/>Horizontal Alignment:</th>
                                                <td align="left" colspan="4" valign="bottom"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Horizontal Description:</th>
                                                <td align="left" colspan="4"><xsl:value-of select="@description"/></td>
                                            </tr>
                                            <tr>
                                                <th align="right" colspan="2" lang="en">Horizontal Style:</th>
                                                <td align="left" colspan="4"><xsl:value-of select="@style"/></td>
                                            </tr>
                                            <tr>
                                                <th colspan="6">&#xa0;</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="VerticalAlignment">
                                                <tr>
                                                    <th align="right" colspan="2" lang="en"><br/>Vertical Alignment:</th>
                                                    <td align="left" colspan="4" valign="bottom"><xsl:value-of select="@name"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">Vertical Description:</th>
                                                    <td align="left" colspan="4"><xsl:value-of select="@description"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" colspan="2" lang="en">Vertical Style:</th>
                                                    <td align="left" colspan="4"><xsl:value-of select="@style"/></td>
                                                </tr>
                                                <tr>
                                                    <th colspan="2"/>
                                                    <th align="right" class="underline" lang="en">Chainage</th>
                                                    <th align="right" class="underline" lang="en">Elevation</th>
                                                    <th align="right" class="underline" lang="en">X</th>
                                                    <th align="right" class="underline" lang="en">Y</th>
                                                </tr>
                                                <xsl:apply-templates/>
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

    <xsl:template match="VerticalLine">
        <tr>
            <td align="left" colspan="6" lang="en"><br/>Element: Linear</td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@northing))"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalSymmetricalParabola">
        <tr>
            <td align="left" colspan="6" lang="en"><br/>Element: Symmetrical Parabola</td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(PVI/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@northing))"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalUnsymmetricalParabola">
        <tr>
            <td align="left" colspan="6" lang="en"><br/>Element: Unsymmetrical Parabola</td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(PVI/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(PVI/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(PVI/@northing))"/>
          </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(PVCC/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVCC/station/@externalStation), string(PVCC/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVCC/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVCC/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVCC/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@northing))"/>
          </td>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalCircle">
        <tr>
            <td align="left" colspan="6" lang="en"><br/>Element: Circular</td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(PVI/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(PVI/@easting))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:ordinateFormat(number(PVI/@northing))"/>
          </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalCenter/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalCenter/station/@externalStation), string(VerticalCenter/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalCenter/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalCenter/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalCenter/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@northing))"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="VerticalClothoid">
        <tr>
            <td align="left" colspan="6" lang="en"><br/>Element: Clothoid</td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalStart/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalStart/station/@externalStation), string(VerticalStart/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalStart/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(PVI/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(PVI/station/@externalStation), string(PVI/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(PVI/@northing))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2"><xsl:value-of select="cif:pointType(string(VerticalEnd/@pointType))"/></td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(VerticalEnd/station/@externalStation), string(VerticalEnd/station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@elevation))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@easting))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:ordinateFormat(number(VerticalEnd/@northing))"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must include at least one Civil vertical geometry element to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
