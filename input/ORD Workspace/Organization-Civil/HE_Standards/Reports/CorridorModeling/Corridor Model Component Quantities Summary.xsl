<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:include href="../format.xsl"/>
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Variable to hold cubic factor -->
    <xsl:variable name="cubicFactor">
        <xsl:choose>
            <xsl:when test="//@linearUnits = 'Imperial'">
                <xsl:choose>
                    <xsl:when test="$xslConvertToCY = 1">27</xsl:when>
                    <xsl:otherwise>1</xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- Volumes Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Volumes Report</title>
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
                                <h2 lang="en">Corridor Model Component Quantities Summary Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Cross Section Set Data -->
                            <xsl:for-each select="CrossSectionSet">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Corridor Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@setName"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Alignment Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@alignmentName"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">
                                                    <xsl:choose>
                                                        <xsl:when test="$xslConvertToCY = 1">
                                                            feet, square feet and cubic yards
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            feet, square feet and cubic feet
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">
                                                    meters, square meters and cubic meters
                                                </xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Volume Data -->
                                <table class="margin" width="90%" border="1">
                                    <xsl:for-each select="CrossSectionStations">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th lang="en" valign="bottom" align="right">Material</th>
                                                <th lang="en" valign="bottom" align="right">Component Volume Totals</th>
                                                <th lang="en" valign="bottom" align="right">Component Surface Area Totals</th>
                                                <th lang="en" valign="bottom" align="right">Unit Cost</th>
                                                <th lang="en" valign="bottom" align="right">Material Cost</th>
                                            </tr>
                                        </thead>
                                        <xsl:for-each select="CrossSectionStation">
                                            <tfoot style="display:table-footer-group">
                                                <xsl:if test="position() = last()">
                                                    <xsl:for-each select="StationVolume">
                                                        <tr><td colspan="5"><hr/></td></tr>
                                                        <xsl:apply-templates mode="final"/>
                                                        <tr>
                                                            <th colspan="4" align="right">
                                                                Total Estimated Cost:                                                           
                                                            </th>
                                                            <th  align="right">
                                                                <xsl:value-of select="cif:formatNumber(number(//@totalCost), 2)"/>
                                                            </th>
                                                        </tr>
                                                        
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </tfoot>
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
    <xsl:template match="StationVolume">
        <tr>
            <th align="left" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
            </th>
            <td colspan="5">&#xa0;</td>
        </tr>
    </xsl:template>
    <xsl:template match="Material" mode="final">
        <tr>
            <td align="right" colspan="1"><xsl:value-of select="@name"/>&#xa0; </td>
            <xsl:choose>
                <xsl:when test="@cumulativeVolume != 0.0">
                    <td colspan="1" align="right">
                        <xsl:value-of select="cif:cubicFormat(number(@cumulativeVolume div $cubicFactor))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td colspan="1">&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@cumulativeArea != 0.0">
                    <td colspan="1" align="right">
                        <xsl:value-of select="cif:cubicFormat(number(@cumulativeArea))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td colspan="1">&#xa0;</td>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@volume != 0.0">
                    <td align="right">
                        <xsl:value-of select="cif:formatNumber(number(@unitCost), 2)"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td align="right">
                        <xsl:value-of select="cif:formatNumber(number(@unitCost), 2)"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number((@cumulativeArea + @cumulativeVolume) * @unitCost), 2)"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must click the <em>Report </em> button from within <em>Component Quantities</em> to generate a report from this         
                command.  Alternately, you can open this report from the Civil Report Browser if another Component Quantities report has already been generated. 
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
