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
                                    <h2 lang="en">Least Squares Complete Report</h2>
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
                               <xsl:for-each select="LeastSquaresDefaults">
                                    <center>
                                        <h4>Least Squares Defaults</h4>
                                    </center>
                                    <hr size="1px"/>
                                    <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                        <tbody>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Combined Scale Factor Option:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="//@combinedScaleFactorOption"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Combined Scale Factor Value:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@combinedScaleFactorValue))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Display Errors in Message Center:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="//@displayErrorInMessageCenter"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Distance constant:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addDistConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Distance PPM:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addDistPpm))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Horizontal angle:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addHorzAngle))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Azimuth:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addAzimuth))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Trig level constant:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addTrigLevConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Trig level PPM:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addTrigLevPpm))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Add-on for Differential leveling constant:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@addDiffLevConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Distance constant error estimate:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errDistConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Distance PPM:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errDistPpm))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Horizontal angle error estimate:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errHorzAngle))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Azimuth error estimate:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errAzimuth))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Trig Level Constant error estimate:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errTrigLevConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Default Differential Leveling Constant error estimate:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@errDiffLevConst))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Distance tolerance:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@tolDistance))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Angle tolerance:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@tolAngle))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Elevation tolerance:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@tolElevation))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Setup Error:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@setupError))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">XYZ Decimal Places:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@xyzDecPlaces"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Use repetition errors PLUS add-ons for error estimation:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@error"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Compute Coordinate standard error and error ellipses:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@computeCoord"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Compute earth curvature and atmospheric refraction:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@earthCurvature"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Balance Angles:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@angleBalance"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#xa0;</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </xsl:for-each>
                                <xsl:for-each select="ReportHeader">
                                    <hr size="1px"/>
                                    <center>
                                        <h4>Summary</h4>
                                    </center>
                                    <hr size="1px"/>
                                    <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                        <tbody>
                                            <tr>
                                                <th align="left">
                                                    <xsl:choose>
                                                        <xsl:when test="//@adjustmentConverges='true'">Least Squares converged.</xsl:when>
                                                        <xsl:otherwise>Least Squares did not converge.</xsl:otherwise>
                                                    </xsl:choose>
                                                </th>
                                            </tr>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Number of BenchMarks:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="//@numberOfBenchMarks"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Number of Stations:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="//@numberOfStations"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Number of Measurements:&#xa0;</th>
                                                <td align="left" nowrap="nowrap">
                                                    <xsl:value-of select="//@numberOfMeasurements"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Number of Required Terms for Normal Equations:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@numberOfRequiredTermsForNormalEquations"/>
                                                </td>
                                            </tr>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Horizontal Degrees of Freedom:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@horizDegreesOfFreedom"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Lower Horizontal Chi-Square 5% significance level:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@horizChiLower))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Horizontal Standard Error of Unit Weight:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@horizStandardErrorOfUnitWeight))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Upper Horizontal Chi-Square 5% significance level:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@horizChiUpper))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Horizontal 95% Confidence F Statistic Error Multiplier:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@horizConfidenceStatisticMultiplier))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                    <xsl:choose>
                                                        <xsl:when test="//@horizChiPassed='upper'">
                                                		<th align="left" colspan="2" nowrap="nowrap" style="color:FF0000">
	                                                            Warning! Horizontal Chi-Square Test exceeded upper bounds
								 </th>
                                                        </xsl:when>
                                                        <xsl:when test="//@horizChiPassed='lower'">
                                                		<th align="left" colspan="2" nowrap="nowrap" style="color:FF0000">
	                                                            Warning! Horizontal Chi-Square Test exceeded lower bounds
								 </th>

                                                        </xsl:when>
                                                        <xsl:when test="//@horizChiPassed='passed'">
								<th align="left" colspan="2" nowrap="nowrap">
	                                                            Horizontal Chi-Square Test succeeded
								</th>
                                                        </xsl:when>
                                                    </xsl:choose>

                                            </tr>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Vertical Degrees of Freedom:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="//@levelDegreesOfFreedom"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Lower Vertical Chi-Square 5% significance level:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@levelChiLower))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Vertical Standard Error of Unit Weight:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@levelStandardErrorOfUnitWeight))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Upper Vertical Chi-Square 5% significance level:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@levelChiUpper))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" nowrap="nowrap">Vertical 95% Confidence F Statistic Error Multiplier:&#xa0;</th>
                                                <td align="left">
                                                    <xsl:value-of select="cif:distanceFormat(number(//@levelConfidenceStatisticMultiplier))"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                    <xsl:choose>
                                                        <xsl:when test="//@levelChiPassed='upper'">
                                                		<th align="left" colspan="2" nowrap="nowrap" style="color:FF0000">
	                                                            Warning! Vertical Chi-Square Test exceeded upper bounds
								 </th>
                                                        </xsl:when>
                                                        <xsl:when test="//@levelChiPassed='lower'">
                                                		<th align="left" colspan="2" nowrap="nowrap" style="color:FF0000">
	                                                            Warning! Vertical Chi-Square Test exceeded lower bounds
								 </th>

                                                        </xsl:when>
                                                        <xsl:when test="//@levelChiPassed='passed'">
								<th align="left" colspan="2" nowrap="nowrap">
	                                                            Vertical Chi-Square Test succeeded
								</th>
                                                        </xsl:when>
                                                    </xsl:choose>
                                            </tr>
                                            <tr>
                                                <td>&#xa0;</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </xsl:for-each>
                                <!-- Observation Data -->
                                <hr size="1px"/>
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
                                    <tr style="line-height:50%">
                                        <td>&#xa0;</td>
                                    </tr>
                                    <hr size="1px"/>
                                    <center>
                                        <h4>Preliminary Traverse Closure based on Compass Rule</h4>
                                    </center>
                                    <hr size="1px"/>
                                    <xsl:for-each select="GenFileTraverseList">
                                        <xsl:for-each select="Traverse">
                                            <table class="margin" cellpadding="1" cellspacing="1" width="35%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">PRELIMINARY TRAVERSE CLOSURE REPORT&#xa0;</th>
                                                    </tr>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">PRELIMINARY LINEAR ERROR OF CLOSURE IS &#xa0;</th>
                                                        <td align="left" nowrap="nowrap">
                                                            <xsl:value-of select="cif:distanceFormat(number(@linearClosureError))"/>
                                                        </td>
                                                        <th align="left" nowrap="nowrap">PRECISION IS 1/ &#xa0;</th>
                                                        <td align="left" nowrap="nowrap">
                                                            <xsl:value-of select="cif:distanceFormat(number(@precision))"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <colgroup span="3">
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">Station</th>
                                                        <th class="underline" lang="en" align="right">Northing</th>
                                                        <th class="underline" lang="en" align="right">Easting</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <xsl:for-each select="TraverseList">
                                                        <tr>
                                                            <td align="left">
                                                                <xsl:value-of select="@stationName"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                        <tr style="line-height:50%">
                                            <td>&#xa0;</td>
                                        </tr>
                                        <xsl:for-each select="AdjustedHorizontal">
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">PRELIMINARY GENERATED COORDINATES&#xa0;</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <colgroup span="3">
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">Station</th>
                                                        <th class="underline" lang="en" align="right">Northing</th>
                                                        <th class="underline" lang="en" align="right">Easting</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <xsl:for-each select="AdjustedHorizontalList">
                                                        <tr>
                                                            <td align="left">
                                                                <xsl:value-of select="@stationName"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                        <tr style="line-height:50%">
                                            <td>&#xa0;</td>
                                        </tr>
                                        <xsl:for-each select="DistanceResidual">
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">PRELIMINARY DISTANCE RESIDUALS&#xa0;</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <colgroup span="3">
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">
                                                            From<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="left">
                                                            To<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="right">Residual</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <xsl:for-each select="DistanceResidualList">
                                                        <tr>
                                                            <td align="left">
                                                                <xsl:value-of select="@fromStation"/>
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="@toStation"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:choose>
                                                                    <xsl:when test="@residual='*******'">
                                                                        <xsl:value-of select="@residual"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                        <tr style="line-height:50%">
                                            <td>&#xa0;</td>
                                        </tr>
                                        <xsl:for-each select="AngleResidual">
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <tbody>
                                                    <tr>
                                                        <th align="left" nowrap="nowrap">PRELIMINARY ANGLE RESIDUALS&#xa0;</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                <colgroup span="4">
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                    <col width="5%"/>
                                                </colgroup>
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" lang="en" align="left">
                                                            Backsight<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="left">
                                                            Setup<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="left">
                                                            Forsight<br/>Station
                                                        </th>
                                                        <th class="underline" lang="en" align="right">Residual</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <xsl:for-each select="AngleResidualList">
                                                        <tr>
                                                            <td align="left">
                                                                <xsl:value-of select="@backSightStation"/>
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="@setupStation"/>
                                                            </td>
                                                            <td align="left">
                                                                <xsl:value-of select="@foreSightStation"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:choose>
                                                                    <xsl:when test="@residual='*******'">
                                                                        <xsl:value-of select="@residual"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </tbody>
                                            </table>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:for-each>
                                <tr style="line-height:50%">
                                    <td>&#xa0;</td>
                                </tr>
                                <hr size="1px"/>
                                <center>
                                    <h4>Vertical Least Squares</h4>
                                </center>
                                <hr size="1px"/>
                                <xsl:for-each select="OneDFileReport">
                                    <xsl:for-each select="OneDFileReportList">
                                        <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <xsl:for-each select="ElevationDifference">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">MISCLOSURE OF MULTIPLE ELEVATION DIFFERENCE MEASUREMENTS&#xa0;</th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <colgroup span="3">
                                                        <col width="20%"/>
                                                        <col width="20%"/>
                                                        <col width="20%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">
                                                                From<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                To<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="right">MisClosure</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="ElevationDifferenceList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@misClosure='*******'">
                                                                                    <xsl:value-of select="@misClosure"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@misClosure))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@misClosure='*******'">
                                                                                    <xsl:value-of select="@misClosure"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@misClosure))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            
                                            <xsl:for-each select="BenchMarkElevationResiduals">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">BENCHMARK ELEVATION RESIDUALS&#xa0;</th>
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
                                                        <col width="15%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">Station</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Input<br/>Elevation
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Adjusted<br/>Elevation
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Residual</th>
                                                            <th class="underline" lang="en" align="right">Standardized Residual</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Error<br/>Estimate
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="BenchMarkElevationResidualsList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@stationName"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@inputElevation='*******'">
                                                                                    <xsl:value-of select="@inputElevation"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:ordinateFormat(number(@inputElevation))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@adjustedElevation='*******'">
                                                                                    <xsl:value-of select="@adjustedElevation"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:ordinateFormat(number(@adjustedElevation))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@errorEstimate='*******'">
                                                                                    <xsl:value-of select="@errorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@errorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@stationName"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@inputElevation='*******'">
                                                                                    <xsl:value-of select="@inputElevation"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:ordinateFormat(number(@inputElevation))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@adjustedElevation='*******'">
                                                                                    <xsl:value-of select="@adjustedElevation"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:ordinateFormat(number(@adjustedElevation))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@errorEstimate='*******'">
                                                                                    <xsl:value-of select="@errorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@errorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            
                                            <xsl:for-each select="BenchMarkStats">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">BENCHMARK RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap"><xsl:value-of select="cif:distanceFormat(number(@rmsError))"/></td>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">MAX. BENCHMARK RESIDUAL AT STATION &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@stationName"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap"> OF &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            
                                            <xsl:for-each select="LevelDifferenceResiduals">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">VERTICAL DIFFERENCE RESIDUALS&#xa0;</th>
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
                                                        <col width="15%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">
                                                                From<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                To<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Measured</th>
                                                            <th class="underline" lang="en" align="right">Residual</th>
                                                            <th class="underline" lang="en" align="right">Standardized Residual</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Error<br/>Estimate
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="LevelDifferenceResidualsList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@measured='*******'">
                                                                                    <xsl:value-of select="@measured"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@measured))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>                                                                        
									<td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@errorEstimate='*******'">
                                                                                    <xsl:value-of select="@errorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@errorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@measured='*******'">
                                                                                    <xsl:value-of select="@measured"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@measured))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>                                                                        
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@errorEstimate='*******'">
                                                                                    <xsl:value-of select="@errorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@errorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>                                                        
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>

                                            <xsl:for-each select="LevelDifferenceStats">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">ELEV. DIFF. RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsError))"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">MAX. ELEV. DIFF. RESIDUAL AT STATION &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@fromStation"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap"> - &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@toStation"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap"> OF &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            
                                            <xsl:for-each select="AdjustedElevations">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="40%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">AJUSTED ELEVATIONS&#xa0;</th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="40%">
                                                    <colgroup span="3">
                                                        <col width="10%"/>
                                                        <col width="10%"/>
                                                        <col width="10%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">Station</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Adjusted<br/>Elevation
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Standard<br/>Error
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="AdjustedElevationsList">
                                                            <tr>
                                                                <td align="left">
                                                                    <xsl:value-of select="@stationName"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@adjustedElevation))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@standardError))"/>
                                                                </td>
                                                            </tr>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                        </table>
                                    </xsl:for-each>
                                </xsl:for-each>
                                <tr style="line-height:50%">
                                    <td>&#xa0;</td>
                                </tr>
                                <hr size="1px"/>
                                <center>
                                    <h4>Horizontal Least Squares</h4>
                                </center>
                                <hr size="1px"/>
                               <xsl:for-each select="TwoDFileReport">
                                    <xsl:for-each select="TwoDFileReportList">
                                        <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <xsl:for-each select="AdjustedHorizontal">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">ADJUSTED HORIZONTAL&#xa0;</th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="80%">
                                                    <colgroup span="8">
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">Station</th>
                                                            <th class="underline" lang="en" align="right">Northing</th>
                                                            <th class="underline" lang="en" align="right">Easting</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Standard Error<br/>Northing
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Standard Error<br/>Easting
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Error Ellipse<br/>Major Axis
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Error Ellipse<br/>Minor Axis
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Info T.</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="AdjustedHorizontalList">
                                                            <tr>
                                                                <td align="left">
                                                                    <xsl:value-of select="@stationName"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@yStandardError))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@xStandardError))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@suErrorEllipse))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@svErrorEllipse))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:angularFormat(number(@infoT))"/>
                                                                </td>
                                                            </tr>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <xsl:for-each select="HorizontalControlResidual">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">HORIZONTAL CONTROL POINT RESIDUALS&#xa0;</th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                                    <colgroup span="5">
                                                        <col width="15%"/>
                                                        <col width="15%"/>
                                                        <col width="10%"/>
                                                        <col width="15%"/>
                                                        <col width="15%"/>
                                                        <col width="10%"/>
                                                        <col width="15%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">Station</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Northing<br/>Residual
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Northing<br/>Standardized Residual
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Northing<br/>Estimated Error
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Easting<br/>Residual
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Easting<br/>Standardized Residual
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Easting<br/>Estimated Error
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="HorizontalControlResidualList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@stationName"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@xResidual='*******'">
                                                                                    <xsl:value-of select="@yResidual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@yResidual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopErrorY='*******'">
                                                                                    <xsl:value-of select="@snoopErrorY"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopErrorY))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@yErrorEstimate='*******'">
                                                                                    <xsl:value-of select="@yErrorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@yErrorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@xResidual='*******'">
                                                                                    <xsl:value-of select="@yResidual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@xResidual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopErrorX='*******'">
                                                                                    <xsl:value-of select="@snoopErrorX"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopErrorX))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@xErrorEstimate='*******'">
                                                                                    <xsl:value-of select="@xErrorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@xErrorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@stationName"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@yResidual='*******'">
                                                                                    <xsl:value-of select="@yResidual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@yResidual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopErrorT='*******'">
                                                                                    <xsl:value-of select="@snoopErrorY"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopErrorY))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@yErrorEstimate='*******'">
                                                                                    <xsl:value-of select="@yErrorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@yErrorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@xResidual='*******'">
                                                                                    <xsl:value-of select="@xResidual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@xResidual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopErrorX='*******'">
                                                                                    <xsl:value-of select="@snoopErrorX"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopErrorX))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@xErrorEstimate='*******'">
                                                                                    <xsl:value-of select="@xErrorEstimate"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@xErrorEstimate))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>

                                            <xsl:for-each select="HorizontalControlStats">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">EASTING CONTROL RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsErrorX))"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopErrorX))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">MAX. EASTING RESIDUAL AT STATION &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@stationX"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap"> OF &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@residualX))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">NORTHING CONTROL RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsErrorY))"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS ERROR = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopErrorY))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">MAX. NORTHING RESIDUAL AT STATION &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@stationY"/>
                                                            </td>
                                                            <th align="left" nowrap="nowrap"> OF &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@residualY))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            
                                            <xsl:for-each select="HorizontalDistanceResidual">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="60%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">HORIZONTAL DISTANCE RESIDUALS&#xa0;</th>
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
							                            <col width="15%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">
                                                                Occupied<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                Sighted<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Distance</th>
                                                            <th class="underline" lang="en" align="right">Residual</th>
							                                <th class="underline" lang="en" align="right">Standardized Residual</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Estimated<br/>Error
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="HorizontalDistanceResidualList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@distance='*******'">
                                                                                    <xsl:value-of select="@distance"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@estimatedError='*******'">
                                                                                    <xsl:value-of select="@estimatedError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@estimatedError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@fromStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@toStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@distance='*******'">
                                                                                    <xsl:value-of select="@distance"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@estimatedError='*******'">
                                                                                    <xsl:value-of select="@estimatedError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@estimatedError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <xsl:for-each select="DistanceTotals">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Distance RMS Error = &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS Error = &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Maximum Distance Residual &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="@fromStation"/>
                                                            </td>
                                                            <th align="center" nowrap="nowrap"> - &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="@toStation"/>
                                                            </td>
                                                            <th align="center" nowrap="nowrap"> of &#xa0;</th>
                                                            <td>
                                                                <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <xsl:for-each select="HorizontalAngleResidual">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">HORIZONTAL ANGLE RESIDUALS&#xa0;</th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                                    <colgroup span="6">
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
                                                                Backsight<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                Occupied<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                Foresight<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Angle</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Residual<br/>(Seconds)
                                                            </th>
                                                            <th class="underline" lang="en" align="right">Standardized Residual</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Estimated Error<br/>(Seconds)
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="HorizontalAngleResidualList">
                                                            <xsl:choose>
                                                                <xsl:when test="@isAsterisk='True'">
                                                                    <tr style="color:FF0000">
                                                                        <td align="left">
                                                                            <xsl:value-of select="@backSightStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@occupiedStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@foreSightStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@angle='*******'">
                                                                                    <xsl:value-of select="@angle"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:angularFormat(number(@angle))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@estimatedError='*******'">
                                                                                    <xsl:value-of select="@estimatedError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@estimatedError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="left">*</td>
                                                                    </tr>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@backSightStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@occupiedStation"/>
                                                                        </td>
                                                                        <td align="left">
                                                                            <xsl:value-of select="@foreSightStation"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@angle='*******'">
                                                                                    <xsl:value-of select="@angle"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:angularFormat(number(@angle))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@residual='*******'">
                                                                                    <xsl:value-of select="@residual"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@snoopError='*******'">
                                                                                    <xsl:value-of select="@snoopError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:choose>
                                                                                <xsl:when test="@estimatedError='*******'">
                                                                                    <xsl:value-of select="@estimatedError"/>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(@estimatedError))"/>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <xsl:for-each select="AngleTotals">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Angle RMS Error = &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Standardized Residual RMS Error = &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@snoopError))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Maximum Angle Residual &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="@backSightStation"/>
                                                            </td>
                                                            <th align="center" nowrap="nowrap"> - &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="@occupiedStation"/>
                                                            </td>
                                                            <th align="center" nowrap="nowrap"> - &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="@foreSightStation"/>
                                                            </td>
                                                            <th align="center" nowrap="nowrap"> of &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@residual))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>

                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <xsl:for-each select="DoubleStub">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="20%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">DOUBLE STUB FOR STATION:&#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@station"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <colgroup span="6">
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">
                                                                Backsight<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                Occupied<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="left">
                                                                Foresight<br/>Station
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Northing<br/>Error
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Easting<br/>Error
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Linear<br/>Error
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="DoubleStubList">
                                                            <tr>
                                                                <td align="left">
                                                                    <xsl:value-of select="@backSightStation"/>
                                                                </td>
                                                                <td align="left">
                                                                    <xsl:value-of select="@occupiedStation"/>
                                                                </td>
                                                                <td align="left">
                                                                    <xsl:value-of select="@foreSightStation"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:choose>
                                                                        <xsl:when test="//@northingError='*******'">
                                                                            <xsl:value-of select="@northingError"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="cif:distanceFormat(number(@northingError))"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:choose>
                                                                        <xsl:when test="//@eastingError='*******'">
                                                                            <xsl:value-of select="@eastingError"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="cif:distanceFormat(number(@eastingError))"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:choose>
                                                                        <xsl:when test="//@linearError='*******'">
                                                                            <xsl:value-of select="@linearError"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="cif:distanceFormat(number(@linearError))"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </td>
                                                            </tr>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>


                                            <tr style="line-height:50%">
                                                <td>&#xa0;</td>
                                            </tr>
                                            <xsl:for-each select="Traverse">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">TRAVERSE CLOSURE REPORT&#xa0;</th>
                                                        </tr>
                                                        <tr style="line-height:50%">
                                                            <td>&#xa0;</td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Sum of distance along traverse is:&#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Closure in Northing = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@closureInY))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Closure in Easting = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@closureInX))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Angular Closure = &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="@angularClosure"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Linear error of Closure (after rotation) is &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@linearClosure))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">After Rotation Precision is 1 / &#xa0;</th>
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@precision))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <colgroup span="5">
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                        <col width="5%"/>
                                                    </colgroup>
                                                    <thead style="display:table-header-group">
                                                        <tr>
                                                            <th class="underline" lang="en" align="left">Station</th>
                                                            <th class="underline" lang="en" align="right">Bearing</th>
                                                            <th class="underline" lang="en" align="right">Distance</th>
                                                            <th class="underline" lang="en" align="right">Northing</th>
                                                            <th class="underline" lang="en" align="right">Easting</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <xsl:for-each select="TraverseList">
                                                            <tr>
                                                                <td align="left">
                                                                    <xsl:value-of select="@stationName"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:directionFormat(number(@bearing))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                                </td>
                                                            </tr>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                            <xsl:for-each select="TraverseTotals">
                                                <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                                                    <tbody>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Total Length of Evaluated Traverse Distance = &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                                                            </td>
                                                            <th>
                                                                <xsl:if test="//@linearUnits = 'I'">Miles</xsl:if>
                                                                <xsl:if test="//@linearUnits = 'F'">Miles</xsl:if>
                                                                <xsl:if test="//@linearUnits = 'M'">Kilometers</xsl:if>
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Precision Based on Latitude and Departure Closures = 1 / &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@closure))"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th align="left" nowrap="nowrap">Precision After Orientation Correction = 1 / &#xa0;</th>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@precision))"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </xsl:for-each>
                                        </table>
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
