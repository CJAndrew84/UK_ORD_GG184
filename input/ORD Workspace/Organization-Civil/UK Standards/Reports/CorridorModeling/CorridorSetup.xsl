<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:include href="../format.xsl"/>
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Roadway Setup Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Corridor Setup Report</title>
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
                                <h2 lang="en">Corridor Setup Report</h2>
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
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Corridor Information -->
                                <table class="margin" width="95%">
                                    <xsl:for-each select="Corridor">
                                        <tr>
                                            <td lang="en"><strong>Corridor:&#xa0; </strong><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <td lang="en">
                                                <strong>Start Chainage:&#xa0; </strong>
                                                <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
                                                <strong>&#xa0; &#xa0; Stop Chainage:&#xa0; </strong>
                                                <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                <strong>&#xa0; &#xa0; Chainage Limits Used:&#xa0; </strong>
                                                <xsl:choose>
                                                    <xsl:when test="@useStationLimits = 'true'">Yes</xsl:when>
                                                    <xsl:otherwise>No</xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="40%">
                                                    <tr>
                                                        <th colspan="3" lang="en">Secondary Alignments</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Start<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">End<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">Offset</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="SecondaryAlignment">
                                                            <xsl:for-each select="SecondaryAlignment">
                                                                <tr>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
                                                                    </td>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                                    </td>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:distanceFormat(number(@offset))"/>
                                                                    </td>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="3" lang="en">No Secondary Alignments used</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <tr><td>&#xa0;</td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="40%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="3" lang="en">Key Chainages</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">X</th>
                                                        <th class="underline" lang="en" valign="bottom">Y</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="KeyStation">
                                                            <xsl:for-each select="KeyStation">
                                                                <tr>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(@externalStation), string(@externalStationName))"/>
                                                                    </td>
                                                                    <td class="sidepad" align="right">
                                                                        <xsl:value-of select="cif:ordinateFormat(number(@xLocation))"/>
                                                                    </td>
                                                                    <td class="sidepad" align="right">
                                                                        <xsl:value-of select="cif:ordinateFormat(number(@yLocation))"/>
                                                                    </td>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="3" lang="en">No Key Chainages found</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="70%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="5" lang="en">Template Drops</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Start<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">Stop<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">Interval</th>
                                                        <th class="underline" lang="en" valign="bottom">Template</th>
                                                        <th class="underline" lang="en" valign="bottom">Horizontal<br/>Offset</th>
                                                        <th class="underline" lang="en" valign="bottom">Vertical<br/>Offset</th>
                                                        <th class="underline" lang="en" valign="bottom">Description</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="TemplateDrop">
                                                            <xsl:for-each select="TemplateDrop">
                                                                <tr>
                                                                    <td align="center" class="sidepad" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
                                                                    </td>
                                                                    <td align="center" class="sidepad" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                                    </td>
                                                                    <td align="center" class="sidepad" ><xsl:value-of select="cif:distanceFormat(number(@interval))"/></td>
                                                                    <td align="center" class="sidepad"><xsl:value-of select="Template/@name"/></td>
                                                                    <td align="center" class="sidepad" nowrap="nowrap" valign="bottom">
                                                                        <xsl:value-of select="cif:distanceFormat(number(Template/@translationDX))"/>
                                                                    </td>
                                                                    <td align="center" class="sidepad" nowrap="nowrap" valign="bottom">
                                                                        <xsl:value-of select="cif:distanceFormat(number(Template/@translationDY))"/>
                                                                    </td>
                                                                  <td align="center" class="sidepad" >
                                                                    <xsl:value-of select="Template/@description"/>
                                                                  </td>

                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="5" lang="en">No Template Drops found</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <tr><td>&#xa0;</td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="70%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="6" lang="en">Labeled Constraints</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Label</th>
                                                        <th class="underline" lang="en" valign="bottom">Start<br/>Value</th>
                                                        <th class="underline" lang="en" valign="bottom">Stop<br/>Value</th>
                                                        <th class="underline" lang="en" valign="bottom">Start<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom">Stop<br/>Chainage</th>
                                                        <th class="underline" lang="en" valign="bottom" colspan="2">Type</th>
                                                    </tr>
                                                   <xsl:choose>
                                                        <xsl:when test="ParametricConstraints">
                                                            <xsl:for-each select="ParametricConstraints/LabeledConstraint">
                                                                <tr>
                                                                    <td class="sidepad"><xsl:value-of select="@label"/></td>
                                                                    <xsl:choose>
                                                                        <xsl:when test="@type = '2'">
                                                                            <td class="sidepad" align="right">
                                                                                <xsl:value-of select="cif:gradeFormat(number(@startValue))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td class="sidepad" align="right">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@startValue))"/>
                                                                            </td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                    <xsl:choose>
                                                                        <xsl:when test="@type = '2'">
                                                                            <td class="sidepad" align="right">
                                                                                <xsl:value-of select="cif:gradeFormat(number(@stopValue))"/>
                                                                            </td>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <td class="sidepad" align="right">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@stopValue))"/>
                                                                            </td>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
                                                                    </td>
                                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                                        <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                                    </td>
                                                                    <xsl:if test="@type = '1'">
                                                                        <td>
                                                                            <th align="left" nowrap="nowrap" lang="en">Distance&#xa0; </th>
                                                                        </td>
                                                                    </xsl:if>
                                                                    <xsl:if test="@type = '2'">
                                                                        <td>
                                                                            <th align="left" lang="en">Slope&#xa0; </th>
                                                                        </td>
                                                                    </xsl:if>
                                                                    <xsl:if test="@type = '3'">
                                                                        <td>
                                                                            <th align="left" lang="en">Angle&#xa0; </th>
                                                                        </td>
                                                                    </xsl:if>
                                                                    <xsl:if test="@type = '4'">
                                                                        <td>
                                                                            <th align="left" lang="en">Surface&#xa0; </th>
                                                                        </td>
                                                                    </xsl:if>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="5" lang="en">No Labeled Constraints found</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <tr><td>&#xa0;</td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="100%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="7" lang="en">Point Controls</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Priority</th>
                                                        <th class="underline" lang="en" valign="bottom">Point Name</th>
                                                        <th class="underline" lang="en" valign="bottom">Start<br/>Chainage/Offset</th>
                                                        <th class="underline" lang="en" valign="bottom">End<br/>Chainage/Offset</th>
                                                        <th class="underline" lang="en" valign="bottom">Mode</th>
                                                        <th class="underline" lang="en" valign="bottom">Control<br/>Type</th>
                                                        <th class="underline" lang="en" valign="bottom">Control Name</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="HVControls">
                                                            <xsl:for-each select="HVControls/HVControl">
                                                                <tr>
                                                                    <td class="sidepad" align="center" valign="top"><xsl:value-of select="@priority"/></td>
                                                                    <td class="sidepad" align="center" valign="top"><xsl:value-of select="@pointName"/></td>
																	<td class="sidepad" align="right" nowrap="nowrap" valign="top">
                                                                        <xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
																		<br/>
                                                                        <xsl:choose>
                                                                            <xsl:when test="@mode='Horizontal'">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@offsetStart))"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="@mode='Vertical'">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@verticalOffsetStart))"/>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@offsetStart))"/>
                                                                                        <br/>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@verticalOffsetStart))"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
																	</td>
                                                                    <td class="sidepad" align="right" nowrap="nowrap" valign="top">
                                                                        <xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
                                                                        <br/>
                                                                        <xsl:choose>
                                                                            <xsl:when test="@mode='Horizontal'">
                                                                                <xsl:value-of select="cif:distanceFormat(number(@offsetStop))"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="@mode='Vertical'">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@verticalOffsetStop))"/>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@offsetStop))"/>
                                                                                        <br/>
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@verticalOffsetStop))"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </td>
                                                                    <td class="sidepad" align="center" valign="top"><xsl:value-of select="@mode"/></td>
                                                                    <td class="sidepad" align="center" valign="top"><xsl:value-of select="@controlType"/></td>
                                                                    <td class="sidepad" align="center" valign="top"><xsl:value-of select="@controlName"/></td>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="7" lang="en">No Point Controls used</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <tr><td>&#xa0;</td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="100%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="6" lang="en">Transitions</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" rowspan="2" valign="bottom">Start<br/>Chainage</th>
                                                        <th class="underline" lang="en" rowspan="2" valign="bottom">Stop<br/>Chainage</th>
                                                        <th colspan="2" lang="en" valign="bottom">- - - - - - From - - - - - -</th>
                                                        <th colspan="2" lang="en" valign="bottom">- - - - - - - To - - - - - - -</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="underline" lang="en" valign="bottom">Template</th>
                                                        <th class="underline" lang="en" valign="bottom">Point</th>
                                                        <th class="underline" lang="en" valign="bottom">Template</th>
                                                        <th class="underline" lang="en" valign="bottom">Point</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="Transition">
                                                            <xsl:for-each select="Transition">
                                                                <xsl:for-each select="TransitionLine">
                                                                    <tr>
                                                                        <xsl:choose>
                                                                            <xsl:when test="position() = 1">
                                                                                <td align="center" nowrap="nowrap">
                                                                                    <xsl:value-of select="cif:stationFormat(number(../StartStation/@externalStation), string(../StartStation/@externalStationName))"/>
                                                                                </td>
                                                                                <td align="center" nowrap="nowrap">
                                                                                    <xsl:value-of select="cif:stationFormat(number(../StopStation/@externalStation), string(../StartStation/@externalStationName))"/>
                                                                                </td>
                                                                            </xsl:when>
                                                                            <xsl:otherwise><td colspan="2">&#xa0;</td></xsl:otherwise>
                                                                        </xsl:choose>
                                                                        <td align="center">
                                                                            <xsl:value-of select="../StartTemplate/@name"/>
                                                                        </td>
                                                                        <td align="center" class="sidepad"><xsl:value-of select="@point1"/></td>
                                                                        <td align="center">
                                                                            <xsl:value-of select="../StopTemplate/@name"/>
                                                                        </td>
                                                                        <td align="center" class="sidepad"><xsl:value-of select="@point2"/></td>
                                                                    </tr>
                                                                    <xsl:if test="position() = last()">
                                                                        <tr><td colspan="6">&#xa0;</td></tr>
                                                                    </xsl:if>
                                                                </xsl:for-each>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="6" lang="en">No Transitions found</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td><hr size="1"/></td></tr>
                                        <tr><td>&#xa0;</td></tr>
                                        <tr>
                                            <td>
                                                <table width="40%">
                                                    <tr style="page-break-before:always">
                                                        <th colspan="5" lang="en">End Condition Exceptions</th>
                                                    </tr>
                                                    <tr>
														<th class="underline" lang="en" valign="bottom">Description</th>
														<th class="underline" lang="en" valign="bottom">Enabled</th>
														<th class="underline" lang="en" valign="bottom">Type</th>
														<th class="underline" lang="en" valign="bottom">Start Chainage</th>
														<th class="underline" lang="en" valign="bottom">Stop Chainage</th>
                                                    </tr>
                                                    <xsl:choose>
                                                        <xsl:when test="EndConditionExceptions">
                                                            <xsl:for-each select="EndConditionExceptions/EndConditionException">
                                                                <tr>
																	<td class="sidepad" valign="top">
																		<xsl:value-of select="@description"/>
																	</td>
																	<td class="sidepad" valign="top">
																		<xsl:value-of select="@enabled"/>
																	</td>
																	<td class="sidepad" align="left" nowrap="nowrap">
																		<xsl:choose>
																			<xsl:when test="@type = 'OverrideLeft' and @backboneOnly = 'true'">Backbone Only (Left)</xsl:when>
																			<xsl:when test="@type = 'OverrideRight' and @backboneOnly = 'true'">Backbone Only (Right)</xsl:when>
																			<xsl:when test="@type = 'OverrideLeft'">Left Override</xsl:when>
																			<xsl:when test="@type = 'OverrideRight'">Right Override</xsl:when>
																			<xsl:when test="@type = 'TransitionLeft'">Left Transition</xsl:when>
																			<xsl:when test="@type = 'TransitionRight'">Right Transition</xsl:when>
																			<xsl:otherwise>Unknown</xsl:otherwise>
																		</xsl:choose>
																	</td>
																	<td class="sidepad" align="right" nowrap="nowrap">
																		<xsl:value-of select="cif:stationFormat(number(StartStation/@externalStation), string(StartStation/@externalStationName))"/>
																	</td>
																	<td class="sidepad" align="right" nowrap="nowrap">
																		<xsl:value-of select="cif:stationFormat(number(StopStation/@externalStation), string(StopStation/@externalStationName))"/>
																	</td>
                                                                    
                                                                </tr>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <tr>
                                                                <td colspan="3" lang="en">No End Condition Exceptions found</td>
                                                            </tr>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td>&#xa0;</td></tr>
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
                You must select a corridor to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
