<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Superelevation Data Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Superelevation Calculation Report</title>
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
                                <h2 lang="en">Superelevation Calculation Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
                            <xsl:for-each select="RoadwayDesigner">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@fileName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- Section Data -->
                                <xsl:for-each select="SuperelevationSections/SuperelevationSection">
									<hr/>
                                    <table class="margin" cellpadding="3" width="90%">
                                        <tbody>
                                            <tr>
                                                <th align="left" lang="en" width = "15%">Section Name:&#xa0; </th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th align="left" lang="en">Base Horizontal Name:&#xa0; </th>
                                                <td align="left" colspan="2">
                                                    <xsl:value-of select="@baseHorizontal"/>
                                                </td>
                                            </tr>
                                            <xsl:if test="Standards">
                                                <tr>
                                                    <th align="left" lang="en">Standards Filename:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@filename"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Design Speed:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@designSpeed"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Pivot Method:&#xa0; </th>
                                                    <td align="left" colspan="2">
                                                        <xsl:value-of select="Standards/@pivotMethod"/>
                                                    </td>
                                                </tr>
                                                <xsl:if test="Standards/@normalCrossSlope">
                                                    <tr>
                                                        <th align="left" lang="en">Normal Cross Slope:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="cif:gradeFormat(number(Standards/@normalCrossSlope))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="Standards/@eSelection">
                                                    <tr>
                                                        <th align="left" lang="en">E Selection:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="Standards/@eSelection"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="Standards/@lSelection">
                                                    <tr>
                                                        <th align="left" lang="en">L Selection:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="Standards/@lSelection"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="SuperelevationCalculation/@calculationUnits">
                                                    <tr>
                                                        <th align="left" lang="en">Calculation Units:&#xa0; </th>
                                                        <td align="left" colspan="2">
                                                            <xsl:value-of select="SuperelevationCalculation/@calculationUnits"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                    <!-- Lane Set Data -->
									<hr/>
                                    <table class="margin" cellpadding="3" width="100%">
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
                                         <col style="width:10%"/>
										<tbody>
                                        <xsl:for-each select="SuperelevationCalculation/LaneSets/LaneSet">
											<tr>
												<th align="left" lang="en">Lane Set:&#xa0; </th>
												<td align="left">
													<xsl:value-of select="@id"/>
												</td>
											</tr>
											<tr>
												<th align="left" lang="en">Left Offset:&#xa0; </th>
												<td align="left">
													<xsl:value-of select="@leftOffset"/>
												</td>
											</tr>
											<tr>
												<th align="left" lang="en">Right Offset:&#xa0; </th>
												<td align="left">
													<xsl:value-of select="@rightOffset"/>
												</td>
											</tr>
											 <!-- Curve Set Data -->
											<xsl:for-each select="CurveSets/CurveSet">
												<tr>
													<th align="left" lang="en" class="underline">Curve Set: <xsl:value-of select="@id"/></th>
													<th align="left" lang="en" class="underline">Outside Lane: <xsl:value-of select="@outsideLane"/></th>
													<th align="left" lang="en" class="underline">Start Chainage: <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/></th>
													<th align="left" lang="en" class="underline">End Chainage: <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/></th>
												</tr>
												 <!-- Global Variables -->
												<tr>
													<td/>
													<th align="left" lang="en">Global Variables:</th>
												</tr>
												<xsl:for-each select="GlobalVariables/Variable">
													<tr >
														<td/>
														<td align="left">
															<xsl:value-of select="@name"/>
														</td>
														<td align="left" >
															<xsl:value-of select="@value"/>
														</td>
													</tr>
												</xsl:for-each>
												 <!-- Max E calcs data -->
												<tr>
												<td/>
													<th align="left" lang="en" colspan="9" class="underline">Maximum cross slope calculation</th>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en" width="10%">Max E Value:&#xa0; </th>
													<td align="left">
														<xsl:value-of select="cif:gradeFormat(number(MaxECalculations/@value))"/>
													</td>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Result from:&#xa0; </th>
													<td align="left" colspan="8">
														<xsl:value-of select="MaxECalculations/@resultFrom"/>
													</td>
												</tr>
												<tr>
													<td/>
													<xsl:if test="MaxECalculations/@equation" >
														<th align="right" lang="en">Equation:&#xa0; </th>
														<td align="left" colspan="8">
															<xsl:value-of select="MaxECalculations/@equation"/>
														</td>
													</xsl:if>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Variables:&#xa0; </th>
													<th align="left" lang="en">Name</th>
													<th align="left" lang="en">Value</th>
													<th align="left" lang="en">Equation</th>
												</tr>
												<xsl:for-each select="MaxECalculations/Variables/Variable">
													<tr >
														<td/>
														<td/>
														<td align="left">
															<xsl:value-of select="@name"/>
														</td>
														<td align="left">
															<xsl:value-of select="@value"/>
														</td>
														<td align="left" colspan="6" >
															<xsl:value-of select="@equation"/>
														</td>
													</tr>
												</xsl:for-each>
												 <!-- Transition calcs data -->
												<tr>
													<td/>
													<th align="left" lang="en" colspan="9" class="underline">Transition length calculation</th>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Transition Length:&#xa0; </th>
													<td align="left" colspan="8">
														<xsl:value-of select="cif:distanceFormat(number(TransitionLengthCalculations/@value))"/>
													</td>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Result from:&#xa0; </th>
													<td align="left" colspan="8">
														<xsl:value-of select="TransitionLengthCalculations/@resultFrom"/>
													</td>
												</tr>
												<tr>
													<xsl:if test="TransitionLengthCalculations/@equation" >
														<td/>
														<th align="right" lang="en">Equation:&#xa0; </th>
														<td align="left" colspan="8">
															<xsl:value-of select="TransitionLengthCalculations/@equation"/>
														</td>
													</xsl:if>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Variables:&#xa0; </th>
													<th align="left" lang="en">Name</th>
													<th align="left" lang="en">Value</th>
													<th align="left" lang="en" colspan="6">Equation</th>
												</tr>
												<xsl:for-each select="TransitionLengthCalculations/Variables/Variable">
													<tr >
													<td/>
														<td/>
														<td align="left">
															<xsl:value-of select="@name"/>
														</td>
														<td align="left">
															<xsl:value-of select="@value"/>
														</td>
														<td align="left" colspan="6" >
															<xsl:value-of select="@equation"/>
														</td>
													</tr>
												</xsl:for-each>
												 <!-- Start of Curve Calcs -->
												<tr>
													<td/>
													<th align="left" lang="en" colspan="9" class="underline">Start of curve results</th>
												</tr>
												<tr>
													<td/>
													<th align="right" lang="en">Spiral Exists:&#xa0; </th>
													<td align="left" colspan="8">
														<xsl:value-of select="StartOfCurveCalculations/@spiralExists"/>
													</td>
												</tr>
												<xsl:if test="StartOfCurveCalculations/@spiralExists='true'">
													<tr>
														<td/>
														<th align="right" lang="en">Spiral Length:&#xa0; </th>
														<td align="left" colspan="8">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/@spiralLength))"/>
														</td>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Spiral Start Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/StartOfSpiralStation/@externalStation), string(StartOfCurveCalculations/StartOfSpiralStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/StartOfSpiralStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<tr>
													<th align="right" lang="en" colspan="2">Arc Start Chainage:&#xa0; </th>
													<td align="left">
														<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/StartOfArcStation/@externalStation), string(StartOfCurveCalculations/StartOfArcStation/@externalStationName))"/>
													</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/StartOfArcStation/@internalStation))"/>
														</td>
												</tr>
												<xsl:if test="StartOfCurveCalculations/RunoutStation">
													<tr>
														<th align="right" lang="en" colspan="2">Runout (Normal Crown) Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/RunoutStation/@externalStation), string(StartOfCurveCalculations/RunoutStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/RunoutStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="StartOfCurveCalculations/RunoffStation">
													<tr>
														<th align="right" lang="en" colspan="2">Runoff (Zero Cross Slope) Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/RunoffStation/@externalStation), string(StartOfCurveCalculations/RunoffStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/RunoffStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="StartOfCurveCalculations/ReverseCrownStation">
													<tr>
														<th align="right" lang="en" colspan="2">Reverse Crown Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/ReverseCrownStation/@externalStation), string(StartOfCurveCalculations/ReverseCrownStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/ReverseCrownStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="StartOfCurveCalculations/FullSuperStation">
													<tr>
														<th align="right" lang="en" colspan="2">Full Super Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StartOfCurveCalculations/FullSuperStation/@externalStation), string(StartOfCurveCalculations/FullSuperStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StartOfCurveCalculations/FullSuperStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<!-- Start of curve Standard Chainage customization -->
												<xsl:if test="StandardStationCustomization">
													<tr>
														<td/>
														<th align="left" lang="en" colspan="9" class="underline">Start of curve standard chainage customization</th>
													</tr>
													<tr>
														<td/>
														<th align="right" lang="en">Criteria Value:&#xa0; </th>
														<td align="left">
															<xsl:choose>
																<xsl:when test="StandardStationCustomization/StartOfCurve/@criteriaEquation">
																	<xsl:value-of select="StandardStationCustomization/StartOfCurve/@criteriaValue"/>
																</xsl:when>
																<xsl:otherwise>
																True
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<xsl:if test="StandardStationCustomization/StartOfCurve/@criteriaEquation">
															<th align="right" lang="en">Criteria Equation:&#xa0; </th>
															<td align="left" colspan="5">
																<xsl:value-of select="StandardStationCustomization/StartOfCurve/@criteriaEquation"/>
															</td>
														</xsl:if>
													</tr>
													<xsl:if test="StandardStationCustomization/StartOfCurve/RunoutStation">
													<tr>
														<th align="right" colspan="2">Modified Runout Chainage:</th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/StartOfCurve/RunoutStation/@externalStation), string(StandardStationCustomization/StartOfCurve/RunoutStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/StartOfCurve/RunoutStation/@internalStation))"/>
														</td>
														<th align="right" lang="en">Equation:&#xa0;</th>
														<td align="left" colspan="4">
															<xsl:value-of select="StandardStationCustomization/StartOfCurve/RunoutStation/@equation"/>
														</td>
													</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/StartOfCurve/RunoffStation">
														<tr>
															<th align="right" colspan="2">Modified Runoff Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/StartOfCurve/RunoffStation/@externalStation), string(StandardStationCustomization/StartOfCurve/RunoffStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/StartOfCurve/RunoffStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/StartOfCurve/RunoffStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/StartOfCurve/ReverseCrownStation">
														<tr>
															<th align="right" colspan="2">Modified Reverse Crown Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/StartOfCurve/ReverseCrownStation/@externalStation), string(StandardStationCustomization/StartOfCurve/ReverseCrownStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/StartOfCurve/ReverseCrownStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/StartOfCurve/ReverseCrownStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/StartOfCurve/FullSuperStation">
														<tr>
															<th align="right" colspan="2">Modified Full Super Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/StartOfCurve/FullSuperStation/@externalStation), string(StandardStationCustomization/StartOfCurve/FullSuperStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/StartOfCurve/FullSuperStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/StartOfCurve/FullSuperStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<tr>
														<th align="right" lang="en" colspan="2">Variables:&#xa0; </th>
														<th align="left" lang="en">Name</th>
														<th align="left" lang="en">Value</th>
														<th align="left" lang="en" colspan="6">Equation</th>
													</tr>
													<tr/>
													<xsl:for-each select="StandardStationCustomization/StartOfCurve/Variable">
														<tr >
															<td/>
															<td/>
															<td align="left">
																<xsl:value-of select="@name"/>
															</td>
															<td align="left">
																<xsl:value-of select="@value"/>
															</td>
															<td align="left" colspan="6" >
																<xsl:value-of select="@equation"/>
															</td>
														</tr>
													</xsl:for-each>
													<tr/>
												</xsl:if>
												 <!-- End of Curve Calcs -->
												<tr>
													<td/>
													<th align="left" lang="en" colspan="9" class="underline">End of curve results</th>
												</tr>
												<tr>
													<th align="right" lang="en" colspan="2">Spiral Exists:&#xa0; </th>
													<td align="left" colspan="8">
														<xsl:value-of select="EndOfCurveCalculations/@spiralExists"/>
													</td>
												</tr>
												<xsl:if test="EndOfCurveCalculations/@spiralExists='true'">
													<tr>
														<th align="right" lang="en" colspan="2">Spiral Length:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/@spiralLength))"/>
														</td>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Spiral End Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/StartOfSpiralStation/@externalStation), string(EndOfCurveCalculations/StartOfSpiralStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/StartOfSpiralStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<tr>
													<th align="right" lang="en" colspan="2">Arc End Chainage:&#xa0; </th>
													<td align="left">
														<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/StartOfArcStation/@externalStation), string(EndOfCurveCalculations/StartOfArcStation/@externalStationName))"/>
													</td>
													<th align="right" lang="en">Internal Chainage:&#xa0; </th>
													<td align="left">
														<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/StartOfArcStation/@internalStation))"/>
													</td>
												</tr>
												<xsl:if test="EndOfCurveCalculations/FullSuperStation">
													<tr>
														<th align="right" lang="en" colspan="2">Full Super Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/FullSuperStation/@externalStation), string(EndOfCurveCalculations/FullSuperStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/FullSuperStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="EndOfCurveCalculations/ReverseCrownStation">
													<tr>
														<th align="right" lang="en" colspan="2">Reverse Crown Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/ReverseCrownStation/@externalStation), string(EndOfCurveCalculations/ReverseCrownStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/ReverseCrownStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="EndOfCurveCalculations/RunoffStation">
													<tr>
														<th align="right" lang="en" colspan="2">Runoff (Zero Cross Slope) Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/RunoffStation/@externalStation), string(EndOfCurveCalculations/RunoffStation/@externalStationName))"/>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/RunoffStation/@internalStation))"/>
														</td>
														</td>
													</tr>
												</xsl:if>
												<xsl:if test="EndOfCurveCalculations/RunoutStation">
													<tr>
														<th align="right" lang="en" colspan="2">Runout (Normal Crown) Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(EndOfCurveCalculations/RunoutStation/@externalStation), string(EndOfCurveCalculations/RunoutStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(EndOfCurveCalculations/RunoutStation/@internalStation))"/>
														</td>
													</tr>
												</xsl:if>
												<!-- End Standard Chainage customization -->
												<xsl:if test="StandardStationCustomization">
													<tr>
														<td/>
														<th align="left" lang="en" colspan="9" class="underline">End of curve standard chainage customization</th>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Criteria Value:&#xa0; </th>
														<td align="left">
															<xsl:choose>
																<xsl:when test="StandardStationCustomization/EndOfCurve/@criteriaEquation">
																	<xsl:value-of select="StandardStationCustomization/EndOfCurve/@criteriaValue"/>
																</xsl:when>
																<xsl:otherwise>
																True
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<xsl:if test="StandardStationCustomization/EndOfCurve/@criteriaEquation">
															<th align="right" lang="en">Criteria Equation:&#xa0; </th>
															<td align="left" colspan="6">
																<xsl:value-of select="StandardStationCustomization/EndOfCurve/@criteriaEquation"/>
															</td>
														</xsl:if>
													</tr>
													<xsl:if test="StandardStationCustomization/EndOfCurve/FullSuperStation">
														<tr>
															<th align="right" colspan="2">Modified Full Super Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/EndOfCurve/FullSuperStation/@externalStation), string(StandardStationCustomization/EndOfCurve/FullSuperStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/EndOfCurve/FullSuperStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/EndOfCurve/FullSuperStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/EndOfCurve/ReverseCrownStation">
														<tr>
															<th align="right" colspan="2">Modified Reverse Crown Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/EndOfCurve/ReverseCrownStation/@externalStation), string(StandardStationCustomization/EndOfCurve/ReverseCrownStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/EndOfCurve/ReverseCrownStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/EndOfCurve/ReverseCrownStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/EndOfCurve/RunoffStation">
														<tr>
															<th align="right" colspan="2">Modified Runoff Chainage:</th>
															<td align="left">
																<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/EndOfCurve/RunoffStation/@externalStation), string(StandardStationCustomization/EndOfCurve/RunoffStation/@externalStationName))"/>
															</td>
															<th align="right" lang="en">Internal Chainage:&#xa0; </th>
															<td align="left">
																<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/EndOfCurve/RunoffStation/@internalStation))"/>
															</td>
															<th align="right" lang="en">Equation:&#xa0;</th>
															<td align="left" colspan="4">
																<xsl:value-of select="StandardStationCustomization/EndOfCurve/RunoffStation/@equation"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test="StandardStationCustomization/EndOfCurve/RunoutStation">
													<tr>
														<th align="right" colspan="2">Modified Runout Chainage:</th>
														<td align="left">
															<xsl:value-of select="cif:stationFormat(number(StandardStationCustomization/EndOfCurve/RunoutStation/@externalStation), string(StandardStationCustomization/EndOfCurve/RunoutStation/@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(StandardStationCustomization/EndOfCurve/RunoutStation/@internalStation))"/>
														</td>
														<th align="right" lang="en">Equation:&#xa0;</th>
														<td align="left" colspan="4">
															<xsl:value-of select="StandardStationCustomization/EndOfCurve/RunoutStation/@equation"/>
														</td>
													</tr>
													</xsl:if>
													<tr>
														<th align="right" lang="en" colspan="2">Variables:&#xa0; </th>
														<th align="left" lang="en">Name</th>
														<th align="left" lang="en">Value</th>
														<th align="left" lang="en" colspan="6">Equation</th>
													</tr>
													<xsl:for-each select="StandardStationCustomization/EndOfCurve/Variable">
														<tr >
															<td/>
															<td/>
															<td align="left">
																<xsl:value-of select="@name"/>
															</td>
															<td align="left">
																<xsl:value-of select="@value"/>
															</td>
															<td align="left" colspan="5" >
																<xsl:value-of select="@equation"/>
															</td>
														</tr>
													</xsl:for-each>
												</xsl:if>
											</xsl:for-each>
											<!-- Overlap adjustments -->
											<xsl:if test="OverlapAdjustments">
												<tr>
													<th align="left" lang="en" class="underline" colspan="9">Overlap Adjustments</th>
												</tr>
												<xsl:for-each select="OverlapAdjustments/OverlapAdjustment">
													<tr>
														<th align="right" lang="en">First curve set id:&#xa0;</th>
														<td>
															<xsl:value-of select="@firstCurveID"/>
														</td>
													</tr>
													<tr>
														<th align="right" lang="en">Second curve set id:&#xa0;</th>
														<td>
															<xsl:value-of select="@secondCurveID"/>
														</td>
													</tr>
													<tr>
														<th align="right" lang="en">Adjustment type:&#xa0;</th>
														<td>
															<xsl:value-of select="@adjustmentType"/>
														</td>
													</tr>
													<xsl:if test="@customDescription">
														<tr>
															<th align="right" lang="en">Description:&#xa0;</th>
															<td>
																<xsl:value-of select="@customDescription"/>
															</td>
														</tr>
													</xsl:if>
													<tr>
														<th align="right" lang="en">Normal Crown gap:&#xa0;</th>
														<td>
															<xsl:value-of select="@normalCrownGap"/>
														</td>
													</tr>
													<tr>
														<th align="right" lang="en">Arc gap:&#xa0;</th>
														<td>
															<xsl:value-of select="@arcGap"/>
														</td>
													</tr>
													<tr>
														<th align="center" lang="en" colspan="2">First Curve Set Adjustments</th>
														<xsl:if test="FirstCurveAdjustments/@adjustmentAmount">
															<th align="right" lang="en">Adjustment amount:&#xa0;</th>
															<td align="left">
																<xsl:value-of select="FirstCurveAdjustments/@adjustmentAmount"/>
															</td>
														</xsl:if>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">End Full Super:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="FirstCurveAdjustments/@endFullSuperDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="FirstCurveAdjustments/EndFullSuperStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(FirstCurveAdjustments/EndFullSuperStation/@externalStation), string(FirstCurveAdjustments/EndFullSuperStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(FirstCurveAdjustments/EndFullSuperStation/@internalStation))"/>
																</td>
																<xsl:if test="FirstCurveAdjustments/EndFullSuperStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="FirstCurveAdjustments/EndFullSuperStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">End Reverse Crown:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="FirstCurveAdjustments/@endReverseCrownDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="FirstCurveAdjustments/EndReverseCrownStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(FirstCurveAdjustments/EndReverseCrownStation/@externalStation), string(FirstCurveAdjustments/EndReverseCrownStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(FirstCurveAdjustments/EndReverseCrownStation/@internalStation))"/>
																</td>
																<xsl:if test="FirstCurveAdjustments/EndReverseCrownStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="FirstCurveAdjustments/EndReverseCrownStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">End Zero Cross Slope Chainage:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="FirstCurveAdjustments/@endZeroCrossSlopeDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="FirstCurveAdjustments/EndZeroCrossSlopeStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(FirstCurveAdjustments/EndZeroCrossSlopeStation/@externalStation), string(FirstCurveAdjustments/EndZeroCrossSlopeStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(FirstCurveAdjustments/EndZeroCrossSlopeStation/@internalStation))"/>
																</td>
																<xsl:if test="FirstCurveAdjustments/EndZeroCrossSlopeStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="FirstCurveAdjustments/EndZeroCrossSlopeStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">End Normal Crown Chainage:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="FirstCurveAdjustments/@endNormalCrownDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="FirstCurveAdjustments/EndNormalCrownStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(FirstCurveAdjustments/EndNormalCrownStation/@externalStation), string(FirstCurveAdjustments/EndNormalCrownStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(FirstCurveAdjustments/EndNormalCrownStation/@internalStation))"/>
																</td>
																<xsl:if test="FirstCurveAdjustments/EndNormalCrownStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="FirstCurveAdjustments/EndNormalCrownStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="center" lang="en" colspan="2">Second Curve Set Adjustments</th>
														<xsl:if test="SecondCurveAdjustments/@adjustmentAmount">
															<th align="right" lang="en">Adjustment amount:&#xa0;</th>
															<td align="left">
																<xsl:value-of select="SecondCurveAdjustments/@adjustmentAmount"/>
															</td>
														</xsl:if>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Begin Full Super:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="SecondCurveAdjustments/@fullSuperDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="SecondCurveAdjustments/FullSuperStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(SecondCurveAdjustments/FullSuperStation/@externalStation), string(SecondCurveAdjustments/FullSuperStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(SecondCurveAdjustments/FullSuperStation/@internalStation))"/>
																</td>
																<xsl:if test="SecondCurveAdjustments/FullSuperStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="SecondCurveAdjustments/FullSuperStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Begin Reverse Crown:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="SecondCurveAdjustments/@reverseCrownDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="SecondCurveAdjustments/ReverseCrownStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(SecondCurveAdjustments/ReverseCrownStation/@externalStation), string(SecondCurveAdjustments/ReverseCrownStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(SecondCurveAdjustments/ReverseCrownStation/@internalStation))"/>
																</td>
																<xsl:if test="SecondCurveAdjustments/ReverseCrownStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="SecondCurveAdjustments/ReverseCrownStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Begin Zero Cross Slope Chainage:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="SecondCurveAdjustments/@zeroCrossSlopeDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="SecondCurveAdjustments/ZeroCrossSlopeStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(SecondCurveAdjustments/ZeroCrossSlopeStation/@externalStation), string(SecondCurveAdjustments/ZeroCrossSlopeStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(SecondCurveAdjustments/ZeroCrossSlopeStation/@internalStation))"/>
																</td>
																<xsl:if test="SecondCurveAdjustments/ZeroCrossSlopeStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="SecondCurveAdjustments/ZeroCrossSlopeStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Begin Normal Crown Chainage:&#xa0;</th>
														<xsl:choose>
															<xsl:when test="SecondCurveAdjustments/@normalCrownDeleted = 'true'">
																<td align="left" lang="en">Deleted</td>
															</xsl:when>
															<xsl:when test="SecondCurveAdjustments/NormalCrownStation">
																<td align="left">
																	<xsl:value-of select="cif:stationFormat(number(SecondCurveAdjustments/NormalCrownStation/@externalStation), string(SecondCurveAdjustments/NormalCrownStation/@externalStationName))"/>
																</td>
																<th align="right" lang="en">Internal Chainage:&#xa0; </th>
																<td align="left">
																	<xsl:value-of select="cif:distanceFormat(number(SecondCurveAdjustments/NormalCrownStation/@internalStation))"/>
																</td>
																<xsl:if test="SecondCurveAdjustments/NormalCrownStation/@equation">
																	<td align="left">=</td>
																	<td align="left" colspan="4">
																		<xsl:value-of select="SecondCurveAdjustments/NormalCrownStation/@equation"/>
																	</td>
																</xsl:if>
															</xsl:when>
														</xsl:choose>
													</tr>
													<tr>
														<th align="right" lang="en" colspan="2">Variables:&#xa0; </th>
														<th align="left" lang="en">Name</th>
														<th align="left" lang="en">Value</th>
														<th align="left" lang="en" colspan="6">Equation</th>
													</tr>
													<xsl:for-each select="GlobalVariables/Variable">
														<tr >
															<td/>
															<td/>
															<td align="left">
																<xsl:value-of select="@name"/>
															</td>
															<td align="left">
																<xsl:value-of select="@value"/>
															</td>
															<td align="left" colspan="5" >
																<xsl:value-of select="@equation"/>
															</td>
														</tr>
													</xsl:for-each>
													
												</xsl:for-each>
											</xsl:if>
											<!-- Custom Key Chainages -->
											<xsl:if test="CustomKeyStations">
												<tr>
													<th align="left" lang="en" class="underline" >Custom Chainages</th>
													<th align="right" lang="en" class="underline">Criteria Equation: </th>
													<td align="left" colspan="7" class="underline">
														<xsl:choose>
															<xsl:when test="CustomKeyStations/@criteriaEquation">
																<xsl:value-of select="CustomKeyStations/@criteriaEquation"/>
															</xsl:when>
															<xsl:otherwise>True</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
												<xsl:for-each select="CustomKeyStations/CurveSets/CurveSet">
													<tr>
														<th align="left" lang="en">Curve Set <xsl:value-of select="@id"/></th>
													</tr>
													<tr>
														<th align="center" lang="en">Start of curve</th>
														<th align="right" lang="en">Criteria Value:&#xa0;</th>
														<td align="left">
															<xsl:value-of select="StartOfCurve/@criteriaValue"/>
														</td>
													</tr>
													<xsl:for-each select="StartOfCurve/CustomStation">
													<tr>
														<th align="right" lang="en">Custom Chainage:&#xa0;</th>
														<td align="left" lang="en">
															<xsl:value-of select="cif:stationFormat(number(@externalStation), string(@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(@internalStation))"/>
														</td>
														<td align="left" lang="en" colspan="2">
															<xsl:choose>
																<xsl:when test="@equation">
																	= <xsl:value-of select="@equation"/>
																</xsl:when>
																<xsl:otherwise>
																	Interpolated
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<th align="right" lang="en">Cross slope:&#xa0;</th>
														<td align="left">
															<xsl:value-of select="cif:gradeFormat(number(@crossSlopeValue))"/>
														</td>
														<td align="left" lang="en" colspan="2">
															<xsl:choose>
																<xsl:when test="@crossSlopeEquation">
																	= <xsl:value-of select="@crossSlopeEquation"/>
																</xsl:when>
																<xsl:otherwise>
																	Interpolated
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
													</xsl:for-each>
													<tr>
														<th align="right" lang="en" colspan="2">Variables:&#xa0; </th>
														<th align="left" lang="en">Name</th>
														<th align="left" lang="en">Value</th>
														<th align="left" lang="en" colspan="6">Equation</th>
													</tr>
													<xsl:for-each select="StartOfCurve/Variable">
														<tr >
															<td/>
															<td/>
															<td align="left">
																<xsl:value-of select="@name"/>
															</td>
															<td align="left">
																<xsl:value-of select="@value"/>
															</td>
															<td align="left" colspan="5" >
																<xsl:value-of select="@equation"/>
															</td>
														</tr>
													</xsl:for-each>
													<tr>
														<th align="center" lang="en">End of curve</th>
														<th align="right" lang="en">Criteria Value:&#xa0;</th>
														<td align="left">
															<xsl:value-of select="EndOfCurve/@criteriaValue"/>
														</td>
													</tr>
													<xsl:for-each select="EndOfCurve/CustomStation">
													<tr>
														<th align="right" lang="en">Custom Chainage:&#xa0;</th>
														<td align="left" lang="en">
															<xsl:value-of select="cif:stationFormat(number(@externalStation), string(@externalStationName))"/>
														</td>
														<th align="right" lang="en">Internal Chainage:&#xa0; </th>
														<td align="left">
															<xsl:value-of select="cif:distanceFormat(number(@internalStation))"/>
														</td>
														<td align="left" lang="en" colspan="2">
															<xsl:choose>
																<xsl:when test="@equation">
																	= <xsl:value-of select="@equation"/>
																</xsl:when>
																<xsl:otherwise>
																	Interpolated
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<th align="right" lang="en">Cross slope:&#xa0;</th>
														<td align="left">
															<xsl:value-of select="cif:gradeFormat(number(@crossSlopeValue))"/>
														</td>
														<td align="left" lang="en" colspan="2">
															<xsl:choose>
																<xsl:when test="@crossSlopeEquation">
																	= <xsl:value-of select="@crossSlopeEquation"/>
																</xsl:when>
																<xsl:otherwise>
																	Interpolated
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
													</xsl:for-each>
													<tr>
														<th align="right" lang="en" colspan="2">Variables:&#xa0; </th>
														<th align="left" lang="en">Name</th>
														<th align="left" lang="en">Value</th>
														<th align="left" lang="en" colspan="6">Equation</th>
													</tr>
													<xsl:for-each select="EndOfCurve/Variable">
														<tr >
															<td/>
															<td/>
															<td align="left">
																<xsl:value-of select="@name"/>
															</td>
															<td align="left">
																<xsl:value-of select="@value"/>
															</td>
															<td align="left" colspan="5" >
																<xsl:value-of select="@equation"/>
															</td>
														</tr>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:if>
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
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must have defined superelevation for the section.
            </p>
            <p class="normal1" lang="en">
                You must select at least one superelevation section.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>