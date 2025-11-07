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
                                    <h2 lang="en">Least Squares Summary Report</h2>
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
