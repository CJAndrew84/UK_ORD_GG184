<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Template Drop Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Template Drop Report</title>
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
                                <h2 lang="en">Template Drop Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Roadway Designer Data -->
                            <xsl:for-each select="RoadwayDesigner">
                                <table class="margin" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left"><xsl:value-of select="@fileName"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left"><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Corridor Information -->
                                <table class="margin" width="50%">
                                    <xsl:for-each select="Corridor">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th align="left" lang="en">Corridor:&#xa0; </th>
                                                <td colspan="3"><xsl:value-of select="@name"/></td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Start Chainage</th>
                                                <th class="underline" lang="en">Stop Chainage</th>
                                                <th class="underline" lang="en">Interval</th>
                                                <th class="underline" lang="en">Template</th>
                                                <th class="underline" lang="en">Revised In</th>
                                                <th class="underline" lang="en">Description</th>
                                            </tr>
                                        </thead>
                                        <xsl:for-each select="TemplateDrop">
                                            <tbody>
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right"><xsl:value-of select="cif:distanceFormat(number(@interval))"/></td>
                                                    <td class="sidepad"><xsl:value-of select="Template/@name"/></td>
                                                    <td class="sidepad">
                                                        <xsl:choose>
                                                            <xsl:when test="Template/@revisedInIRD = 'true'">IRD</xsl:when>
                                                            <xsl:otherwise>ITL</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                    <td class="sidepad">
                                                        <xsl:value-of select="Template/@description"/>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </xsl:for-each>
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
                You must select a corridor with a minimum of one template drop to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
