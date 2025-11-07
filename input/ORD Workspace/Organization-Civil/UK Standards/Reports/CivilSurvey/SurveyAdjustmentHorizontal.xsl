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
                                    <h2 lang="en">Least Squares Horizontal Report</h2>
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
                                                            <th class="underline" lang="en" align="right">Easting</th>
                                                            <th class="underline" lang="en" align="right">Northing</th>
                                                            <th class="underline" lang="en" align="right">
                                                                Standard Error<br/>Easting
                                                            </th>
                                                            <th class="underline" lang="en" align="right">
                                                                Standard Error<br/>Northing
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
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
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
                                                            <th class="underline" lang="en" align="right">Easting</th>
                                                            <th class="underline" lang="en" align="right">Northing</th>
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
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                                                </td>
                                                                <td align="right">
                                                                    <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
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
