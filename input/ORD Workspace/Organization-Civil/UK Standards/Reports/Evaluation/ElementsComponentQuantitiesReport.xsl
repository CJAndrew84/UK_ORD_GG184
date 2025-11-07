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
  <!-- CivilCell Component Quantities Report -->
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
                <h2 lang="en">Elements Component Quantities Report</h2>
                <p lang="en">
                  Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                  Time:&#xa0; <xsl:value-of select="cif:time()"/>
                </p>
              </center>
              <!-- Project Data -->
              <xsl:for-each select="RoadwayDesigner/ComponentQuantities">
                <table class="margin" cellpadding="2" width="90%">
                  <tbody>
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
                <table class="margin" width="90%">
                  <thead style="display:table-header-group">
                    <tr>
                      <th class="underline" lang="en" valign="bottom" align="left">Surface</th>
                      <th class="underline" lang="en" valign="bottom" align="left">Material</th>
                      <th class="underline" lang="en" valign="bottom" align="right">Area</th>
                      <th class="underline" lang="en" valign="bottom" align="right">Volume</th>
                      <th class="underline" lang="en" valign="bottom" align="right">Unit Cost</th>
                      <th class="underline" lang="en" valign="bottom" align="right">Material Cost</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="GeomComponent">
                      
                      <tr>
                        <th colspan="3" align="right" lang="en">
                          <xsl:value-of select="@type"/>:&#xa0;
                        </th>
                        <td align="left" colspan="2">
                          <xsl:value-of select="@name"/>
                        </td>
                      </tr>
                      <!-- Volume Data -->

                      <xsl:for-each select="SubElement">
                        <tr>
                          <th lang="en" align="left">
                            <xsl:value-of select="@type"/>&#xa0;-&#xa0;
                            <xsl:value-of select="@name"/>:
                          </th>
                        </tr>
                        <tr>
                          <th lang="en" align="left"></th>
                          <xsl:apply-templates/>
                        </tr>
                      </xsl:for-each>
                      <xsl:for-each select="SubTotal">
                        <tr>
                          <td class="underline" colspan="8" align="center">&#160;</td>
                        </tr>
                        <tr>
                          <th align="left">SubTotals:</th>
                        </tr>
                        <xsl:apply-templates mode="final"/>
                        <tr>
                          <th colspan="5" align="right">
                            Total Estimated Cost:
                          </th>
                          <th align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@subTotalCost), 2)"/>
                          </th>
                        </tr>
                      </xsl:for-each>

                      <tr>
                        <th lang="en" align="left"></th>
                        <xsl:apply-templates select="Material"/>
                      </tr>

                      <tr>
                        <td colspan="8">
                          <hr/>
                        </td>
                      </tr>

                    </xsl:for-each>
                    <xsl:for-each select="Total">
                      <tr>
                        <td colspan="12">
                          <hr/>
                        </td>
                      </tr>
                      <tr>
                        <th align="left">Totals:</th>
                      </tr>
                      <xsl:apply-templates mode="final"/>
                      <tr>
                        <th colspan="5" align="right">
                          Total Estimated Cost:
                        </th>
                        <th align="right">
                          <xsl:value-of select="cif:distanceFormat(number(@totalCost), 2)"/>
                        </th>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </xsl:for-each>

            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="SurfaceVolume">
    <tr>
      <th align="left" nowrap="nowrap">
        <xsl:value-of select="cif:stationFormat(number(../Station/@externalStation), string(../Station/@externalStationName))"/>
      </th>
      <td colspan="5">&#xa0;</td>
    </tr>
    <xsl:apply-templates mode="normalParent"/>
    <tr>
      <td>&#xa0;</td>
    </tr>
  </xsl:template>
  <xsl:template match="Material">
    <tr>
      <td></td>
      <td align="left" >
        <xsl:value-of select="@name"/>:&#xa0;
      </td>
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
      <td align="right">
		<xsl:if test="@volume != 0.0">
			<xsl:value-of select="cif:distanceFormat(number(//Total/Material[@name=current()/@name and @area=current()/@area]/@unitCost), 2)" />
		</xsl:if>
		<xsl:if test="@area != 0.0">
			<xsl:value-of select="cif:distanceFormat(number(//Total/Material[@name=current()/@name and @volume=current()/@volume]/@unitCost), 2)" />
		</xsl:if>
      </td>
      <td align="right">
        <xsl:value-of select="cif:cubicFormat(number((@volume + @area) * //Total/Material[@name=current()/@name]/@unitCost), 2)"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="Material" mode="final">
    <tr>
      <td></td>
      <td align="left">
        <xsl:value-of select="@name"/>:&#xa0;
      </td>
      <xsl:choose>
        <xsl:when test="@area != 0.0">
          <td align="right">
            <xsl:value-of select="cif:cubicFormat(number(@area))"/>
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
          <td >&#xa0;</td>
        </xsl:otherwise>
      </xsl:choose>
      <td align="right">
		<!--<xsl:value-of select="cif:distanceFormat(number(@unitCost), 2)" />-->
		<xsl:if test="@volume != 0.0">
			<xsl:value-of select="cif:distanceFormat(number(//Total/Material[@name=current()/@name and @area=current()/@area]/@unitCost), 2)" />
		</xsl:if>
		<xsl:if test="@area != 0.0">
			<xsl:value-of select="cif:distanceFormat(number(//Total/Material[@name=current()/@name and @volume=current()/@volume]/@unitCost), 2)" />
		</xsl:if>
      </td>
      <td align="right">
        <xsl:value-of select="cif:cubicFormat(number((@area + @volume) * //Total/Material[@name=current()/@name]/@unitCost), 2)"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="StyleSheetHelp">
    <div class="section1">
      <h4 lang="en">Notes</h4>
      <p class="normal1" lang="en">
        You must click the <em>Report </em> button from within <em>Component Quantities</em> to generate a report from this
        command.  Alternately, you can open this report from the Civil Report Browser if another Component Quantities report has already been generated.
      </p>
      <p class="small" lang="en">
        <em>&#xa9; 2018 Bentley Systems, Inc</em>
      </p>
    </div>
  </xsl:template>
</xsl:stylesheet>