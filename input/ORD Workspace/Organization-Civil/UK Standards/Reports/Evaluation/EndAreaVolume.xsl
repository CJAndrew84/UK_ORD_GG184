<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:param name="xslConvertToCY" select="cif:xslConvertToCY"/>
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
    <!-- End Area Volume Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">End Area Volume Report</title>
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
                                <h2 lang="en">End Area Volume Report</h2>
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
                                            <th align="right" lang="en" nowrap="nowrap">Cross Section Set Name:&#xa0; </th>
                                            <td align="left" colspan="3">
                                                <xsl:value-of select="@setName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" nowrap="nowrap">Alignment Name:&#xa0; </th>
                                            <td align="left" colspan="3">
                                                <xsl:value-of select="@alignmentName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%" nowrap="nowrap" valign="top">
                                                Input Grid Factor: &#xa0;
                                            </th>
                                            <td align="left" style="font-size: 80%" valign="top">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
                                            <th align="right" lang="en" style="font-size: 80%" nowrap="nowrap" valign="top">
                                                &#xa0; Note: &#xa0;
                                            </th>
                                            <td align="left" lang="en" style="font-size: 80%">
                                                All units in this report are in
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
                                <table width="100%">
                                    <xsl:for-each select="CrossSectionStations">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th class="underline" lang="en" rowspan="3" valign="bottom">
                                                    Baseline<br/>Station
                                                </th>
                                                <th colspan="8" lang="en">- - - - - - - - - - - - - - - - Station Quantities - - - - - - - - - - - - - - - -</th>
                                                <th colspan="6" lang="en">- - - - - - - - - - - - Added Quantities - - - - - - - - - - - -</th>
                                                <th class="underline" lang="en" rowspan="3" valign="bottom">
                                                    <br/>Mass<br/>Ordinate
                                                </th>
                                            </tr>
                                            <tr>
                                                <th colspan="4" lang="en">- - - - - - - - - - Cut - - - - - - - - - -</th>
                                                <th colspan="4" lang="en">- - - - - - - - - - Fill - - - - - - - - - -</th>
                                                <th colspan="3" lang="en">- - - - - - - - Cut - - - - - - - -</th>
                                                <th colspan="3" lang="en">- - - - - - - - Fill - - - - - - - -</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Factor</th>
                                                <th class="underline" lang="en">Area</th>
                                                <th class="underline" lang="en">Volume</th>
                                                <th class="underline" lang="en">Adjusted</th>
                                                <th class="underline" lang="en">Factor</th>
                                                <th class="underline" lang="en">Area</th>
                                                <th class="underline" lang="en">Volume</th>
                                                <th class="underline" lang="en">Adjusted</th>
                                                <th class="underline" lang="en">Factor</th>
                                                <th class="underline" lang="en">Volume</th>
                                                <th class="underline" lang="en">Adjusted</th>
                                                <th class="underline" lang="en">Factor</th>
                                                <th class="underline" lang="en">Volume</th>
                                                <th class="underline" lang="en">Adjusted</th>
                                            </tr>
                                        </thead>
                                        <xsl:for-each select="CrossSectionStation">
                                            <tbody>
                                                <xsl:apply-templates/>
                                            </tbody>
                                            <tfoot style="display:table-footer-group">
                                                <xsl:if test="position() = last()">
                                                    <xsl:call-template name="grandTotal">
                                                        <xsl:with-param name="allVolumes" select="../*/StationVolume"/>
                                                    </xsl:call-template>
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
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(CutMaterial/@factor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:areaFormat(number(CutMaterial/@area))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(CutMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(CutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(FillMaterial/@factor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:areaFormat(number(FillMaterial/@area))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(FillMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(FillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(AddedCutMaterial/@factor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(AddedFillMaterial/@factor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@massOrdinate div $cubicFactor))"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="DerivedStationVolume">
        <tr>
            <td colspan="16">
                <hr size="1px"/>
            </td>
        </tr>
        <tr>
            <td align="right" nowrap="nowrap">
                <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
            </td>
            <td colspan="14">&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@massOrdinate div $cubicFactor))"/>
            </td>
        </tr>
        <tr>
            <td colspan="16" height="50%">
                <hr size="1px"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="grandTotal">
        <xsl:param name="allVolumes"/>
        <tr>
            <td colspan="16">
                <hr/>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">Grand Total:</td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/CutMaterial/@cumulativeVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/CutMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
            </td>
            <td colspan="2">&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/FillMaterial/@cumulativeVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/FillMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
            </td>
            <td>&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/AddedCutMaterial/@cumulativeVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/AddedCutMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
            </td>
            <td>&#xa0;</td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/AddedFillMaterial/@cumulativeVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number($allVolumes[position() = last()]/AddedFillMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
            </td>
        </tr>
        <tr>
            <td colspan="16">
                <hr/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must have created cross sections along your alignment and the cross section set must
                have the surfaces and features upon which you wish to report displayed.
            </p>
            <p class="normal1" lang="en">
                You can create the XML data file from the <em>End-Area Volumes</em> leaf of the <em>
                    Evaluation &gt; Cross Section &gt; Cross Sections
                </em> command by toggling on the <em>
                    Create XML Report
                </em> option on the <em>General</em> leaf or from the <em>
                    Evaluation &gt;
                    Cross Section &gt; Cross Section Report
                </em> command by toggling on the <em>
                    Include Volumes
                </em> option on the <em>Main</em> tab.
            </p>
            <p class="normal1" lang="en">
                This report is not suitable for datasets containing material quantities or MDC.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
