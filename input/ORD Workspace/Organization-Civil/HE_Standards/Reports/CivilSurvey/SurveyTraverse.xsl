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
                <title lang="en">Traverse Report</title>
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
                                    <h2 lang="en">Traverse Report</h2>
                                    <p lang="en">
                                        Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                        Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                    </p>
                                </center>
                                <p lang="en" style="text-align:right;font-size:80%">
                                    <strong>Note:&#xa0; </strong>All units in this report are in 
                                    <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                    <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                    unless specified otherwise.
                                </p>
                                <hr/>
                                <xsl:choose>
                                    <xsl:when test="@isRoute = 'true'">
                                        <center><h4 lang="en">Overview</h4></center>
                                        <hr size="1px"/>
                                        <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                            <colgroup span="2">
                                                <col width="50%"/>
                                                <col width="50%"/>
                                            </colgroup>
                                            <tbody>
                                              <tr>
                                                <th align="left" lang="en">Traverse Name:</th>
                                                <td>
                                                  <xsl:value-of select="@name"/>
                                                </td>
                                              </tr>
                                              <tr>
                                                    <th align="left" lang="en">Traverse Points:</th>
                                                    <td>
                                                        <xsl:value-of select="(@numberFreePoints+@numberFixedPoints)"/> Total, 
                                                        <xsl:value-of select="@numberFixedPoints"/> Fixed, 
                                                        <xsl:value-of select="@numberFreePoints"/> Free
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Traverse Classification:</th>
                                                    <td><xsl:value-of select="@closureType"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Traverse Adjustments:</th>
                                                    <td lang="en">
                                                        <xsl:if test="//@reciprocalZenith='true'">Reciprocal Zenith</xsl:if>
                                                        <xsl:if test="//@horizontalZenith='true'">
                                                            <xsl:choose>
                                                                <xsl:when test="//@reciprocalZenith='true'">
                                                                     , Horizontal Angle
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    Horizontal Angle
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:if>
                                                        <xsl:if test="@elevationAdjustment = 'true'">
                                                            <xsl:choose>
                                                                <xsl:when test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true'">
                                                                     , Elevation Adjustment
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    Elevation Adjustment
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:if>
                                                        <xsl:if test="//@traverseAdjustment = 'true'">
                                                            <xsl:choose>
                                                                <xsl:when test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true' or @elevationAdjustment = 'true'">
                                                                     , <xsl:value-of select="@adjustmentType"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="@adjustmentType"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:if>
                                                        <xsl:if test="@verticalPosition = '1'">
                                                            <xsl:choose>
                                                                <xsl:when test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true' or //@traverseAdjustment = 'true'">
                                                                     , Vertical Position
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    Vertical Position
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:if>
                                                        <xsl:if test="//@reciprocalZenith = '0' and //@horizontalZenith = '0' and //@traverseAdjustment = '0'">
                                                            None
                                                        </xsl:if>
                                                    </td>
                                                </tr>
                                                <tr><td>&#xa0;</td></tr>
                                                <tr>
                                                    <th align="left" lang="en">Horizontal Angle Control:</th>
                                                    <td lang="en">
                                                        <xsl:choose>
                                                            <xsl:when test="@horizontalAngleControl = 'true'">Yes</xsl:when>
                                                            <xsl:otherwise>No</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en" nowrap="nowrap">Horizontal Position Control:</th>
                                                    <td lang="en">
                                                        <xsl:choose>
                                                            <xsl:when test="@horizontalPositionControl = 'true'">Yes</xsl:when>
                                                            <xsl:otherwise>No</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Vertical Position Control:</th>
                                                    <td lang="en">
                                                        <xsl:choose>
                                                            <xsl:when test="@verticalAngleControl = 'true'">Yes</xsl:when>
                                                            <xsl:otherwise>No</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                </tr>
                                                <tr><td>&#xa0;</td></tr>
                                            </tbody>
                                        </table>
                                        <hr size="1px"/>
                                        <!-- Traverse Data -->
                                        <center><h4 lang="en">Traverse</h4></center>
                                        <hr size="1px"/>
                                        <xsl:if test="@areaDefined != 'false'">
                                            <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                                <colgroup span="2">
                                                    <col width="50%"/>
                                                    <col width="50%"/>
                                                </colgroup>
                                                <tbody>
                                                    <tr><td>&#xa0;</td></tr>
                                                    <tr>
                                                        <th align="left" lang="en" nowrap="nowrap">Unadjusted Area:</th>
                                                        <td lang="en">
                                                            <xsl:value-of select="cif:areaFormat(number(@area))"/> (Sq 
                                                            <xsl:value-of select="//@linearUnits"/>)
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th align="left" lang="en">Adjusted Area:</th>
                                                        <td lang="en">
                                                            <xsl:choose>
                                                                <xsl:when test="@adjustedAreaDefined = 'true'">
                                                                    <xsl:value-of select="cif:areaFormat(number(@adjustedArea))"/> (Sq 
                                                                    <xsl:value-of select="//@linearUnits"/>)
                                                                </xsl:when>
                                                                <xsl:otherwise/>
                                                            </xsl:choose>
                                                        </td>
                                                    </tr>
                                                    <tr><td>&#xa0;</td></tr>
                                                </tbody>
                                            </table>
                                        </xsl:if>
                                        <table border="1" class="margin" cellpadding="2" cellspacing="0" style="border-right-width:0px;border-left-width:0px;border-bottom-width:0px" width="95%">
                                            <thead>
                                                <tr>
                                                    <th lang="en" style="border-left-width:2px">Point</th>
                                                    <th lang="en">Azimuth</th>
                                                    <th lang="en">Length</th>
                                                    <th lang="en">Latitude</th>
                                                    <th lang="en">Departure</th>
                                                    <th lang="en">X</th>
                                                    <th lang="en">Y</th>
                                                    <th lang="en" style="border-right-width:2px">Elevation</th>
                                                </tr>
                                                <tr/>
                                            </thead>
                                            <xsl:for-each select="Route/RoutePoint">
                                                <tbody>
                                                    <xsl:call-template name="displayBacksight"/>
                                                    <xsl:call-template name="displayTraverse">
                                                        <xsl:with-param name="traverseAdjustment" select="//@traverseAdjustment"/>
                                                        <xsl:with-param name="horizontalZenith" select="//@horizontalZenith"/>
                                                        <xsl:with-param name="reciprocalZenith" select="//@reciprocalZenith"/>
                                                    </xsl:call-template>
                                                    <xsl:call-template name="displayForesight"/>
                                                    <xsl:if test="position() = last()">
                                                        <xsl:call-template name="displayTraverseTotal">
                                                            <xsl:with-param name="traverseAdjustment" select="//@traverseAdjustment"/>
                                                            <xsl:with-param name="horizontalZenith" select="//@horizontalZenith"/>
                                                            <xsl:with-param name="reciprocalZenith" select="//@reciprocalZenith"/>
                                                        </xsl:call-template>
                                                    </xsl:if>
                                                </tbody>
                                            </xsl:for-each>
                                        </table>
                                        <br/>
                                        <hr size="1px"/>
                                        <!-- Error Anaysis Data -->
                                        <center><h4 lang="en">Error Analysis</h4></center>
                                        <hr size="1px"/>
                                        <table class="margin" cellpadding="1" cellspacing="2" width="95%">
                                            <tbody>
                                                <!-- End Azimuth -->
                                                <tr><th align="left" colspan="7" lang="en">End Azimuth:</th></tr>
                                                <tr>
                                                    <th class="underline" colspan="2">&#xa0;</th>
                                                    <th class="underline" lang="en">Error</th>
                                                    <th class="underline" lang="en">Error Per Angle</th>
                                                    <th colspan="3">&#xa0;</th>
                                                </tr>
                                                <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <td lang="en">Fixed</td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:angularFormat(number(@fixedEndAzimuth))"/>
                                                    </td>
                                                    <td align="right">---</td>
                                                    <td align="right">---</td>
                                                    <td colspan="3">&#xa0;</td>
                                                </tr>
                                                <tr>
                                                    <td align="left" lang="en" nowrap="nowrap">Computed Original</td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:angularFormat(number(@computedOriginalEndAzimuth))"/>
                                                    </td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:angularFormat(number(@differenceAzimuth))"/>
                                                    </td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:angularFormat(number(@computedErrorPerAngle))"/>
                                                    </td>
                                                    <td colspan="3">&#xa0;</td>
                                                </tr>
                                                <tr><td colspan="7">&#xa0;</td></tr>
                                                <!-- End Position -->
                                                <tr><th align="left" colspan="7" lang="en">End Position:</th></tr>
                                                <tr>
                                                    <th class="underline">&#xa0;</th>
                                                    <th class="underline" lang="en">X</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                    <th class="underline" lang="en">Y</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                    <th class="underline" lang="en">Elevation</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                </tr>
                                                <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <td lang="en">Fixed</td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointEasting))"/>
                                                    </td>
                                                    <td align="right">---</td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointNorthing))"/>
                                                    </td>
                                                    <td align="right">---</td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointElevation))"/>
                                                    </td>
                                                    <td align="right">---</td>
                                                </tr>
                                                <tr>
                                                    <td lang="en">Computed Original</td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedEasting))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedEastingDifference))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedNorthing))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedNorthingDifference))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedElevation))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@endPointComputedElevationDifference))"/>
                                                    </td>
                                                </tr>
                                                <xsl:if test="//@reciprocalZenith = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Reciprocal</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedEasting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedEastingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedNorthing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedNorthingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedElevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalEndPointComputedElevationDifference))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@horizontalZenith = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Horizontal</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedEasting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedEastingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedNorthing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedNorthingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedElevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalEndPointComputedElevationDifference))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@traverseAdjustment = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Traverse</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedEasting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedEastingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedNorthing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedNorthingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedElevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseEndPointComputedElevationDifference))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@elevationAdjustment = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Elevation</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedEasting))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedEastingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedNorthing))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedNorthingDifference))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedElevation))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationEndPointComputedElevationDifference))"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr><td colspan="7">&#xa0;</td></tr>
                                                <!-- Horizontal/Vertical Error -->
                                                <tr>
                                                    <th align="left" colspan="7" lang="en" nowrap="nowrap">Horizontal / Vertical Error:</th>
                                                </tr>
                                                <tr>
                                                    <th class="underline">&#xa0;</th>
                                                    <th class="underline" lang="en">Horizontal<br/>Error</th>
                                                    <th class="underline" lang="en">Vertical<br/>Error</th>
                                                    <th colspan="4">&#xa0;</th>
                                                </tr>
                                                <tr style="line-height:20%"><td colspan="7">&#xa0;</td></tr>
                                                <tr>
                                                    <td lang="en" nowrap="nowrap">Computed Original</td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:distanceFormat(number(@computedHorizontalError))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(@computedVerticalError))"/>
                                                    </td>
                                                    <td colspan="4">&#xa0;</td>
                                                </tr>
                                                <xsl:if test="//@reciprocalZenith = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Reciprocal</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@reciprocalHorizontalError))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@reciprocalVerticalError))"/>
                                                        </td>
                                                        <td colspan="4">&#xa0;</td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@horizontalZenith = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Horizontal</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@horizontalHorizontalError))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@horizontalVerticalError))"/>
                                                        </td>
                                                        <td colspan="4">&#xa0;</td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@traverseAdjustment = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Traverse</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@traverseHorizontalError))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@traverseVerticalError))"/>
                                                        </td>
                                                        <td colspan="4">&#xa0;</td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="//@elevationAdjustment = 'true'">
                                                    <tr>
                                                        <td lang="en" nowrap="nowrap">Computed Elevation</td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:distanceFormat(number(@elevationHorizontalError))"/>
                                                        </td>
                                                        <td align="right">
                                                            <xsl:value-of select="cif:ordinateFormat(number(@elevationVerticalError))"/>
                                                        </td>
                                                        <td colspan="4">&#xa0;</td>
                                                    </tr>
                                                </xsl:if>
                                                <tr><td colspan="7">&#xa0;</td></tr>
                                            </tbody>
                                        </table>
                                        <table class="margin" cellpadding="2" cellspacing="0" width="70%">
                                            <colgroup span="2">
                                                <col width="50%"/>
                                                <col width="50%"/>
                                            </colgroup>
                                            <tbody>
                                                <!-- Horizontal/Vertical Accuracy -->
                                                <tr>
                                                    <th align="left" lang="en">Horizontal Accuracy (Original): </th>
                                                    <td>1 : <xsl:value-of select="cif:distanceFormat(number(@computedHorizontalAccuracy))"/></td>
                                                </tr>
                                    					<tr>
                                                    <th align="left" lang="en" nowrap="nowrap">Horizontal Accuracy (with Angular): </th>
                                                    <td>1 : <xsl:value-of select="cif:distanceFormat(number(@horizontalHorizontalAccuracy))"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Vertical Accuracy (Original): </th>
                                                    <td>1 : <xsl:value-of select="cif:distanceFormat(number(@computedVerticalAccuracy))"/></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <br/>
                                        <hr size="1px"/>
                                        <!-- Observation Data -->
                                        <center><h4 lang="en">Observations</h4></center>
                                        <hr size="1px"/>
                                        <table class="margin" cellpadding="1" cellspacing="1" width="70%">
                                            <colgroup span="2">
                                                <col width="50%"/>
                                                <col width="50%"/>
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th align="left" lang="en">Azimuths:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberAzimuthObservations"/>
                                                        <xsl:if test="@numberAzimuthObservationsIgnored!='0'"> (<xsl:value-of select="@numberAzimuthObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Direction:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberDirectionObservations"/>
                                                        <xsl:if test="@numberDirectionObservationsIgnored!='0'"> (<xsl:value-of select="@numberDirectionObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Horizontal Angles:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberHorizontalAngleObservations"/>
                                                        <xsl:if test="@numberHorizontalAngleObservationsIgnored!='0'"> (<xsl:value-of select="@numberHorizontalAngleObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <th align="left" lang="en" nowrap="nowrap">Horizontal Distances:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberHorizontalDistanceObservations"/>
                                                        <xsl:if test="@numberHorizontalDistanceObservationsIgnored!='0'"> (<xsl:value-of select="@numberHorizontalDistanceObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Slope Distances:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberSlopeDistanceObservations"/>
                                                        <xsl:if test="@numberSlopeDistanceObservationsIgnored!='0'"> (<xsl:value-of select="@numberSlopeDistanceObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <th align="left" lang="en">Vertical Angles:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberVerticalAngleObservations"/>
                                                        <xsl:if test="@numberVerticalAngleObservationsIgnored!='0'"> (<xsl:value-of select="@numberVerticalAngleObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="left" lang="en">Zenith Angles:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberZenithAngleObservations"/>
                                                        <xsl:if test="@numberZenithAngleObservationsIgnored!='0'"> (<xsl:value-of select="@numberZenithAngleObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <th align="left" lang="en">Height Differences:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@numberHeightDifferenceObservations"/>
                                                        <xsl:if test="@numberHeightDifferenceObservationsIgnored!='0'"> (<xsl:value-of select="@numberHeightDifferenceObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                <tr>
                                                    <th align="left" lang="en">Total:&#xa0;</th>
                                                    <td>
                                                        <xsl:value-of select="@totalNumberObservations"/>
                                                        <xsl:if test="@totalNumberObservationsIgnored!='0'"> (<xsl:value-of select="@totalNumberObservationsIgnored"/>)</xsl:if>
                                                    </td>
                                                </tr>
                                                <tr><td>&#xa0;</td></tr>
                                            </tbody>
                                        </table>
                                        <hr size="1px"/>
                                        <!-- Observation Points -->
                                        <table cellpadding="1" cellspacing="2" width="100%">
                                            <colgroup span="8">
                                                <col width="14%"/>
                                                <col width="12%"/>
                                                <col width="12%"/>
                                                <col width="12%"/>
                                                <col width="12%"/>
                                                <col width="13%"/>
                                                <col width="13%"/>
                                                <col width="12%"/>
                                            </colgroup>
                                            <thead style="display:table-header-group">
                                                <tr>
                                                    <th class="underline" lang="en">Type</th>
                                                    <th class="underline" lang="en">Backsight</th>
                                                    <th class="underline" lang="en">Occupied</th>
                                                    <th class="underline" lang="en">Foresight</th>
                                                    <th class="underline" lang="en">Observation</th>
                                                    <th class="underline">&#xa0;</th>
                                                    <th class="underline" lang="en">Observation</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                </tr>
                                                <tr style="line-height:20%"><td colspan="8">&#xa0;</td></tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="Observations/Observation">
                                                    <tr valign="top">
                                                        <td align="center"><xsl:value-of select="@type"/></td>
                                                        <th><xsl:value-of select="@backsightPointName"/></th>
                                                        <th><xsl:value-of select="@occupiedPointName"/></th>
                                                        <th><xsl:value-of select="@foresightPointName"/></th>
                                                        <xsl:choose>
                                                            <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:angularFormat(number(@averageObservedValue))"/>
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@averageObservedValue))"/>
                                                                </td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:if test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true' or //@traverseAdjustment = 'true' or //@elevationAdjustment = 'true'">
                                                            <xsl:if test="//@reciprocalZenith = 'true'">
                                                                <td class="sidepad" lang="en">Reciprocal</td>
                                                                <xsl:choose>
                                                                    <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                        <td align="right" nowrap="nowrap">
                                                                            <xsl:value-of select="cif:angularFormat(number(@averageReciprocalZenith))"/>
                                                                        </td>
                                                                        <td align="right" nowrap="nowrap">
                                                                            <xsl:value-of select="cif:angularFormat(number(@differenceAverageReciprocalZenith))"/>
                                                                        </td>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <td align="right">
                                                                            <xsl:value-of select="cif:distanceFormat(number(@averageReciprocalZenith))"/>
                                                                        </td>
                                                                        <td align="right">
                                                                            <xsl:value-of select="cif:distanceFormat(number(@differenceAverageReciprocalZenith))"/>
                                                                        </td>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                            <td colspan="3">
                                                                <table width="100%">
                                                                    <xsl:if test="//@horizontalZenith = 'true'">
                                                                        <tr>
                                                                            <td class="sidepad" lang="en">Horizontal</td>
                                                                            <xsl:choose>
                                                                                <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@averageHorizontalZenith))"/>
                                                                                    </td>
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@differenceAverageHorizontalValue))"/>
                                                                                    </td>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@averageHorizontalZenith))"/>
                                                                                    </td>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@differenceAverageHorizontalValue))"/>
                                                                                    </td>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="//@traverseAdjustment = 'true'">
                                                                        <tr>
                                                                            <td class="sidepad"><xsl:value-of select="//@adjustmentType"/></td>
                                                                            <xsl:choose>
                                                                                <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@averageAdjustedValue))"/>
                                                                                    </td>
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@differenceAverageAdjustedValue))"/>
                                                                                    </td>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@averageAdjustedValue))"/>
                                                                                    </td>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@differenceAverageAdjustedValue))"/>
                                                                                    </td>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="//@elevationAdjustment = 'true'">
                                                                        <tr>
                                                                            <td class="sidepad" lang="en">Elevation</td>
                                                                            <xsl:choose>
                                                                                <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@averageElevationValue))"/>
                                                                                    </td>
                                                                                    <td align="right" nowrap="nowrap">
                                                                                        <xsl:value-of select="cif:angularFormat(number(@differenceAverageElevationValue))"/>
                                                                                    </td>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@averageElevationValue))"/>
                                                                                    </td>
                                                                                    <td align="right">
                                                                                        <xsl:value-of select="cif:distanceFormat(number(@differenceAverageElevationValue))"/>
                                                                                    </td>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </tr>
                                                                    </xsl:if>
                                                                </table>
                                                            </td>
                                                        </xsl:if>
                                                    </tr>
                                                    <xsl:for-each select="ObservationData">
                                                        <tr>
                                                            <th>&#xa0;</th>
                                                            <td align="right">
                                                                <xsl:choose>
                                                                    <xsl:when test="@type = 'Horizontal Distance'">
                                                                        <xsl:value-of select="cif:distanceFormat(number(@backsightHeight))"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>&#xa0;</xsl:otherwise>
                                                                </xsl:choose>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:distanceFormat(number(@instrumentHeight))"/>
                                                            </td>
                                                            <td align="right">
                                                                <xsl:value-of select="cif:distanceFormat(number(@foresightHeight))"/>
                                                            </td>
                                                            <td align="right" nowrap="nowrap">
                                                                <xsl:choose>
                                                                    <xsl:when test="@type != 'Slope Distance' and @type != 'Horizontal Distance' and @type != 'Height Difference'">
                                                                        <xsl:value-of select="cif:angularFormat(number(@observedValue))"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="cif:distanceFormat(number(@observedValue))"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                    <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                </xsl:for-each>
                                                <tr><td>&#xa0;</td></tr>
                                            </tbody>
                                        </table>
                                        <hr size="1px"/>
                                        <!-- Reciprocal Zenith Data -->
                                        <xsl:if test="//@reciprocalZenith = 'true'">
                                            <center><h4 lang="en">Reciprocal Zenith</h4></center>
                                            <hr size="1px"/>
                                            <table class="margin" cellpadding="1" cellspacing="2" width="85%">
                                                <thead style="display:table-header-group">
                                                    <tr>
                                                        <th class="underline" valign="bottom">&#xa0;</th>
                                                        <th class="underline" lang="en" valign="bottom">Occupied</th>
                                                        <th class="underline" lang="en" valign="bottom">Observed</th>
                                                        <th class="underline" lang="en" valign="bottom">Slope<br/>Distance</th>
                                                        <th class="underline" lang="en" valign="bottom">Zenith Angle</th>
                                                        <th class="underline" lang="en" valign="bottom">Delta Z</th>
                                                    </tr>
                                                    <tr style="line-height:20%"><th>&#xa0;</th></tr>
                                                </thead>
                                                <tbody>
                                                    <xsl:for-each select="ReciprocalZeniths/ReciprocalZenith">
                                                        <xsl:if test="@isForward = 'true'">
                                                            <tr>
                                                                <td lang="en">Forward</td>
                                                                <th><xsl:value-of select="@reciprocalOccupiedPointName"/></th>
                                                                <th><xsl:value-of select="@reciprocalForesightPointName"/></th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@forwardSlopeDistance))"/>
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:angularFormat(number(@forwardZenithAngle))"/>
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@forwardDeltaZ))"/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td lang="en" nowrap="nowrap">Reciprocal</td>
                                                                <th><xsl:value-of select="@reciprocalOccupiedPointName"/></th>
                                                                <th><xsl:value-of select="@reciprocalForesightPointName"/></th>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@reciprocalSlopeDistance))"/>
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:angularFormat(number(@reciprocalZenithAngle))"/>
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@reciprocalDeltaZ))"/>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                        <xsl:if test="@isReverse = 'true'">
                                                            <tr>
                                                                <td nowrap="nowrap">Reverse</td>
                                                                <td align="center" nowrap="nowrap" style="font-weight:bold">
                                                                    <xsl:value-of select="@reciprocalForesightPointName"/>
                                                                </td>
                                                                <td align="center" nowrap="nowrap" style="font-weight:bold">
                                                                    <xsl:value-of select="@reciprocalOccupiedPointName"/>
                                                                </td>
                                                                <td align="center" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@reverseSlopeDistance))"/>
                                                                </td>
                                                                <td align="center" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:angularFormat(number(@reverseZenithAngle))"/>
                                                                </td>
                                                                <td align="center" nowrap="nowrap">
                                                                    <xsl:value-of select="cif:distanceFormat(number(@reverseDeltaZ))"/>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                        <tr style="line-height:50%"><td>&#xa0;</td></tr>
                                                    </xsl:for-each>
                                                    <tr><td>&#xa0;</td></tr>
                                                </tbody>
                                            </table>
                                            <hr size="1px"/>
                                        </xsl:if>
                                        <!-- Point Data -->
                                        <center><h4 lang="en">Points</h4></center>
                                        <hr size="1px"/>
                                        <table class="margin" cellpadding="1" cellspacing="2" width="90%">
                                            <colgroup span="7">
                                                <col width="10%"/>
                                                <col width="15%"/>
                                                <col width="15%"/>
                                                <col width="15%"/>
                                                <col width="15%"/>
                                                <col width="15%"/>
                                                <col width="15%"/>
                                            </colgroup>
                                            <thead style="display:table-header-group">
                                                <tr>
                                                    <th class="underline">&#xa0;</th>
                                                    <th class="underline" lang="en">X</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                    <th class="underline" lang="en">Y</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                    <th class="underline" lang="en">Elevation</th>
                                                    <th class="underline" lang="en">Difference</th>
                                                </tr>
                                                <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="Route/RoutePoint">
                                                    <xsl:if test="position() = 1">
                                                        <tr>
                                                            <xsl:call-template name="displayPointName">
                                                                <xsl:with-param name="name" select="@backsightPointName"/>
                                                                <xsl:with-param name="type" select="@backsightType"/>
                                                            </xsl:call-template>
                                                        </tr>
                                                        <xsl:call-template name="displayPointsBacksight"/>
                                                        <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                                    </xsl:if>
                                                    <tr>
                                                        <xsl:call-template name="displayPointName">
                                                            <xsl:with-param name="name" select="@occupiedPointName"/>
                                                            <xsl:with-param name="type" select="@type"/>
                                                        </xsl:call-template>
                                                    </tr>
                                                    <xsl:call-template name="displayPoints">
                                                        <xsl:with-param name="traverseAdjustment" select="//@traverseAdjustment"/>
                                                        <xsl:with-param name="horizontalZenith" select="//@horizontalZenith"/>
                                                        <xsl:with-param name="reciprocalZenith" select="//@reciprocalZenith"/>
                                                    </xsl:call-template>
                                                    <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                                    <xsl:if test="position() = last()">
                                                        <tr>
                                                            <xsl:call-template name="displayPointName">
                                                                <xsl:with-param name="name" select="@foresightPointName"/>
                                                                <xsl:with-param name="type" select="@foresightType"/>
                                                            </xsl:call-template>
                                                        </tr>
                                                        <xsl:call-template name="displayPointsForesight"/>
                                                    </xsl:if>
                                                    <tr style="line-height:20%"><td>&#xa0;</td></tr>
                                                </xsl:for-each>
                                                <tr><td>&#xa0;</td></tr>
                                            </tbody>
                                        </table>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <p lang="en">
                                            The active network is not a single route traverse.&#xa0; Please 
                                            use another report.
                                        </p>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <!--Start Templates-->
    <xsl:template name="displayTraverse">
        <xsl:param name="traverseAdjustment"/>
        <xsl:param name="horizontalZenith"/>
        <xsl:param name="reciprocalZenith"/>
        <xsl:variable name="red" select="'FF0000'"/>
        <!-- Traverse Row 1 -->
        <tr>
            <xsl:call-template name="displayPointName">
                <xsl:with-param name="name" select="@occupiedPointName"/>
                <xsl:with-param name="type" select="@type"/>
                <xsl:with-param name="style" select="'border-left-width:2px'"/>
            </xsl:call-template>
            <xsl:call-template name="fourBlankColumns"/>
            <!-- Display Unadjusted Coordinates -->
            <xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedEasting"/>
                <xsl:with-param name="displayType" select="'easting'"/>
            </xsl:call-template>
            <xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedNorthing"/>
                <xsl:with-param name="displayType" select="'northing'"/>
            </xsl:call-template>
            <xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedElevation"/>
                <xsl:with-param name="displayType" select="'elevation'"/>
                <xsl:with-param name="style" select="'border-right-width:2px'"/>
            </xsl:call-template>
        </tr>
        <!-- Traverse Row 2 -->
        <tr>
            <td style="border-left-width:2px">&#xa0;</td>
            <xsl:choose>
                <xsl:when test="@mode = 'BothFixed'">
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@unadjustedAzimuth"/>
                        <xsl:with-param name="displayType" select="'angular'"/>
                    </xsl:call-template>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@unadjustedAzimuth"/>
                        <xsl:with-param name="displayType" select="'angular'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@unadjustedLength"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@unadjustedLatitude"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@unadjustedDeparture"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <!-- Display Elevation Corrected Coordinates -->
                <xsl:when test="//@elevationAdjustment = 'true' and @type != 'Fixed'">
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@elevationCorrectionEasting"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@elevationCorrectionNorthing"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@elevationCorrectionElevation"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="'border-right-width:2px'"/>
                    </xsl:call-template>
                </xsl:when>
                <!-- Display Traverse Corrected Coordinates -->
                <xsl:when test="//@traverseAdjustment = 'true' and @type != 'Fixed'">
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@traverseCorrectionEasting"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@traverseCorrectionNorthing"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@traverseCorrectionElevation"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="'border-right-width:2px'"/>
                    </xsl:call-template>
                </xsl:when>
                <!-- Display Horizontal Corrected Coordinates -->
                <xsl:when test="//@horizontalZenith = 'true' and @type != 'Fixed'">
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@horizontalCorrectionEasting"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@horizontalCorrectionNorthing"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@horizontalCorrectionElevation"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="'border-right-width:2px'"/>
                    </xsl:call-template>
                </xsl:when>
                <!-- Display reciprocal Corrected Coordinates -->
                <xsl:when test="//@reciprocalZenith = 'true' and @type != 'Fixed'">
                     <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@reciprocalCorrectionEasting"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                    </xsl:call-template>
					<xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@reciprocalCorrectionNorthing"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                    </xsl:call-template>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@reciprocalCorrectionElevation"/>
                        <xsl:with-param name="color" select="$red"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="'border-right-width:2px'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="threeBlankColumns"/>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
        <!-- Traverse Row 3 -->
        <xsl:if test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true' or //@traverseAdjustment = 'true' or //@elevationAdjustment = 'true'">
            <xsl:choose>
                <xsl:when test="@mode = 'BothFixed'"/>
                <xsl:otherwise>
                    <tr>
                        <xsl:choose>
                            <xsl:when test="//@elevationAdjustment = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <xsl:choose>
                                    <xsl:when test="//@horizontalZenith = 'true'">
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@horizontalCorrectedAzimuth"/>
                                            <xsl:with-param name="color" select="$red"/>
                                            <xsl:with-param name="displayType" select="'angular'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>&#xa0;</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationCorrectedLength"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationCorrectedLatitude"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationCorrectedDeparture"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="//@traverseAdjustment = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <xsl:choose>
                                    <xsl:when test="//@horizontalZenith = 'true'">
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@horizontalCorrectedAzimuth"/>
                                            <xsl:with-param name="color" select="$red"/>
                                            <xsl:with-param name="displayType" select="'angular'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>&#xa0;</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseCorrectedLength"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseCorrectedLatitude"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseCorrectedDeparture"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="//@horizontalZenith = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalCorrectedAzimuth"/>
                                    <xsl:with-param name="color" select="$red"/>
                                    <xsl:with-param name="displayType" select="'angular'"/>
                                </xsl:call-template>
                                <xsl:choose>
                                    <xsl:when test="//@traverseAdjustment = 'true'">
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@traverseCorrectedLength"/>
                                            <xsl:with-param name="color" select="$red"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>&#xa0;</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalCorrectedLatitude"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalCorrectedDeparture"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="//@reciprocalZenith = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <td>&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalCorrectedLength"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalCorrectedLatitude"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalCorrectedDeparture"/>
                                    <xsl:with-param name="color" select="$red"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:choose>
                            <!-- Display Elevation Difference Coordinates -->
                            <xsl:when test="//@elevationAdjustment = 'true'">
                                <xsl:choose>
                                    <xsl:when test="@type != 'Fixed'">
                                         <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@elevationDifferenceEasting"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'easting'"/>
                                        </xsl:call-template>
										<xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@elevationDifferenceNorthing"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'northing'"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@elevationDifferenceElevation"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'elevation'"/>
                                            <xsl:with-param name="style" select="'border-right-width:2px'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="threeBlankColumns"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <!-- Display Traverse Difference Coordinates -->
                            <xsl:when test="//@traverseAdjustment='true'">
                                <xsl:choose>
                                    <xsl:when test="@type != 'Fixed'">
                                         <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@traverseDifferenceEasting"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'easting'"/>
                                        </xsl:call-template>
										<xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@traverseDifferenceNorthing"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'northing'"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@traverseDifferenceElevation"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'elevation'"/>
                                            <xsl:with-param name="style" select="'border-right-width:2px'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="threeBlankColumns"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <!-- Display Horizontal Difference Coordinates -->
                            <xsl:when test="//@horizontalZenith = 'true'">
                                <xsl:choose>
                                    <xsl:when test="@type != 'Fixed'">
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@horizontalDifferenceEasting"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'easting'"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@horizontalDifferenceNorthing"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'northing'"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@horizontalDifferenceElevation"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'elevation'"/>
                                            <xsl:with-param name="style" select="'border-right-width:2px'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="threeBlankColumns"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <!-- Display reciprocal Difference Coordinates -->
                            <xsl:when test="//@reciprocalZenith = 'true'">
                                <xsl:choose>
                                    <xsl:when test="@type != 'Fixed'">
                                         <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@reciprocalDifferenceEasting"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'easting'"/>
                                        </xsl:call-template>
										<xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@reciprocalDifferenceNorthing"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'northing'"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="displayColumn">
                                            <xsl:with-param name="value" select="@reciprocalDifferenceElevation"/>
                                            <xsl:with-param name="error" select="'true'"/>
                                            <xsl:with-param name="displayType" select="'elevation'"/>
                                            <xsl:with-param name="style" select="'border-right-width:2px'"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="threeBlankColumns"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                        </xsl:choose>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Traverse Row 4 -->
            <xsl:choose>
                <xsl:when test="@mode = 'BothFixed'"/>
                <xsl:otherwise>
                    <tr>
                        <xsl:choose>
                            <xsl:when test="//@elevationAdjustment = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <td>&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationDifferenceLength"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationDifferenceLatitude"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@elevationDifferenceDeparture"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="threeBlankColumns"/>
                            </xsl:when>
                            <xsl:when test="//@traverseAdjustment = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <td>&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseDifferenceLength"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseDifferenceLatitude"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@traverseDifferenceDeparture"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="threeBlankColumns"/>
                            </xsl:when>
                            <xsl:when test="//@horizontalZenith = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalDifferenceAzimuth"/>
                                    <xsl:with-param name="displayType" select="'angular'"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <td>&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalDifferenceLatitude"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@horizontalDifferenceDeparture"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="threeBlankColumns"/>
                            </xsl:when>
                            <xsl:when test="//@reciprocalZenith = 'true'">
                                <td style="border-left-width:2px">&#xa0;</td>
                                <td>&#xa0;</td>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalDifferenceLength"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalDifferenceLatitude"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="displayColumn">
                                    <xsl:with-param name="value" select="@reciprocalDifferenceDeparture"/>
                                    <xsl:with-param name="error" select="'true'"/>
                                </xsl:call-template>
                                <xsl:call-template name="threeBlankColumns"/>
                            </xsl:when>
                        </xsl:choose>
                    </tr>
                    <tr/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="displayTraverseTotal">
        <xsl:param name="traverseAdjustment"/>
        <xsl:param name="horizontalZenith"/>
        <xsl:param name="reciprocalZenith"/>
        <!-- Traverse Total Row 1 -->
        <tr>
            <td/>
            <td align="center" style="border-left-width:2px;border-bottom-width:2px">Total</td>
            <td align="center">
                <xsl:value-of select="cif:distanceFormat(number(//@totalTraverseLength))"/>
            </td>
            <td align="center">
                <xsl:value-of select="cif:distanceFormat(number(//@totalLatitudeLength))"/>
            </td>
            <td align="center" style="border-right-width:2px">
                <xsl:value-of select="cif:distanceFormat(number(//@totalDepartureLength))"/>
            </td>
            <td/>
            <td/>
            <td/>
        </tr>
        <!-- Traverse Total Row 2 -->
        <xsl:if test="//@horizontalZenith = 'true' or //@traverseAdjustment = 'true' or //@reciprocalZenith = 'true' or //@elevationAdjustment = 'true'">
            <tr>
                <td/>
                <td/>
                <xsl:choose>
                    <xsl:when test="//@elevationAdjustment = 'true'">
                        <td align="center" style="border-left-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@elevationAdjustmentTotalTraverseLength))"/>
                        </td>
                        <td align="center" style="color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@elevationAdjustmentTotalLatitudeLength))"/>
                        </td>
                        <td align="center" style="border-right-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@elevationAdjustmentTotalDepartureLength))"/>
                        </td>
                    </xsl:when>
                    <xsl:when test="//@traverseAdjustment = 'true'">
                        <td align="center" style="border-left-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@traverseAdjustmentTotalTraverseLength))"/>
                        </td>
                        <td align="center" style="color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@traverseAdjustmentTotalLatitudeLength))"/>
                        </td>
                        <td align="center" style="border-right-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@traverseAdjustmentTotalDepartureLength))"/>
                        </td>
                    </xsl:when>
                    <xsl:when test="//@horizontalZenith = 'true'">
                        <td/>
                        <td align="center" style="border-left-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@horizontalTotalLatitudeLength))"/>
                        </td>
                        <td align="center" style="border-right-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@horizontalTotalDepartureLength))"/>
                        </td>
                    </xsl:when>
                    <xsl:when test="//@reciprocalZenith = 'true'">
                        <td align="center" style="border-left-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalTraverseLength))"/>
                        </td>
                        <td align="center" style="color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalLatitudeLength))"/>
                        </td>
                        <td align="center" style="border-right-width:2px;color:#FF0000">
                            <xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalDepartureLength))"/>
                        </td>
                    </xsl:when>
                </xsl:choose>
                <td/>
                <td/>
                <td/>
            </tr>
        </xsl:if>
        <!-- Traverse Total Row 3 -->
        <xsl:if test="//@reciprocalZenith = 'true' or //@horizontalZenith = 'true' or //@traverseAdjustment = 'true'">
            <tr>
                <td/>
                <td/>
                <xsl:choose>
                    <xsl:when test="//@elevationAdjustment = 'true'">
                        <td align="center" style="border-bottom-width:2px;border-left-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@elevationTotalTraverseLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@elevationTotalLatitudeLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-right-width:2px;border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@elevationTotalDepartureLengthDifference))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="//@traverseAdjustment = 'true'">
                        <td align="center" style="border-bottom-width:2px;border-left-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@traverseTotalTraverseLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@traverseTotalLatitudeLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-right-width:2px;border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@traverseTotalDepartureLengthDifference))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="//@horizontalZenith = 'true'">
                        <td/>
                        <td align="center" style="border-bottom-width:2px;border-left-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@horizontalTotalLatitudeLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-right-width:2px;border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@horizontalTotalDepartureLengthDifference))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="//@reciprocalZenith = 'true'">
                        <td align="center" style="border-bottom-width:2px;border-left-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalTraverseLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalLatitudeLengthDifference))"/>]
                        </td>
                        <td align="center" style="border-right-width:2px;border-bottom-width:2px;white-space:nowrap">
                            [<xsl:value-of select="cif:distanceFormat(number(//@reciprocalTotalDepartureLengthDifference))"/>]
                        </td>
                    </xsl:when>
                </xsl:choose>
                <td/>
                <td/>
                <td/>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template name="displayBacksight">
        <xsl:if test="position() = 1">
            <tr>
                <xsl:call-template name="displayPointName">
                    <xsl:with-param name="name" select="@backsightPointName"/>
                    <xsl:with-param name="type" select="@backsightType"/>
                    <xsl:with-param name="style" select="'border-left-width:2px'"/>
                </xsl:call-template>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <xsl:choose>
                    <xsl:when test="@backsightType = 'AZ'">
                        <xsl:call-template name="threeBlankColumns"/>
                    </xsl:when>
                    <xsl:otherwise>
                         <td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(@backsightEasting))"/>
                        </td>
						<td align="right">
                            <xsl:value-of select="cif:ordinateFormat(number(@backsightNorthing))"/>
                        </td>
                        <td align="right" style="border-right-width:2px">
                            <xsl:value-of select="cif:ordinateFormat(number(@backsightElevation))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
            <tr>
                <td style="border-left-width:2px">&#xa0;</td>
                <td align="right" nowrap="nowrap">
                    <xsl:value-of select="cif:angularFormat(number(//@beginningAzimuth))"/>
                </td>
                <td align="right"><xsl:value-of select="@backsightLength"/></td>
                <td align="right"><xsl:value-of select="@backsightLatitude"/></td>
                <td align="right"><xsl:value-of select="@backsightDeparture"/></td>
                <td>&#xa0;</td>
                <td>&#xa0;</td>
                <td style="border-right-width:2px">&#xa0;</td>
            </tr>
            <tr/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="displayForesight">
        <xsl:if test="position() = last()">
            <tr>
                <xsl:call-template name="displayPointName">
                    <xsl:with-param name="name" select="@foresightPointName"/>
                    <xsl:with-param name="type" select="@foresightType"/>
                    <xsl:with-param name="style" select="'border-bottom-width:2px;border-left-width:2px'"/>
                </xsl:call-template>
                <td align="right">&#xa0;</td>
                <td align="right">---</td>
                <td align="right">---</td>
                <td align="right">---</td>
                <xsl:choose>
                    <xsl:when test="@foresightType='AZ'">
                        <xsl:call-template name="threeBlankColumns"/>
                    </xsl:when>
                    <xsl:otherwise>
                         <td align="right" style="border-bottom-width:2px">
                            <xsl:value-of select="cif:ordinateFormat(number(@foresightEasting))"/>
                        </td>
						<td align="right" style="border-bottom-width:2px">
                            <xsl:value-of select="cif:ordinateFormat(number(@foresightNorthing))"/>
                        </td>
                        <td align="right" style="border-right-width:2px;border-bottom-width:2px">
                            <xsl:value-of select="cif:ordinateFormat(number(@foresightElevation))"/>
                        </td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template name="displayPointName">
        <xsl:param name="name"/>
        <xsl:param name="type" select="'Fixed'"/>
        <xsl:param name="style" select="''"/>
        <th align="left" nowrap="nowrap" style="{$style}">
            <xsl:choose>
                <xsl:when test="$type='Fixed'">
                    <img src="{$xslRootDirectory}/Images/SrvFixed.png" alt="Fixed"/>&#xa0;
                </xsl:when>
                <xsl:when test="$type='Free'">
                    <img src="{$xslRootDirectory}/Images/SrvFree.png" alt="Free"/>&#xa0;
                </xsl:when>
                <xsl:otherwise>
                    <img src="{$xslRootDirectory}/Images/SrvAzimuth.png" alt="Azimuth"/>&#xa0;
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="$name"/>
        </th>
    </xsl:template>
    <xsl:template name="displayColumn">
        <xsl:param name="value"/>
        <xsl:param name="color" select="'000000'"/>
        <xsl:param name="displayType" select="'distance'"/>
        <xsl:param name="error" select="'false'"/>
        <xsl:param name="style" select="''"/>
        <xsl:choose>
            <xsl:when test="$error = 'false'">
                <xsl:choose>
                    <xsl:when test="$displayType='angular'">
                        <td align="right" nowrap="nowrap" style="color:{$color};{$style}">
                            &#xa0;<xsl:value-of select="cif:angularFormat(number($value))"/>
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='distance'">
                        <td align="right" style="color:{$color};{$style}">
                            &#xa0;<xsl:value-of select="cif:distanceFormat(number($value))"/>
                        </td>
                    </xsl:when>
                     <xsl:when test="$displayType='easting'">
                        <td align="right" style="color:{$color};{$style}">
                            &#xa0;<xsl:value-of select="cif:ordinateFormat(number($value))"/>
                        </td>
                    </xsl:when>
					<xsl:when test="$displayType='northing'">
                        <td align="right" style="color:{$color};{$style}">
                            &#xa0;<xsl:value-of select="cif:ordinateFormat(number($value))"/>
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='elevation'">
                        <td align="right" style="color:{$color};{$style}">
                            &#xa0;<xsl:value-of select="cif:ordinateFormat(number($value))"/>
                        </td>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$displayType='angular'">
                        <td align="right" nowrap="nowrap" style="{$style}">
                            [<xsl:value-of select="cif:angularFormat(number($value))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='distance'">
                        <td align="right" style="{$style}">
                            [<xsl:value-of select="cif:distanceFormat(number($value))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='easting'">
                        <td align="right" style="{$style}">
                            [<xsl:value-of select="cif:ordinateFormat(number($value))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='northing'">
                        <td align="right" style="{$style}">
                            [<xsl:value-of select="cif:ordinateFormat(number($value))"/>]
                        </td>
                    </xsl:when>
                    <xsl:when test="$displayType='elevation'">
                        <td align="right" style="{$style}">
                            [<xsl:value-of select="cif:ordinateFormat(number($value))"/>]
                        </td>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="fourBlankColumns">
        <td>&#xa0;</td>
        <td>&#xa0;</td>
        <td>&#xa0;</td>
        <td>&#xa0;</td>
    </xsl:template>
    <xsl:template name="threeBlankColumns">
        <td>&#xa0;</td>
        <td>&#xa0;</td>
        <td style="border-right-width:2px">&#xa0;</td>
    </xsl:template>
    <xsl:template name="displayPointsBacksight">
        <xsl:variable name="style"/>
        <tr>
            <td align="left" lang="en" nowrap="nowrap" style="border-left-width:2px">Original</td>
            <xsl:choose>
                <xsl:when test="//@backsightType = 'AZ'">
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right" style="border-right-width:2px;$style">---</td>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@backsightEasting"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right">---</td>
					<xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@backsightNorthing"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right">---</td>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@backsightElevation"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right" style="border-right-width:2px;$style">---</td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
        <tr/>
    </xsl:template>
    <xsl:template name="displayPointsForesight">
        <xsl:variable name="style"/>
        <tr>
            <td align="left" nowrap="nowrap" style="border-left-width:2px">Original</td>
            <xsl:choose>
                <xsl:when test="//@foresightType='AZ'">
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right">---</td>
                    <td align="right" style="border-right-width:2px;$style">---</td>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@foresightEasting"/>
                        <xsl:with-param name="displayType" select="'easting'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right">---</td>
					<xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@foresightNorthing"/>
                        <xsl:with-param name="displayType" select="'northing'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right">---</td>
                    <xsl:call-template name="displayColumn">
                        <xsl:with-param name="value" select="@foresightElevation"/>
                        <xsl:with-param name="displayType" select="'elevation'"/>
                        <xsl:with-param name="style" select="$style"/>
                    </xsl:call-template>
                    <td align="right" style="border-right-width:2px;$style">---</td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>
    <xsl:template name="displayPoints">
        <xsl:param name="traverseAdjustment"/>
        <xsl:param name="horizontalZenith"/>
        <xsl:param name="reciprocalZenith"/>
        <xsl:variable name="style1">
            <xsl:if test="position() = last() and //@reciprocalZenith != 'true' and //@horizontalZenith != 'true' and //@traverseAdjustment != 'true'">
                border-bottom-width:2px
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="style2">
            <xsl:if test="position() = last() and //@horizontalZenith != 'true' and //@traverseAdjustment != 'true'">
                border-bottom-width:2px
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="style3">
            <xsl:if test="position() = last() and //@traverseAdjustment != 'true'">
                border-bottom-width:2px
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="style4">
            <xsl:if test="position() = last()">border-bottom-width:2px</xsl:if>
        </xsl:variable>
        <!-- Points Row 1 -->
        <tr>
            <td align="left" lang="en" nowrap="nowrap" style="border-left-width:2px">Original</td>
             <xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedEasting"/>
                <xsl:with-param name="displayType" select="'easting'"/>
                <xsl:with-param name="style" select="$style1"/>
            </xsl:call-template>
            <td align="right">---</td>
			<xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedNorthing"/>
                <xsl:with-param name="displayType" select="'northing'"/>
                <xsl:with-param name="style" select="$style1"/>
            </xsl:call-template>
            <td align="right">---</td>
            <xsl:call-template name="displayColumn">
                <xsl:with-param name="value" select="@unadjustedElevation"/>
                <xsl:with-param name="displayType" select="'elevation'"/>
                <xsl:with-param name="style" select="$style1"/>
            </xsl:call-template>
            <td align="right" style="border-right-width:2px;$style1">---</td>
        </tr>
        <!-- Points Row 2 -->
        <xsl:if test="//@reciprocalZenith = 'true' and @type != 'Fixed'">
            <tr>
                <td align="left" lang="en" nowrap="nowrap" style="border-left-width:2px">Reciprocal</td>
                <xsl:call-template name="displayColumn">
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@reciprocalCorrectionEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style2"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@reciprocalDifferenceEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style2"/>
                </xsl:call-template>
                    <xsl:with-param name="value" select="@reciprocalCorrectionNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style2"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@reciprocalDifferenceNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style2"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@reciprocalCorrectionElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style" select="$style2"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@reciprocalDifferenceElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style">
                        border-right-width:2px;<xsl:value-of select="$style2"/>
                    </xsl:with-param>
                </xsl:call-template>
            </tr>
        </xsl:if>
        <!-- Points Row 3 -->
        <xsl:if test="//@horizontalZenith = 'true' and @type != 'Fixed'">
            <tr>
                <td align="left" lang="en" nowrap="nowrap" style="border-left-width:2px">Horizontal</td>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalCorrectionEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style3"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalDifferenceEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style3"/>
                </xsl:call-template>
                 <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalCorrectionNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style3"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalDifferenceNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style3"/>
                </xsl:call-template>
				<xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalCorrectionElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style" select="$style3"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@horizontalDifferenceElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style">
                        border-right-width:2px;<xsl:value-of select="$style3"/>
                    </xsl:with-param>
                </xsl:call-template>
            </tr>
        </xsl:if>
        <!-- Points Row 4 -->
        <xsl:if test="//@traverseAdjustment = 'true' and @type != 'Fixed'">
            <tr>
                <td align="left" nowrap="nowrap" style="border-left-width:2px;border-bottom-width:2px">
                    <xsl:value-of select="//@adjustmentType"/>
                </td>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseCorrectionEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseDifferenceEasting"/>
                    <xsl:with-param name="displayType" select="'easting'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
                 <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseCorrectionNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseDifferenceNorthing"/>
                    <xsl:with-param name="displayType" select="'northing'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
				<xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseCorrectionElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@traverseDifferenceElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style">
                        border-right-width:2px;<xsl:value-of select="$style4"/>
                    </xsl:with-param>
                </xsl:call-template>
            </tr>
        </xsl:if>
        <xsl:if test="//@elevationAdjustment = 'true' and @type != 'Fixed'">
            <tr>
                <td align="left" nowrap="nowrap" style="border-left-width:2px">Elevation</td>
                <td align="right">---</td>
                <td align="right">---</td>
                <td align="right">---</td>
                <td align="right">---</td>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@elevationCorrectionElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style" select="$style4"/>
                </xsl:call-template>
                <xsl:call-template name="displayColumn">
                    <xsl:with-param name="value" select="@elevationDifferenceElevation"/>
                    <xsl:with-param name="displayType" select="'elevation'"/>
                    <xsl:with-param name="style">
                        border-right-width:2px;<xsl:value-of select="$style4"/>
                    </xsl:with-param>
                </xsl:call-template>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
                You must have a survey network and you must also have run the <em>Survey &gt; Network &gt; 
                Traverse Adjustment</em> command to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
