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
                                    <h2 lang="en">Least Squares Preliminary Report</h2>
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
                                <xsl:for-each select="GenFileReport">
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
                                                        <th class="underline" lang="en" align="right">Easting</th>
                                                        <th class="underline" lang="en" align="right">Northing</th>
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
