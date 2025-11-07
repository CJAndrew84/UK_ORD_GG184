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
                            <left>
                                <!-- Report Title -->
                                <h2 lang="en">End Area Volume Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </left>
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
                                                    Baseline<br/>Chainage / Component
                                                </th>
                                                <th colspan="7" lang="en">- - - - - - - - - - - - - - - - Chainage Quantities - - - - - - - - - - - - - - - -</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">Factor</th>
                                                <th class="underline" lang="en">Area</th>
                                                <th class="underline" lang="en">Volume</th>
                                                <th class="underline" lang="en">Adjusted<br/>Volume</th>
                                                <th class="underline" lang="en">Cumulative<br/>Area</th>
                                                <th class="underline" lang="en">Cumulative<br/>Volume</th>
                                                <th class="underline" lang="en">Cumulative Adjusted<br/>Volume</th>
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
			<td align="left" nowrap="nowrap">
				<xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
			</td>
		</tr>
		<xsl:for-each select="./Materials/Material">
		<tr>
			<td align="right">
				<xsl:value-of select="@name"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:distanceFormat(number(@factor))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:areaFormat(number(@area))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:cubicFormat(number(@volume div $cubicFactor))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:distanceFormat(number(@cumulativeArea))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:areaFormat(number(@cumulativeVolume))"/>
			</td>
			<td align="right">
				<xsl:value-of select="cif:cubicFormat(number(@cumulativeAdjustedVolume div $cubicFactor))"/>
			</td>
		</tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="grandTotal">
        <xsl:param name="allVolumes"/>
        <tr>
            <td colspan="16">
                <hr/>
            </td>
		</tr>
        <tr>

		<td class="underline" align="right">GRAND TOTALS</td>
		<td class="underline" align="right">Volume</td>
		<td class="underline" align="right">Adjusted Volume</td>

		<xsl:for-each select="$allVolumes[position() = last()]/Materials/Material">
		<tr>
			<td align="right">
				<xsl:value-of select="@name"/>
			</td>           
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeAdjustedVolume div $cubicFactor))"/>
            </td>
		</tr>
        </xsl:for-each>
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
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
