<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cif="cif" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
  <xsl:param select="cif:xslShowHelp" name="xslShowHelp"/>
  <xsl:param select="cif:xslRootDirectory" name="xslRootDirectory"/>
  <xsl:template match="/">
    <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
        <!-- Title displayed in browser Title Bar -->
        <title lang="en">Survey Tolerance Report</title>
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
                <h2 lang="en">Survey Tolerance Report</h2>
                <p lang="en">
                  Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                  Time:&#xa0; <xsl:value-of select="cif:time()"/>
                </p>
              </center>
              <xsl:for-each select="ToleranceReport">
                <!-- Header -->
                <xsl:for-each select="Header">
                  <table class="margin" cellpadding="2" width="80%">
                    <tbody>
                      <tr>
                        <th align="right"  lang="en">Project:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@name"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Field Book:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@datasetName"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right" lang="en">Units:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@surveyLinearUnits"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Horizontal Tolerance:&#xa0; </th>
                        <!--td align="left" colspan="2"><xsl:value-of select="@horizontalDistanceTolerance"/></td-->
                        <td align="left" colspan="2">
                          <xsl:value-of select="cif:distanceFormat(number(@horizontalDistanceTolerance))"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Elevation Tolerance:&#xa0; </th>
                        <!--td align="left" colspan="2"><xsl:value-of select="@verticalDistanceTolerance"/></td-->
                        <td align="left" colspan="2">
                          <xsl:value-of select="cif:ordinateFormat(number(@verticalDistanceTolerance))"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Is Adjusted:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@isAdjusted"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Use Setup Collimation:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@useCollimation"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Combined Scale Factor Option:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@combinedScaleFactorOption"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Combined Scale Factor Global:&#xa0; </th>
                        <!--td align="left" colspan="2"><xsl:value-of select="@combinedScaleFactorGlobal"/></td-->
                        <td align="left" colspan="2">
                          <xsl:value-of select="cif:formatNumber(number(@combinedScaleFactorGlobal),10)"/>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </xsl:for-each>
                <hr />
                <!-- Summary -->
                <xsl:for-each select="Summary">
                  <left>
                    <h3 lang="en">Summary</h3>
                  </left>
                  <table class="margin" cellpadding="3" width="30%">
                    <tbody>
                      <tr>
                        <th align="right"  lang="en">Total Points:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@pointCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Total Setups:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@setupCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right" lang="en">Total Observations:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@observationCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Setups With Horizontal Collimation:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@setupWithHorizontalCollimationCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Setups With Vertical Collimation:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@setupWithVerticalCollimationCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Setups With Combined Scale Factor Set:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@setupWithScaleFactorCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Check Points:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@checkPointCount"/>
                        </td>
                      </tr>
                      <tr>
                        <th align="right"  lang="en">Check Point Observations:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@checkPointObservationCount"/>
                        </td>
                      </tr>
                      <tr>
                        <xsl:if test="@checkPointHorizontalFailedCount!='0'">
                          <xsl:attribute name="style">color:FF0000</xsl:attribute>
                        </xsl:if>
                        <th align="right"  lang="en">Check Point Horizontal Failed:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@checkPointHorizontalFailedCount"/>
                        </td>
                      </tr>
                      <tr>
                        <xsl:if test="@checkPointVerticalFailedCount!='0'">
                          <xsl:attribute name="style">color:FF0000</xsl:attribute>
                        </xsl:if>
                        <th align="right"  lang="en">Check Point Vertical Failed:&#xa0; </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@checkPointVerticalFailedCount"/>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </xsl:for-each>
                <hr />
                <!-- SetupScaleFactors -->
                <xsl:for-each select="SetupScaleFactors">
                  <left>
                    <h3 lang="en">Setup Scale Factors</h3>
                  </left>
                  <table class="margin" cellpadding="1" width="60%">
                    <tbody>
                      <xsl:for-each select="SetupScaleFactor">
                        <tr>
                          <td align="left" lang="en">
                            Using scale factor of&#xa0;
                          </td>
                          <td align="left">
                            <xsl:value-of select="@combinedScaleFactor"/>
                          </td>
                          <td align="left" lang="en">
                            for setup&#xa0;
                          </td>
                          <td align="left">
                            <xsl:value-of select="@setupName"/>
                          </td>
                          <td align="left" lang="en">
                            because of option&#xa0;
                          </td>
                          <td align="left">
                            <xsl:value-of select="@combinedScaleFactorOption"/>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </xsl:for-each>
                <hr />
                <!-- SetupCollimations -->
                <xsl:for-each select="SetupCollimations">
                  <left>
                    <h3 lang="en">Setup Collimations</h3>
                    <h4 lang="en">
                      Use Setup Collimation:&#xa0; <xsl:value-of select="@useCollimation"/>
                    </h4>
                  </left>
                  <xsl:choose>
                    <xsl:when test="@useCollimation='true'">
                      <table class="margin" cellpadding="2" cellspacing="2" width="30%">
                        <thead style="display:table-header-group">
                          <tr>
                            <th class="underline" lang="en" align="left">
                              Setup<br/>Name
                            </th>
                            <th class="underline" lang="en" align="right">
                              Horizontal<br/>Collimation
                            </th>
                            <th class="underline" lang="en" align="right">
                              Vertical<br/>Collimation
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <xsl:for-each select="SetupCollimation">
                            <tr>
                              <td align="left">
                                <xsl:value-of select="@setupName"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:angularFormat(number(@collimationHorizontal))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:angularFormat(number(@collimationVertical))"/>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                    </xsl:when>
                  </xsl:choose>
                </xsl:for-each>
                <hr />
                <!-- Check Shot Observations and Tolerances-->
                <xsl:for-each select="Tolerances">
                  <left>
                    <h3 lang="en">Check Shot Tolerances and Observations</h3>
                  </left>
                  <xsl:for-each select="Tolerance">
                    <left>
                      <xsl:choose>
                        <xsl:when test="@isControlPoint='true'">
                          <h4 lang="en">
                            Control Point Name:&#xa0; <xsl:value-of select="@name"/>
                          </h4>
                        </xsl:when>
                        <xsl:otherwise>
                          <h4 lang="en">
                            Point Name:&#xa0; <xsl:value-of select="@name"/>
                          </h4>
                        </xsl:otherwise>
                      </xsl:choose>
                    </left>
                    <!-- Tolerances -->
                    <left>
                      <h5 lang="en">Tolerances&#xa0;</h5>
                    </left>
                    <table class="margin" cellpadding="2" cellspacing="2" width="80%">
                      <thead style="display:table-header-group">
                        <tr>
                          <th class="underline" lang="en" align="left">
                            Setup<br/>Name
                          </th>
                          <th class="underline" lang="en" align="left">
                            Backsight<br/>Name
                          </th>
                          <th class="underline" lang="en" align="left">
                            Occupy<br/>Name
                          </th>
                          <th class="underline" lang="en" align="right">
                            Point<br/> <xsl:value-of select="@name"/>
                          </th>
                          <th class="underline" lang="en" align="right">
                            Northing<br/>Y
                          </th>
                          <th class="underline" lang="en" align="right">
                            Easting<br/>X
                          </th>
                          <th class="underline" lang="en" align="right">
                            Elevation<br/>Z
                          </th>
                          <th class="underline" lang="en" align="right">
                            Horizontal<br/>Distance<br/>From Setup
                          </th>
                          <th class="underline" lang="en" align="right">
                            Direction<br/>Bearing<br/>From Setup
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <xsl:for-each select="CheckShotResult">
                          <tr>
                            <td align="left">
                              <xsl:value-of select="@setupName"/>
                            </td>
                            <td align="left">
                              <xsl:value-of select="@backsightName"/>
                            </td>
                            <td align="left">
                              <xsl:value-of select="@occupyName"/>
                            </td>
                            <td align="right" lang="en">Observed:&#xa0;</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@observationNorthing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@observationEasting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@observationElevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@observedDistance))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@observedDirection))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" colspan="4" lang="en">Stored:&#xa0;</td>
                            <td class="underline" align="right">
                              <xsl:value-of select="cif:distanceFormat(number(../@pointNorthing))"/>
                            </td>
                            <td class="underline" align="right">
                              <xsl:value-of select="cif:distanceFormat(number(../@pointEasting))"/>
                            </td>
                            <td class="underline" align="right">
                              <xsl:value-of select="cif:distanceFormat(number(../@pointElevation))"/>
                            </td>
                            <td class="underline" align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@storedDistance))"/>
                            </td>
                            <td class="underline" align="right">
                              <xsl:value-of select="cif:directionFormat(number(@storedDirection))"/>
                            </td>
                          </tr>
                          <tr>
                            <xsl:choose>
                              <xsl:when test="(@failsHorizontal='true' or @failsVertical='true')">
                                <td align="right" colspan="4" lang="en">
                                  <xsl:attribute name="style">color:FF0000</xsl:attribute>
                                  Failed Differences:&#xa0;
                                </td>
                              </xsl:when>
                              <xsl:otherwise>
                                <td align="right" colspan="4" lang="en">
                                  Differences:&#xa0;
                                </td>
                              </xsl:otherwise>
                            </xsl:choose>
                            <td align="right">
                              <xsl:if test="@failsHorizontal='true'">
                                <xsl:attribute name="style">color:FF0000</xsl:attribute>
                              </xsl:if>
                              <xsl:value-of select="cif:distanceFormat(number(@differenceNorthing))"/>
                            </td>
                            <td align="right">
                              <xsl:if test="@failsHorizontal='true'">
                                <xsl:attribute name="style">color:FF0000</xsl:attribute>
                              </xsl:if>
                              (<xsl:value-of select="cif:distanceFormat(number(@differenceHorizontal))"/>)&#xa0;&#xa0;<xsl:value-of select="cif:distanceFormat(number(@differenceEasting))"/>
                            </td>
                            <td align="right">
                              <xsl:if test="@failsVertical='true'">
                                <xsl:attribute name="style">color:FF0000</xsl:attribute>
                              </xsl:if>
                              <xsl:value-of select="cif:distanceFormat(number(@differenceElevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@differenceDistance))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@differenceDirection))"/>
                            </td>
                            <xsl:if test="@failsHorizontal='true'">
                              <td align="center" colspan="4" lang="en">
                                <xsl:attribute name="style">color:FF0000</xsl:attribute>Horizontal
                              </td>
                            </xsl:if>
                            <xsl:if test="@failsVertical='true'">
                              <td align="center" colspan="4" lang="en">
                                <xsl:attribute name="style">color:FF0000</xsl:attribute>Vertical
                              </td>
                            </xsl:if>
                          </tr>
                          <tr>
                            <td align="right" colspan="9">&#xa0;</td>
                          </tr>
                        </xsl:for-each>
                      </tbody>
                    </table>
                    <!-- Observations -->
                    <left>
                      <h5 lang="en">Observations&#xa0;</h5>
                    </left>
                    <table class="margin" cellpadding="2" cellspacing="2" width="80%">
                      <thead style="display:table-header-group">
                        <tr>
                          <th class="underline" lang="en" align="left">
                            Setup<br/>Name
                          </th>
                          <th class="underline" lang="en" align="left">
                            Backsight<br/>Name
                          </th>
                          <th class="underline" lang="en" align="left">
                            Occupy<br/>Name
                          </th>
                          <th class="underline" lang="en" align="right">
                            Occupy<br/>Height
                          </th>
                          <th class="underline" lang="en" align="right">
                            Rod<br/>Height
                          </th>
                          <th class="underline" lang="en" align="right">
                            Circle<br/>Reading
                          </th>
                          <th class="underline" lang="en" align="right">
                            Horizontal<br/>Angle<br/>Reading
                          </th>
                          <th class="underline" lang="en" align="right">
                            Horizontal<br/>Angle<br/>Adjusted
                          </th>
                          <th class="underline" lang="en" align="right">
                            Horizontal<br/>Angle<br/>Measured
                          </th>
                          <th class="underline" lang="en" align="right">
                            Vertical<br/>Angle<br/>Reading
                          </th>
                          <th class="underline" lang="en" align="right">
                            Vertical<br/>Angle<br/>Adjusted
                          </th>
                          <th class="underline" lang="en" align="right">
                            Slope<br/>Distance
                          </th>
                          <th class="underline" lang="en" align="right">
                            Slope<br/>Distance<br/>Computed
                          </th>
                          <th class="underline" lang="en" align="right">
                            Scale<br/>Factor
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <xsl:for-each select="CheckShotResult">
                          <tr>
                            <xsl:if test="(@failsHorizontal='true' or @failsVertical='true')">
                              <xsl:attribute name="style">color:FF0000</xsl:attribute>
                            </xsl:if>
                            <td align="left">
                              <xsl:value-of select="@setupName"/>
                            </td>
                            <td align="left">
                              <xsl:value-of select="@backsightName"/>
                            </td>
                            <td align="left">
                              <xsl:value-of select="@occupyName"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@occupyHeight))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@foresightHeight))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleCircleReading))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleHorizontal))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleHorizontalAdjusted))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleHorizontalMeasured))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleVertical))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@angleVerticalAdjusted))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@slopeDistance))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@slopeDistanceAdjusted))"/>
                            </td>
                            <td align="right">
                              <!--xsl:value-of select="@slopeDistanceFactor"/-->
                              <xsl:value-of select="cif:formatNumber(number(@slopeDistanceFactor),10)"/>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </tbody>
                    </table>
                    <hr />
                  </xsl:for-each>
                </xsl:for-each>
                <hr />
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
      <p class="normal1" lang="en">You must have at least one field book in Project Explorer (Survey) which contains a minimum of one survey setup to get results from this report.</p>
      <p class="normal1">For best results, run the report from the Post or Pre Adjustment Tolerance Check Report.</p>
      <p class="normal1">Once the Civil Report Browser is open, you can select any other setup report, which utilizes the same data as the original report.</p>
      <p class="small" lang="en">
        <em>&#xa9; 2012 Bentley Systems, Inc</em>
      </p>
    </div>
  </xsl:template>
</xsl:stylesheet>
