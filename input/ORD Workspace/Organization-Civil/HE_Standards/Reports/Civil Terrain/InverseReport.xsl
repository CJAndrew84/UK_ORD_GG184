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
        <title lang="en">Inverse Report</title>
      </head>
      <body>
        <xsl:choose>
          <xsl:when test="$xslShowHelp = 'true'">
            <xsl:call-template name="StyleSheetHelp"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="InRoads">
              <xsl:for-each select="GeometryProject">
                <center>
                  <!-- Report Title -->
                  <h2 lang="en">Inverse Report</h2>
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
                  <h4>Inverse Elements</h4>
                </center>
                <xsl:if test="InverseLine">
                  <hr size="1px"/>
                  <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap">INVERSE LINEAR&#xa0;</th>
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
                    </colgroup>
                    <thead style="display:table-header-group">
                      <tr>
                      </tr>
                      <tr>
                        <th class="underline" lang="en" align="left">Direction</th>
                        <th class="underline" lang="en" align="left">Distance</th>
                        <th class="underline" lang="en" align="right">X</th>
                        <th class="underline" lang="en" align="right">Y</th>
                        <th class="underline" lang="en" align="right">Elevation</th>
                        <th class="underline" lang="en" align="right">PointName</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="InverseLine">
                        <tr>
                          <td align="left">
                            <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                          </td>
                          <td align="left">
                            <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                          </td>
                          <xsl:for-each select="Start">
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                          </xsl:for-each>
                        </tr>
                        <tr>
                          <xsl:for-each select="End">
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>                            
                          </xsl:for-each>
                        </tr>

                        <xsl:if test="//@SDIS">
                          <tr>
                            <th align="left" nowrap="nowrap">SDIS = &#xa0;</th>
                            <td align="left" nowrap="nowrap">
                              <xsl:value-of select="cif:distanceFormat(number(@SDIS))"/>
                            </td>
                            <!-- <td align="right" colspan="1" lang="en"></td>-->
                          </tr>
                          <tr>
                            <th align="left" nowrap="nowrap">DeltaZ = &#xa0;</th>
                            <td align="left" nowrap="nowrap">
                              <xsl:value-of select="cif:distanceFormat(number(@DeltaZ))"/>
                            </td>
                            <!-- <td align="right" colspan="1" lang="en"></td>-->
                          </tr>                          
                        </xsl:if>

                      </xsl:for-each>
                    </tbody>
                  </table>
                </xsl:if>
                <xsl:for-each select="AccumulatedDistance">
                  <table class="margin" cellpadding="1" cellspacing="1" width="20%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap">Accumulated Distance = &#xa0;</th>
                        <td align="left" nowrap="nowrap">
                          <xsl:value-of select="cif:distanceFormat(number(@accumulatedDistance))"/>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </xsl:for-each>
                <hr size="1px"/>
                <xsl:for-each select="InverseByElement">


                  <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap"> </th>
                      </tr>
                      <tr>
                        <th align="left" nowrap="nowrap">INVERSE BY ELEMENT&#xa0;</th>
                      </tr>
                    </tbody>
                  </table>

                        <xsl:for-each select="SubElement">
                          <hr size="1px"/>
                          <xsl:if test=".//@type = 'Line'">
                            <!--<hr size="1px"/>-->
                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                              <tbody>
                                <tr>
                                  <th align="left" nowrap="nowrap">LINE&#xa0;</th>
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
                              </colgroup>
                              <thead style="display:table-header-group">
                                <tr>
                                </tr>
                                <tr>
                                  <th class="underline" lang="en" align="left">Direction</th>
                                  <th class="underline" lang="en" align="left">Distance</th>
                                  <th class="underline" lang="en" align="right">X</th>
                                  <th class="underline" lang="en" align="right">Y</th>
                                  <th class="underline" lang="en" align="right">Elevation</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td align="left">
                                    <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                                  </td>
                                  <td align="left">
                                    <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                  </td>
                                  <xsl:for-each select="Start">
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <tr>
                                  <xsl:for-each select="End">
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                    </td>
                                  </xsl:for-each>
                                </tr>
                                <xsl:if test="//@SDIS">
                                  <tr>
                                    <th align="left" nowrap="nowrap">SDIS = &#xa0;</th>
                                    <td align="left" nowrap="nowrap">
                                      <xsl:value-of select="cif:distanceFormat(number(@SDIS))"/>
                                    </td>
                                    <!-- <td align="right" colspan="1" lang="en"></td>-->
                                  </tr>
                                  <tr>
                                    <th align="left" nowrap="nowrap">DeltaZ = &#xa0;</th>
                                    <td align="left" nowrap="nowrap">
                                      <xsl:value-of select="cif:distanceFormat(number(@DeltaZ))"/>
                                    </td>
                                    <!-- <td align="right" colspan="1" lang="en"></td>-->
                                  </tr>
                                </xsl:if>

                              </tbody>
                            </table>
                          </xsl:if>

                          <xsl:if test=".//@type = 'Arc'">
                            <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                              <tbody>
                                <tr>
                                  <th align="left" nowrap="nowrap"> </th>
                                </tr>
                                <tr>
                                  <th align="left" nowrap="nowrap">ARC&#xa0;</th>
                                </tr>
                              </tbody>
                            </table>
                            <table class="margin" cellpadding="1" cellspacing="1" width="80%">
                              <colgroup span="8">
                                <col width="5%"/>
                                <col width="5%"/>
                                <col width="5%"/>
                                <col width="5%"/>
                              </colgroup>
                              <thead style="display:table-header-group">
                                <tr>
                                </tr>
                                <tr>
                                  <th class="underline" lang="en" align="left"></th>
                                  <th class="underline" lang="en" align="right">X</th>
                                  <th class="underline" lang="en" align="right">Y</th>
                                  <th class="underline" lang="en" align="right">Elevation</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <tr>
                                    <xsl:for-each select="Start">
                                      <td align="right">
                                        PC ()
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                      </td>
                                    </xsl:for-each>
                                  </tr>
                                  <tr>
                                    <xsl:for-each select="PI">
                                      <td align="right">
                                        PI ()
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                      </td>
                                    </xsl:for-each>
                                  </tr>
                                  <tr>
                                    <xsl:for-each select="Center">
                                      <td align="right">
                                        CC ()
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                      </td>
                                    </xsl:for-each>
                                  </tr>
                                  <tr>
                                    <xsl:for-each select="End">
                                      <td align="right">
                                        PT ()
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                      </td>
                                      <td align="right">
                                        <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                      </td>
                                    </xsl:for-each>
                                  </tr>
                                  <tr>
                                    <td align="right">
                                      Radius:
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right">
                                      Delta:
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right">
                                      Degree of Curvature:
                                    </td>
                                    <td align="right">
                                      <xsl:value-of select="cif:angularFormat(number(@degreeOfCurve))"/>
                                    </td>
                                  </tr>

                                  <tr>
                                    <td align="right" lang="en">Length:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Tangent:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Chord:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Middle Ordinate:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@middleOrdinate))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">External:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:distanceFormat(number(@externalDistance))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Tangent Direction Start:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Radial Direction Start:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Chord Direction:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Radial Direction End:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right" lang="en">Tangent Direction End:</td>
                                    <td align="right">
                                      <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
                                    </td>
                                  </tr>
                                </tr>
                                <tr/>
                              </tbody>
                            </table>
                          </xsl:if>
                        </xsl:for-each>
                </xsl:for-each>                
                <xsl:for-each select="InverseArc">
                  <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap"> </th>                        
                      </tr>
                      <tr>
                        <th align="left" nowrap="nowrap">INVERSE CIRCULAR&#xa0;</th>
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
                    </colgroup>
                    <thead style="display:table-header-group">
                      <tr>
                      </tr>
                      <tr>
                        <th class="underline" lang="en" align="left"></th>
                        <th class="underline" lang="en" align="right">X</th>
                        <th class="underline" lang="en" align="right">Y</th>
                        <th class="underline" lang="en" align="right">Elevation</th>
                        <th class="underline" lang="en" align="right">Point Name</th>
                      </tr>
                    </thead>
                    <tbody>
                        <tr>
                          <tr>
                            <xsl:for-each select="Start">
                              <td align="right">
                                PC ()
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="@pointName"/>
                              </td>
                            </xsl:for-each>
                          </tr>
                          <tr>
                          <xsl:for-each select="PI">
                            <td align="right">
                              PI ()
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                          </xsl:for-each>
                          </tr>
                          <tr>
                            <xsl:for-each select="Center">
                              <td align="right">
                                CC ()
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="@pointName"/>
                              </td>
                            </xsl:for-each>
                          </tr>
                          <tr>
                          <xsl:for-each select="End">
                            <td align="right">
                              PT ()
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                          </xsl:for-each>
                          </tr>
                          <tr>
                            <td align="right">
                              Radius:
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@radius))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Delta:
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@delta))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Degree of Curvature:
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:angularFormat(number(@degreeOfCurve))"/>
                            </td>
                          </tr>

                          <tr>
                            <td align="right" lang="en">Length:</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Tangent:</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@tangentLength))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Chord:</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@chord))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Middle Ordinate:</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@middleOrdinate))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">External:</td>
                            <td align="right">
                              <xsl:value-of select="cif:distanceFormat(number(@externalDistance))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Tangent Direction Start:</td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionStart))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Radial Direction Start:</td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@radialDirectionStart))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Chord Direction:</td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@chordDirection))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Radial Direction End:</td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@radialDirectionEnd))"/>
                            </td>
                          </tr>
                          <tr>
                            <td align="right" lang="en">Tangent Direction End:</td>
                            <td align="right">
                              <xsl:value-of select="cif:directionFormat(number(@tangentialDirectionEnd))"/>
                            </td>
                          </tr>
                        </tr>
                      <tr/>
                    </tbody>
                  </table>
              </xsl:for-each>
                <xsl:for-each select="InverseRadial">
                  <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap"> </th>
                      </tr>
                      <tr>
                        <th align="left" nowrap="nowrap">INVERSE RADIAL&#xa0;</th>
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
                    </colgroup>
                    <thead style="display:table-header-group">
                      <tr>
                      </tr>
                      <tr>
                        <th class="underline" lang="en" align="left"></th>
                        <th class="underline" lang="en" align="right">Direction</th>
                        <th class="underline" lang="en" align="right">Distance</th>
                        <th class="underline" lang="en" align="right">X</th>
                        <th class="underline" lang="en" align="right">Y</th>
                        <th class="underline" lang="en" align="right">Elevation</th>
                        <th class="underline" lang="en" align="right">Point Name</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <tr>
                          <xsl:for-each select="Backsight">
                            <td align="right">
                              Backsight Point
                            </td>
                            <td align="right" colspan="2" lang="en"></td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                          </xsl:for-each>
                        </tr>
                        <tr>
                          <xsl:for-each select="Occupied">
                            <td align="right">
                              Occupied Point
                            </td>
                            <td align="right" colspan="2" lang="en"></td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                          </xsl:for-each>
                        </tr>
                        <tr>
                          <xsl:for-each select="RadialPoint">
                            <td align="right">
                              Radial Point
                            </td>
                            <td align="right" colspan="2" lang="en"></td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                            </td>
                            <td align="right">
                              <xsl:value-of select="@pointName"/>
                            </td>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:angularFormat(number(@deflectionAngle))"/>
                              </td>
                              <td align="right">
                                Deflection Angle
                              </td>
                            </tr>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:angularFormat(number(@angleLeft))"/>
                              </td>
                              <td align="right">
                                Angle Left
                              </td>
                            </tr>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:angularFormat(number(@angleRight))"/>
                              </td>
                              <td align="right">
                                Angle Right
                              </td>
                            </tr>
                            <xsl:if test="//@SDIS">
                              <tr>
                                <td align="right" colspan="1" lang="en"></td>
                                <td align="right">
                                  <xsl:value-of select="cif:distanceFormat(number(@SDIS))"/>
                                </td>
                                <td align="right">
                                  SDIS
                                </td>
                              </tr>
                              <tr>
                                <td align="right" colspan="1" lang="en"></td>
                                <td align="right">
                                  <xsl:value-of select="cif:distanceFormat(number(@DeltaZ))"/>
                                </td>
                                <td align="right">
                                  DeltaZ
                                </td>
                              </tr>
                            </xsl:if>
                          </xsl:for-each>
                        </tr>
                      </tr>
                      <tr/>
                    </tbody>
                  </table>
                </xsl:for-each>
                <xsl:for-each select="InversePerpendicular">
                  <table class="margin" cellpadding="1" cellspacing="1" width="50%">
                    <tbody>
                      <tr>
                        <th align="left" nowrap="nowrap"> </th>
                      </tr>
                      <tr>
                        <th align="left" nowrap="nowrap">INVERSE PERPENDICULAR&#xa0;</th>
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
                    </colgroup>
                    <thead style="display:table-header-group">
                      <tr>
                      </tr>
                      <tr>
                        <th class="underline" lang="en" align="left"></th>
                        <th class="underline" lang="en" align="right">Direction</th>
                        <th class="underline" lang="en" align="right">Distance</th>
                        <th class="underline" lang="en" align="right">X</th>
                        <th class="underline" lang="en" align="right">Y</th>
                        <th class="underline" lang="en" align="right">Elevation</th>
                        <th class="underline" lang="en" align="right">Point Name</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:if test="//@perpendicularType = 'ByPoints'">
                        <tr>
                          <th align="left" nowrap="nowrap">Perpendicular Between Points&#xa0;</th>
                        </tr>

                        <tr>
                        <xsl:for-each select="baseLine">
                          <tr>
                            <xsl:for-each select="Start">
                              <td align="right">
                                Begin Point
                              </td>
                              <td align="right" colspan="2" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="@pointName"/>
                              </td>

                            </xsl:for-each>
                          </tr>
                          <tr>
                            <xsl:for-each select="End">
                              <td align="right">
                                Backsight Point
                              </td>
                              <td align="right" colspan="2" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="@pointName"/>
                              </td>
                            </xsl:for-each>
                          </tr>
                        </xsl:for-each>
                        <tr>
                          <xsl:for-each select="InversePerpendicularLine">
                            <td align="right">
                              Offset Point
                            </td>
                            <xsl:for-each select="Start">
                              <td align="right" colspan="2" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="@pointName"/>
                              </td>
                            </xsl:for-each>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@directionBaseElement))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(@distanceAlong))"/>
                              </td>
                            </tr>
                            <tr>
                              <td align="right" colspan="1" lang="en"></td>
                              <td align="right">
                                <xsl:value-of select="cif:directionFormat(number(@directionOffset))"/>
                              </td>
                              <td align="right">
                                <xsl:value-of select="cif:distanceFormat(number(@distanceOffset))"/>
                              </td>
                            </tr>
                            <xsl:if test="//@SDIS">
                              <tr>
                                <th align="left" nowrap="nowrap">SDIS = &#xa0;</th>
                                <td align="left" nowrap="nowrap">
                                  <xsl:value-of select="cif:distanceFormat(number(@SDIS))"/>
                                </td>
                                <!-- <td align="right" colspan="1" lang="en"></td>-->
                              </tr>
                              <tr>
                                <th align="left" nowrap="nowrap">DeltaZ = &#xa0;</th>
                                <td align="left" nowrap="nowrap">
                                  <xsl:value-of select="cif:distanceFormat(number(@DeltaZ))"/>
                                </td>
                                <!-- <td align="right" colspan="1" lang="en"></td>-->
                              </tr>
                            </xsl:if>                            
                          </xsl:for-each>
                        </tr>
                      </tr>
                      <tr/>
                      </xsl:if>
                      <xsl:if test="//@perpendicularType = 'ByElement'">
                        <tr>
                          <th align="left" nowrap="nowrap">Perpendicular Along Element&#xa0;</th>
                        </tr>

                        <tr>
                          <td align="right">
                            Element Length
                          </td>
                          <td align="right" colspan="1" lang="en"></td>
                          <td align="right">
                            <xsl:value-of select="cif:distanceFormat(number(@elementLength))"/>
                          </td>                          
                          <tr>
                            <xsl:for-each select="InversePerpendicularLine">
                              <td align="right">
                                Offset Point
                              </td>
                              <xsl:for-each select="Start">
                                <td align="right" colspan="2" lang="en"></td>
                                <td align="right">
                                  <xsl:value-of select="cif:ordinateFormat(number(@easting))"/>
                                </td>
                                <td align="right">
                                  <xsl:value-of select="cif:ordinateFormat(number(@northing))"/>
                                </td>
                                <td align="right">
                                  <xsl:value-of select="cif:ordinateFormat(number(@elevation))"/>
                                </td>
                                <td align="right">
                                  <xsl:value-of select="@pointName"/>
                                </td>
                              </xsl:for-each>
                              <tr>
                                <td align="right" colspan="1" lang="en"></td>
                                <td align="right">
                                  Along Element
                                </td>
                                <td align="right">
                                  <xsl:value-of select="cif:distanceFormat(number(@distanceAlong))"/>
                                </td>
                              </tr>
                              <tr>
                                <td align="right" colspan="1" lang="en"></td>
                                <td align="right">
                                  <xsl:value-of select="cif:directionFormat(number(@directionOffset))"/>
                                </td>
                                <td align="right">
                                  <xsl:value-of select="cif:distanceFormat(number(@distanceOffset))"/>
                                </td>
                              </tr>
                              <xsl:if test="//@SDIS">
                                <tr>
                                  <th align="left" nowrap="nowrap">SDIS = &#xa0;</th>
                                  <td align="left" nowrap="nowrap">
                                    <xsl:value-of select="cif:distanceFormat(number(@SDIS))"/>
                                  </td>
                                  <!-- <td align="right" colspan="1" lang="en"></td>-->
                                </tr>
                                <tr>
                                  <th align="left" nowrap="nowrap">DeltaZ = &#xa0;</th>
                                  <td align="left" nowrap="nowrap">
                                    <xsl:value-of select="cif:distanceFormat(number(@DeltaZ))"/>
                                  </td>
                                  <!-- <td align="right" colspan="1" lang="en"></td>-->
                                </tr>
                              </xsl:if>                              
                            </xsl:for-each>
                          </tr>
                        </tr>
                        <tr/>
                      </xsl:if>

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
