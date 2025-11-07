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
                                    <h2 lang="en">Least Squares Vertical Report</h2>
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
                                                            <td align="left" nowrap="nowrap">
                                                                <xsl:value-of select="cif:distanceFormat(number(@rmsError))"/>
                                                            </td>
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
                                                            <th align="left" nowrap="nowrap">Vertical DIFFERENCE RESIDUALS&#xa0;</th>
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
