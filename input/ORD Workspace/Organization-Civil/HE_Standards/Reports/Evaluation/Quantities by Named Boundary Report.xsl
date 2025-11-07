<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
  <xsl:include href="../format.xsl"/>
  <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
  <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
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
                <h2 lang="en">Quantities Report by Named Boundary</h2>
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
                      <th align="right" lang="en">Named Boundary Group:&#xa0; </th>
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
                        <th class="underline" lang="en" valign="bottom" align="left">Chainage</th>
                        <th class="underline" lang="en" valign="bottom" align="left">Named Boundary Name</th>
                        <th class="underline" lang="en" valign="bottom" align="right">Material</th>
                        <th class="underline" lang="en" valign="bottom" align="right">Count</th>
                        <th class="underline" lang="en" valign="bottom" align="right">Length</th>
                        <th class="underline" lang="en" valign="bottom" align="right">Slope Area</th>
                        <th class="underline" lang="en" valign="bottom" align="right">Volume</th>
                      </tr>
                    </thead>
                    <xsl:for-each select="CrossSectionStation">
                      <tbody>
                        <xsl:apply-templates/>
                      </tbody>
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
    <xsl:choose>
      <xsl:when test="../Station/@internalStation != 0.0">
        <tr>
          <th align="left" nowrap="nowrap">
            <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
              <td align="left">
                <xsl:value-of select="../@namedBoundary"/>
              </td>
          </th>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr>
          <th align="left" nowrap="nowrap">Totals</th>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates mode="normalParent"/>
  </xsl:template>
  <xsl:template match="Material" mode="normalParent">
    <tr>
      <td align="right" colspan="3">
        <xsl:value-of select="@name"/>:&#xa0;
      </td>
      <xsl:choose>
        <xsl:when test="@count != 0">
          <td align="right">
            <xsl:value-of select="number(@count)"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>&#xa0;</td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@length != 0.0">
          <td align="right">
            <xsl:value-of select="cif:distanceFormat(number(@length))"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>&#xa0;</td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@area != 0.0">
          <td align="right">
            <xsl:value-of select="cif:areaFormat(number(@area))"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>&#xa0;</td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@volume != 0.0">
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(@volume div $cubicFactor))"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>&#xa0;</td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>
  <xsl:template name="StyleSheetHelp">
    <div class="section1">
      <h4 lang="en">Notes</h4>
      <p class="normal1" lang="en">
        You must run the command <em>Report </em> button from within <em>Quantities Report by Named Boundaries</em> to generate a report from this
        command.  Alternately, you can open this report from the Civil Report Browser if another Quantities report has already been generated.
      </p>
      <p class="small" lang="en">
        <em>&#xa9; 2018 Bentley Systems, Inc</em>
      </p>
    </div>
  </xsl:template>
</xsl:stylesheet>
