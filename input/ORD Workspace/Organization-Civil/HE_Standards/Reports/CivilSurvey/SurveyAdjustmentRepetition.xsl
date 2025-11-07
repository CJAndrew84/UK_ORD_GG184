<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cif="cif" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
<xsl:param select="cif:xslShowHelp" name="xslShowHelp"/>
<xsl:param select="cif:xslRootDirectory" name="xslRootDirectory"/>
    <!-- Least Squares Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Least Squares Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <xsl:for-each select="AdjustmentNet">
                                <center>
                                    <!-- Report Title -->
                                    <h2 lang="en">Least Squares Repetition Error Report</h2>
                                    <p lang="en">
                                        Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                        Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                    </p>
                                </center>
                                <p lang="en" style="text-align:center;font-size:80%">
                                    <strong>Current Geographic System:&#xa0;</strong>
                                    &#xa0; <xsl:value-of select="//@coordinateSystemName"/>
                                    &#xa0; <xsl:value-of select="//@coordinateSystemDescription"/>
                                    <xsl:if test="//@linearUnits = 'I'">, Feet</xsl:if>
                                    <xsl:if test="//@linearUnits = 'F'">, Survey Feet</xsl:if>
                                    <xsl:if test="//@linearUnits = 'M'">, Meters</xsl:if>
                                </p>
                                <hr/>
                                <!-- Observation Data -->
                                <center>
                                    <h4>Setups</h4>
                                </center>
                                <hr size="1px"/>
                                <xsl:for-each select="GenFileReport">
                                    <xsl:for-each select="GenFileSetupList">
                                        <tr style="line-height:50%">
                                            <td>&#xa0;</td>
                                        </tr>
                                        <table class="margin" cellpadding="1" cellspacing="1" width="25%">
                                            <tbody>
                                                <tr>
                                                    <th align="left" nowrap="nowrap">Processing Setup #&#xa0;</th>
                                                    <td align="left" nowrap="nowrap">
                                                        <xsl:value-of select="@setupNumber"/>
                                                    </td>
                                                    <th align="left" nowrap="nowrap">at Station:&#xa0;</th>
                                                    <td align="left" nowrap="nowrap">
                                                        <xsl:value-of select="@stationName"/>
                                                    </td>
                                                </tr>
                                                <tr style="line-height:50%">
                                                    <td>&#xa0;</td>
                                                </tr>
                                                <xsl:for-each select="MultiPoint">
                                                    <xsl:for-each select="MultiPointList">
                                                        <table class="margin" cellpadding="1" cellspacing="1" width="40%">
                                                            <tbody>
                                                                <xsl:choose>
                                                                    <xsl:when test="@isAsterisk='True'">
                                                                        <tr style="color:FF0000">
                                                                            <th align="left" nowrap="nowrap">Repetition Error on Multiple Pointing to Station:&#xa0;</th>
                                                                            <td align="left" nowrap="nowrap">
                                                                                <xsl:value-of select="@multiPointStationName"/>
                                                                            </td>
                                                                            <th align="left" nowrap="nowrap">is:&#xa0;</th>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="@multiPointError='*******'">
                                                                                        <xsl:value-of select="@multiPointError"/>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@multiPointError))"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </td>
                                                                            <td align="left">*</td>
                                                                        </tr>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <tr>
                                                                            <th align="left" nowrap="nowrap">Repetition Error on Multiple Pointing to Station:&#xa0;</th>
                                                                            <td align="left" nowrap="nowrap">
                                                                                <xsl:value-of select="@multiPointStationName"/>
                                                                            </td>
                                                                            <th align="left" nowrap="nowrap">is:&#xa0;</th>
                                                                            <td align="right" nowrap="nowrap">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="@multiPointError='*******'">
                                                                                        <xsl:value-of select="@multiPointError"/>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@multiPointError))"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </tbody>
                                                        </table>
                                                    </xsl:for-each>
                                                </xsl:for-each>
                                            </tbody>
                                        </table>
                                        <xsl:for-each select="DistanceStandardDeviation">
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="80%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">REPETITION STANDARD ERRORS&#xa0;</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="80%">
                                                <colgroup span="9">
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                    <col width="10%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">
                                                            Sighted<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Std. Dev.
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            Horz. Dist.<br/>SD (Mean)
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Max. Spread
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Std. Dev.
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            Elev. Diff.<br/>SD (Mean)
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Max. Spread
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            Compare<br/>Horz. Dist.
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Elev. Diff.
                                                        </th>
                                                    </tr>
                                                </thead>
                                            </table>
                                            <tbody>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="80%">
                                                    <xsl:for-each select="DistanceStandardDeviationList">
                                                        <xsl:choose>
                                                            <xsl:when test="@isAsterisk='True' or @isAsteriskElv='True' or @isAsteriskHD='True' or @isAsteriskED='True'">
                                                                <tr style="color:FF0000">
                                                                    <td align="left" nowrap="nowrap">
                                                                        <xsl:value-of select="@distanceStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceStandardDeviation='*******'">
                                                                                <xsl:value-of select="@distanceStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@distanceStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceMaximumSpread='*******'">
                                                                                <xsl:value-of select="@distanceMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationStandardDeviation='*******'">
                                                                                <xsl:value-of select="@elevationStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@elevationStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationMaximumSpread='*******'">
                                                                                <xsl:value-of select="@elevationMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@compareHorizontalDistance='*******'">
                                                                                <xsl:value-of select="@compareHorizontalDistance"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@compareHorizontalDistance))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@compareElevationDifference='*******'">
                                                                                <xsl:value-of select="@compareElevationDifference"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@compareElevationDifference))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="left">*</td>
                                                                </tr>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <tr>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <xsl:value-of select="@distanceStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceStandardDeviation='*******'">
                                                                                <xsl:value-of select="@distanceStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@distanceStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@distanceMaximumSpread='*******'">
                                                                                <xsl:value-of select="@distanceMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@distanceMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationStandardDeviation='*******'">
                                                                                <xsl:value-of select="@elevationStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@elevationStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@elevationMaximumSpread='*******'">
                                                                                <xsl:value-of select="@elevationMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@elevationMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@compareHorizontalDistance='*******'">
                                                                                <xsl:value-of select="@compareHorizontalDistance"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@compareHorizontalDistance))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@compareElevationDifference='*******'">
                                                                                <xsl:value-of select="@compareElevationDifference"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@compareElevationDifference))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                </tr>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </table>
                                            </tbody>
                                        </xsl:for-each>
                                        <xsl:for-each select="AngleStandardDeviation">
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">REPETITION STANDARD ERRORS FOR ANGLES&#xa0;</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                <colgroup span="5">
                                                    <col width="15%"/>
                                                    <col width="15%"/>
                                                    <col width="15%"/>
                                                    <col width="15%"/>
                                                    <col width="15%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">
                                                            Backsight<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="left">
                                                            ForeSight<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Std. Dev.</th>
                                                        <th class="underline" lang="en" align="right">
                                                            Std. Dev.<br/>(Mean)
                                                        </th>
                                                        <th class="underline" lang="en" align="right">
                                                            <br/>Max. Spread
                                                        </th>
                                                    </tr>
                                                </thead>
                                            </table>
                                            <tbody>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <xsl:for-each select="AngleStandardDeviationList">
                                                        <xsl:choose>
                                                            <xsl:when test="@isAsterisk='True'">
                                                                <tr style="color:FF0000">
                                                                    <td align="left" nowrap="nowrap">
                                                                        <xsl:value-of select="@backSightStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="@foreSightStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleStandardDeviation='*******'">
                                                                                <xsl:value-of select="@angleStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@angleStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleMaximumSpread='*******'">
                                                                                <xsl:value-of select="@angleMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="left">*</td>
                                                                </tr>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <tr>
                                                                    <td align="left" nowrap="nowrap">
                                                                        <xsl:value-of select="@backSightStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="@foreSightStationName"/>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleStandardDeviation='*******'">
                                                                                <xsl:value-of select="@angleStandardDeviation"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleStandardDeviation))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleStandardDeviationMean='*******'">
                                                                                <xsl:value-of select="@angleStandardDeviationMean"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleStandardDeviationMean))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td align="right" nowrap="nowrap">
                                                                        <xsl:choose>
                                                                            <xsl:when test="@angleMaximumSpread='*******'">
                                                                                <xsl:value-of select="@angleMaximumSpread"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:value-of select="cif:distanceFormat(number(@angleMaximumSpread))"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                </tr>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </table>
                                            </tbody>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:for-each>
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
             You must have at least one field book in Project Explorer (Survey) which contains a survey network with processed adjustment to get results from this report.
	</p>

<p class="normal1">  In Project Explorer, ensure the green icon is to the right of Adjustments (indicating completed processing). Right-click on Adjustment, select Adjustment Results and the desired report. </p>
            <p class="normal1">Once the Civil Report Browser is open, you can select any other Adjustment report.</p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
    </xsl:stylesheet>
