<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
  <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
  <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
  <xsl:param name="xslConvertToCY" select="cif:xslConvertToCY"/>
  <!-- Variable to hold cubic factor -->
  <xsl:variable name="cubicFactor">
    <xsl:choose>
      <xsl:when test="//@linearUnits = 'Imperial'">
        <xsl:choose>
          <xsl:when test="$xslConvertToCY = 1">27</xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- Volumes Report -->
  <xsl:template match="/">
    <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
        <!-- Title displayed in browser Title Bar -->
        <title lang="en">Volumes Report</title>
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
                <h2 lang="en">Volumes Report</h2>
                <p lang="en">
                  Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                  Time:&#xa0; <xsl:value-of select="cif:time()"/>
                </p>
              </center>
              <!-- Cross Section Set Data -->
              <xsl:for-each select="CrossSectionSet">
                <table class="margin" cellpadding="2" width="90%">
                  <tbody>
                    <tr>
                      <th align="right" lang="en">Cross Section Set Name:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="@setName"/>
                      </td>
                    </tr>
                    <tr>
                      <th align="right" lang="en">Alignment Name:&#xa0; </th>
                      <td align="left" colspan="2">
                        <xsl:value-of select="@alignmentName"/>
                      </td>
                    </tr>
                    <tr>
                      <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                      <td align="left" style="font-size: 80%">
                        <xsl:value-of select="../@inputGridScaleFactor" />
                      </td>
                      <td align="right" lang="en" style="font-size: 80%">
                        <strong>Note:&#xa0; </strong>All units in this report are in
                        <xsl:if test="//@linearUnits = 'Imperial'">
                          <xsl:choose>
                            <xsl:when test="$xslConvertToCY = 1">
                              feet, square feet and cubic yards
                            </xsl:when>
                            <xsl:otherwise>
                              feet, square feet and cubic feet
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="//@linearUnits = 'Metric'">
                          meters, square meters and cubic meters
                        </xsl:if>
                        unless specified otherwise.
                      </td>
                    </tr>
                  </tbody>
                </table>
                <hr/>
                <!-- Volume Data -->
                <table class="margin" width="90%">
                  <xsl:for-each select="CrossSectionStations">
                    <thead style="display:table-header-group">
                      <tr>
                        <th class="underline" lang="en" valign="bottom">Chainage</th>
                        <th class="underline" lang="en" valign="bottom">Type</th>
                        <th class="underline" lang="en" valign="bottom">Area</th>
                        <th class="underline" lang="en" valign="bottom">Volume</th>
                        <th class="underline" lang="en" valign="bottom">Factor</th>
                        <th class="underline" lang="en" valign="bottom">
                          Adjusted<br/>Volume
                        </th>
                        <th class="underline" lang="en" valign="bottom">
                          Included in<br/>Mass Ordinate?
                        </th>
                        <th class="underline" lang="en" valign="bottom">
                          Mass<br/>Ordinate
                        </th>
                      </tr>
                    </thead>
                    <xsl:for-each select="CrossSectionStation">
                      <tbody>
                        <xsl:apply-templates/>
                      </tbody>
                      <tfoot style="display:table-footer-group">
                        <xsl:if test="position() = last()">
                          <xsl:for-each select="StationVolume">
                            <tr>
                              <td colspan="8">
                                <hr/>
                              </td>
                            </tr>
                            <tr>
                              <th align="left">Totals:</th>
                            </tr>
                            <xsl:apply-templates mode="final"/>
                          </xsl:for-each>
                        </xsl:if>
                      </tfoot>
                    </xsl:for-each>
                  </xsl:for-each>
                </table>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="StationVolume">
    <tr>
      <th align="left" nowrap="nowrap">
        <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
      </th>
      <td colspan="6">&#xa0;</td>
      <td align="right">
        <xsl:value-of select="cif:cubicFormat(number(@massOrdinate div $cubicFactor))"/>
      </td>
    </tr>
    <xsl:apply-templates mode="normalParent"/>
    <tr>
      <td>&#xa0;</td>
    </tr>
  </xsl:template>
  <xsl:template match="Material" mode="normalParent">
    <xsl:choose>
      <xsl:when test="not(MDC)">
        <xsl:choose>
          <xsl:when test="Replaced">
            <tr style="line-height:25%">
              <td colspan="8">&#xa0;</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                <xsl:value-of select="@name"/> (replaced):&#xa0;
              </td>
              <td align="right">
                <xsl:value-of select="cif:areaFormat(number(Replaced/@area))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(Replaced/@volume div $cubicFactor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(Replaced/@factor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(Replaced/@adjustedVolume div $cubicFactor))"/>
              </td>
              <td align="center" lang="en">No</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                <xsl:value-of select="@name"/> (not replaced):&#xa0;
              </td>
              <td align="right">
                <xsl:value-of select="cif:areaFormat(number(NotReplaced/@area))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(NotReplaced/@volume div $cubicFactor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(NotReplaced/@factor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(NotReplaced/@adjustedVolume div $cubicFactor))"/>
              </td>
              <td align="center" lang="en">No</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                Total <xsl:value-of select="@name"/>:&#xa0;
              </td>
              <td class="overline" align="right">
                <xsl:value-of select="cif:areaFormat(number(@area))"/>
              </td>
              <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(@volume div $cubicFactor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@factor))"/>
              </td>
              <td class="overline" align="right">
                <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
              </td>
            </tr>
            <tr style="line-height:25%">
              <td colspan="8">&#xa0;</td>
            </tr>
          </xsl:when>
          <xsl:when test="number(@area) > 0 or number(@cumulativeVolume) > 0">
            <tr>
              <td align="right" colspan="2">
                <xsl:value-of select="@name"/>:&#xa0;
              </td>
              <td align="right">
                <xsl:value-of select="cif:areaFormat(number(@area))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@volume div $cubicFactor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:distanceFormat(number(@factor))"/>
              </td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
              </td>
              <xsl:choose>
                <xsl:when test="@includeInMassOrdinate = 'true'">
                  <td align="center" lang="en">Yes</td>
                </xsl:when>
                <xsl:otherwise>
                  <td align="center" lang="en">No</td>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <tr style="line-height:25%">
          <td colspan="8">&#xa0;</td>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (unclassified MDC):&#xa0;
          </td>
          <td align="right">
            <xsl:value-of select="cif:areaFormat(number(@area - MDC/@area))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number((@volume - MDC/@volume) div $cubicFactor))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:distanceFormat(number(@factor))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number((@adjustedVolume - MDC/@adjustedVolume) div $cubicFactor))"/>
          </td>
          <xsl:choose>
            <xsl:when test="@includeInMassOrdinate = 'true'">
              <td align="center" lang="en">Yes</td>
            </xsl:when>
            <xsl:otherwise>
              <td align="center" lang="en">No</td>
            </xsl:otherwise>
          </xsl:choose>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (subcut MDC):&#xa0;
          </td>
          <td align="right">
            <xsl:value-of select="cif:areaFormat(number(MDC/@area))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(MDC/@volume div $cubicFactor))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:distanceFormat(number(MDC/@factor))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(MDC/@adjustedVolume div $cubicFactor))"/>
          </td>
          <xsl:choose>
            <xsl:when test="MDC/@includeInMassOrdinate = 'true'">
              <td align="center" lang="en">Yes</td>
            </xsl:when>
            <xsl:otherwise>
              <td align="center" lang="en">No</td>
            </xsl:otherwise>
          </xsl:choose>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (fill MDC):&#xa0;
          </td>
          <td class="overline" align="right">
            <xsl:value-of select="cif:areaFormat(number(@area))"/>
          </td>
          <td class="overline" align="right">
            <xsl:value-of select="cif:cubicFormat(number(@volume div $cubicFactor))"/>
          </td>
          <td align="right">
            <xsl:value-of select="cif:distanceFormat(number(@factor))"/>
          </td>
          <td class="overline" align="right">
            <xsl:value-of select="cif:cubicFormat(number(@adjustedVolume div $cubicFactor))"/>
          </td>
        </tr>
        <tr style="line-height:25%">
          <td colspan="8">&#xa0;</td>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="Material" mode="final">
    <xsl:choose>
      <xsl:when test="not(MDC)">
        <xsl:choose>
          <xsl:when test="Replaced">
            <tr style="line-height:25%">
              <td colspan="8">&#xa0;</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                <xsl:value-of select="@name"/> (replaced):&#xa0;
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(Replaced/@cumulativeVolume div $cubicFactor))"/>
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(Replaced/@cumulativeAdjustedVolume div $cubicFactor))"/>
              </td>
              <td align="center" lang="en">No</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                <xsl:value-of select="@name"/> (not replaced):&#xa0;
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(NotReplaced/@cumulativeVolume div $cubicFactor))"/>
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(NotReplaced/@cumulativeAdjustedVolume div $cubicFactor))"/>
              </td>
              <td align="center" lang="en">No</td>
            </tr>
            <tr>
              <td align="right" colspan="2" lang="en">
                Total <xsl:value-of select="@name"/>:&#xa0;
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeVolume div $cubicFactor))"/>
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeAdjustedVolume div $cubicFactor))"/>
              </td>
            </tr>
            <tr style="line-height:25%">
              <td colspan="8">&#xa0;</td>
            </tr>
          </xsl:when>
          <xsl:when test="number(@area) > 0 or number(@cumulativeVolume) > 0">
            <tr>
              <td align="right" colspan="2">
                <xsl:value-of select="@name"/>:&#xa0;
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeVolume div $cubicFactor))"/>
              </td>
              <td>&#xa0;</td>
              <td align="right">
                <xsl:value-of select="cif:cubicFormat(number(@cumulativeAdjustedVolume div $cubicFactor))"/>
              </td>
              <xsl:choose>
                <xsl:when test="@includeInMassOrdinate = 'true'">
                  <td align="center" lang="en">Yes</td>
                </xsl:when>
                <xsl:otherwise>
                  <td align="center" lang="en">No</td>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <tr style="line-height:25%">
          <td colspan="8">&#xa0;</td>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (unclassified MDC):&#xa0;
          </td>
          <td>&#xa0;</td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number((@cumulativeVolume - MDC/@cumulativeVolume) div $cubicFactor))"/>
          </td>
          <td>&#xa0;</td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number((@cumulativeAdjustedVolume - MDC/@cumulativeAdjustedVolume) div $cubicFactor))"/>
          </td>
          <xsl:choose>
            <xsl:when test="@includeInMassOrdinate = 'true'">
              <td align="center" lang="en">Yes</td>
            </xsl:when>
            <xsl:otherwise>
              <td align="center" lang="en">No</td>
            </xsl:otherwise>
          </xsl:choose>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (subcut MDC):&#xa0;
          </td>
          <td>&#xa0;</td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(MDC/@cumulativeVolume div $cubicFactor))"/>
          </td>
          <td>&#xa0;</td>
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(MDC/@cumulativeAdjustedVolume div $cubicFactor))"/>
          </td>
          <xsl:choose>
            <xsl:when test="MDC/@includeInMassOrdinate = 'true'">
              <td align="center" lang="en">Yes</td>
            </xsl:when>
            <xsl:otherwise>
              <td align="center" lang="en">No</td>
            </xsl:otherwise>
          </xsl:choose>
        </tr>
        <tr>
          <td align="right" colspan="2" lang="en">
            <xsl:value-of select="@name"/> (fill MDC):&#xa0;
          </td>
          <td>&#xa0;</td>
          <td class="overline" align="right">
            <xsl:value-of select="cif:cubicFormat(number(@cumulativeVolume div $cubicFactor))"/>
          </td>
          <td>&#xa0;</td>
          <td class="overline" align="right">
            <xsl:value-of select="cif:cubicFormat(number(@cumulativeAdjustedVolume div $cubicFactor))"/>
          </td>
        </tr>
        <tr style="line-height:25%">
          <td colspan="8">&#xa0;</td>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="StyleSheetHelp">
    <div class="section1">
      <h4 lang="en">Notes</h4>
      <p class="normal1" lang="en">
        You must have created cross sections along your alignment and the cross section set must
        have the surfaces and features upon which you wish to report displayed.
      </p>
      <p class="normal1" lang="en">
        Add description.
      </p>
      <p class="small" lang="en">
        <em>&#xa9; 2018 Bentley Systems, Inc</em>
      </p>
    </div>
  </xsl:template>
</xsl:stylesheet>
