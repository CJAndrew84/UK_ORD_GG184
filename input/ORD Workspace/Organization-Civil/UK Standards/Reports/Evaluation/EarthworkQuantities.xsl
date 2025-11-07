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
    <!-- Earthwork Quantities Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Earthwork Quantities Report</title>
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
                                <h2 lang="en">Earthwork Quantities Report</h2>
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
                                            <th align="right" lang="en">Cross Section Set Name:&#xa0; </th>
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
                                    <colgroup span="14">
                                        <col width="8%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="7%"/>
                                        <col width="8%"/>
                                    </colgroup>
                                    <xsl:for-each select="CrossSectionStations">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Baseline<br/>Station</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Cut<br/>Shrink/<br/>Swell<br/>Factor</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Station<br/>Cut<br/>Area</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Station<br/>Cut<br/>Volume</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Adjusted<br/>Station<br/>Cut</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Fill<br/>Shrink/<br/>Swell<br/>Factor</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Station<br/>Fill<br/>Area</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Station<br/>Fill<br/>Volume</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Adjusted<br/>Station<br/>Fill</th>
                                                <th colspan="4" lang="en" valign="bottom">- - - - - - - Added Quantities - - - - - - -</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Mass<br/>Ordinate</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en" valign="bottom">Cut</th>
                                                <th class="underline" lang="en" valign="bottom">Adjusted<br/>Cut</th>
                                                <th class="underline" lang="en" valign="bottom">Fill</th>
                                                <th class="underline" lang="en" valign="bottom">Adjusted<br/>Fill</th>
                                            </tr>
                                        </thead>
                                        <xsl:for-each select="CrossSectionStation">
                                            <tbody>
                                                <xsl:apply-templates/>
                                            </tbody>
                                            <tfoot style="display:table-footer-group">
                                                <xsl:if test="position() = last()">
                                                    <tr><td colspan="14"><hr/></td></tr>
                                                    <tr>
                                                        <td align="center" colspan="3">Grand Total:</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number((StationVolume/CutMaterial/@cumulativeVolume + sum(StationVolume/*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeVolume) + sum(StationVolume/*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeVolume)) div $cubicFactor))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number((StationVolume/CutMaterial/@cumulativeAdjustedVolume + StationVolume/Materials/MDCMaterials/Material/MDC/@cumulativeAdjustedVolume + sum(StationVolume/*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeAdjustedVolume) + sum(StationVolume/*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeAdjustedVolume)) div $cubicFactor))"/>
                                                        </td>
                                                        <td colspan="2">&#xa0;</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number((StationVolume/FillMaterial/@cumulativeVolume + sum(StationVolume/*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@cumulativeVolume) + sum(StationVolume/*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeVolume)) div $cubicFactor))"/>
                                                        </td>
                                                        <xsl:choose>
                                                            <xsl:when test="//MDCMaterials">
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:cubicFormat(number((StationVolume/FillMaterial/@cumulativeAdjustedVolume + StationVolume/Materials/MDCMaterials/Material/@cumulativeAdjustedVolume + sum(StationVolume/*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@cumulativeAdjustedVolume) + sum(StationVolume/*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeAdjustedVolume)) div $cubicFactor))"/>
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:cubicFormat(number((StationVolume/FillMaterial/@cumulativeAdjustedVolume + sum(StationVolume/*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@cumulativeAdjustedVolume) + sum(StationVolume/*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@cumulativeAdjustedVolume)) div $cubicFactor))"/>
                                                                </td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number(StationVolume/AddedCutMaterial/@cumulativeVolume div $cubicFactor))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number(StationVolume/AddedCutMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number(StationVolume/AddedFillMaterial/@cumulativeVolume div $cubicFactor))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:cubicFormat(number(StationVolume/AddedFillMaterial/@cumulativeAdjustedVolume div $cubicFactor))"/>
                                                        </td>
                                                    </tr>
                                                    <tr><td colspan="14"><hr/></td></tr>
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
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
        </tr>
        <xsl:if test="//MDCMaterials">
            <tr>
                <td align="right" colspan="4" lang="en">Moisture &#x26; Density Control (unclassified):&#xa0; </td>
                <td colspan="4">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number((Materials/MDCMaterials/Material/@adjustedVolume - Materials/MDCMaterials/Material/MDC/@adjustedVolume) div $cubicFactor))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4" lang="en">Moisture &#x26; Density Control:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Materials/MDCMaterials/Material/MDC/@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Materials/MDCMaterials/Material/MDC/@adjustedVolume div $cubicFactor))"/>
                </td>
            </tr>
        </xsl:if>
        <xsl:for-each select="*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Replaced/@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="5">&#xa0;</td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/RockMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
            </tr>
        </xsl:for-each>
        <tr>
            <td align="right" colspan="4">Station Total:&#xa0; </td>
            <xsl:choose>
                <xsl:when test="//MDCMaterials">
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((CutMaterial/@adjustedVolume + Materials/MDCMaterials/Material/MDC/@adjustedVolume + sum(*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume) + sum(*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                    <td colspan="3">&#xa0;</td>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((FillMaterial/@adjustedVolume + Materials/MDCMaterials/Material/@adjustedVolume + sum(*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@adjustedVolume) + sum(*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((CutMaterial/@adjustedVolume + sum(*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume) + sum(*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                    <td colspan="3">&#xa0;</td>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((FillMaterial/@adjustedVolume + sum(*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@adjustedVolume) + sum(*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td>&#xa0;</td>
            <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td>&#xa0;</td>
            <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@massOrdinate div $cubicFactor))"/>
            </td>
        </tr>
        <tr><td colspan="14">&#xa0;</td></tr>
    </xsl:template>
    <xsl:template match="DerivedStationVolume">
        <tr>
            <td colspan="14" style="border-style:dashed;border-color:#666633;border-left-width:0px;border-bottom-width:0px;border-top-width:1px;border-right-width:0px">&#xa0;</td>
        </tr>
        <tr>
            <td colspan="4">Balance Point Station:</td>
            <td align="right">
                <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="3">Cut:&#xa0; </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(CutMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(CutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right" colspan="2">Fill:&#xa0; </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(FillMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(FillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@volume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@adjustedVolume div $cubicFactor))"/>
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
        <xsl:if test="//MDCMaterials">
            <tr>
                <td align="right" colspan="4" lang="en">Moisture &#x26; Density Control (unclassified):&#xa0; </td>
                <td colspan="4">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number((Materials/MDCMaterials/Material/@adjustedVolume - Materials/MDCMaterials/Material/MDC/@adjustedVolume) div $cubicFactor))"/>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="4" lang="en">Moisture &#x26; Density Control:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Materials/MDCMaterials/Material/MDC/@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Materials/MDCMaterials/Material/MDC/@adjustedVolume div $cubicFactor))"/>
                </td>
            </tr>
        </xsl:if>
        <xsl:for-each select="*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(Replaced/@adjustedVolume div $cubicFactor))"/>
                </td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/RockMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
                <td colspan="3">&#xa0;</td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']">
            <tr>
                <td align="right" colspan="4"><xsl:value-of select="@name"/>:&#xa0; </td>
                <td align="right"><xsl:value-of select="cif:cubicFormat(number(0.0))"/></td>
                <td colspan="3">&#xa0;</td>
                <td align="right">
                    <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
                </td>
            </tr>
        </xsl:for-each>
        <tr>
            <td align="right" colspan="4">Balance Point Total:&#xa0; </td>
            <xsl:choose>
                <xsl:when test="//MDCMaterials">
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((CutMaterial/@adjustedVolume + Materials/MDCMaterials/Material/MDC/@adjustedVolume + sum(*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume) + sum(*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                    <td colspan="3">&#xa0;</td>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((FillMaterial/@adjustedVolume + Materials/MDCMaterials/Material/@adjustedVolume + sum(*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@adjustedVolume) + sum(*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((CutMaterial/@adjustedVolume + sum(*/UnclassifiedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume) + sum(*/RockMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                    <td colspan="3">&#xa0;</td>
                    <td class="overline" align="right">
                        <xsl:value-of select="cif:cubicFormat(number((FillMaterial/@adjustedVolume + sum(*/UnsuitableMaterials/Material[@includeInMassOrdinate = 'true']/Replaced/@adjustedVolume) + sum(*/DesignedMaterials/Material[@includeInMassOrdinate = 'true']/@adjustedVolume)) div $cubicFactor))"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <td>&#xa0;</td>
            <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedCutMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td>&#xa0;</td>
            <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(AddedFillMaterial/@adjustedVolume div $cubicFactor))"/>
            </td>
            <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@massOrdinate div $cubicFactor))"/>
            </td>
        </tr>
        <tr>
            <td colspan="14" style="border-style:dashed;border-color:#666633;border-left-width:0px;border-bottom-width:1px;border-top-width:0px;border-right-width:0px">&#xa0;</td>
        </tr>
        <tr><td colspan="14">&#xa0;</td></tr>
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
                Evaluation &gt; Cross Section &gt; Cross Sections</em> command by toggling on the <em>
                Create XML Report</em> option on the <em>General</em> leaf or from the <em>Evaluation &gt; 
                Cross Section &gt; Cross Section Report</em> command by toggling on the <em>Include Volumes
                </em> option on the <em>Main</em> tab.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2006 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
