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
                <title lang="en">SurveyLinear Feature Report</title>
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
                                <h2 lang="en">Survey Linear Feature Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
                            <xsl:for-each select="SurveyFieldbook">
                                <table class="margin" cellpadding="2" width="80%">
                                    <tbody>
                                        <tr>
                                            <th align="right"  lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Units:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@surveyLinearUnits"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr />
                                <!-- Cogo chain Data -->
                                <table class="margin" cellpadding="2" cellspacing="2" width="80%">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th class="underline" lang="en" align="left">Chain<br/>Name</th>
                                            <th class="underline" lang="en" align="left">Description</th>
                                            <th class="underline" lang="en" align="left">Feature<br/>Definition</th>
                                            <th class="underline" lang="en" align="left">Display</th>
                                            <th class="underline" lang="en" align="right">Zone</th>
                                            <th class="underline" lang="en" align="left">Attributes<br/>Pair</th>
                                            <th class="underline" lang="en" align="left">Data<br/>File<br/>Name</th>
                                            <th class="underline" lang="en" align="left">Field<br/>Book</th>
                                            <th class="underline" lang="en" align="left">Media<br/>File</th>
                                            <th class="underline" lang="en" align="right">Length</th>
                                            <th class="underline" lang="en" align="left">Time<br/>Stamp</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <xsl:for-each select="SurveyChainList">
                                            <xsl:for-each select="SurveyChain">
                                                <tr>
                                                    <td align="left">
                                                        <xsl:value-of select="@name"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@description"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@code"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@display"/>
                                                    </td>                                                    
                                                    <td align="right">
                                                        <xsl:value-of select="@zone"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@attributesPair"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@dataFileName"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@fieldBook"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@mediaFile"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:distanceFormat(number(@length))"/>
                                                    </td>
                                                    <td align="left">
                                                        <xsl:value-of select="@timeStamp"/>
                                                    </td>
                                                </tr>
                                                <xsl:for-each select="VertexCourse">
                                                    <tr>
                                                        <!--<th align="left" nowrap="nowrap">Point: &#xa0;</th>-->
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap"></th>

                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Vertex</th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                                                          </td>
                                                          
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Dist: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Slope Dist: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@slopeDistance))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Elev Diff: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@elevationDiff))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Grade: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@grade))"/>
                                                          </td>

                                                    </tr>
                                              </xsl:for-each>
                                              <xsl:for-each select="SurveyPoint">
                                                  <tr>
                                                      <!--<th align="left" nowrap="nowrap">Point: &#xa0;</th>-->
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">Point:</th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="@name"/>
                                                      </td>
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">Feature: </th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="@code"/>
                                                      </td>                                                              
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">N </th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="cif:distanceFormat(number(@Y))"/>
                                                      </td>           
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">E </th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="cif:distanceFormat(number(@X))"/>
                                                      </td>     
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">Z </th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="cif:distanceFormat(number(@Z))"/>
                                                      </td>  
                                                  </tr>
                                                  <!--<tr>
                                                      <th class="underline" lang="en" align="right" nowrap="nowrap">Zone: </th>
                                                      <td class="underline" lang="en" align="left">
                                                          <xsl:value-of select="@zone"/>
                                                      </td>                                                              
                                                      
                                                      <td align="left" nowrap="nowrap">
                                                          <xsl:value-of select="cif:directionFormat(number(@bearing))"/>
                                                      </td>                                                     
                                                  </tr>--> 
                                                  <xsl:for-each select="PointCourse">
                                                      <tr>
                                                          <!--<xsl:text>Course from: </xsl:text>
                                                          <xsl:value-of select="&#x9;@nameStart"/>-->
                                                          <th align="right" nowrap="nowrap"></th>
                                                          
                                                          <th align="right" nowrap="nowrap">&#xA;&#xA; Course from: </th>
                                                          <td align="left">
                                                              <xsl:value-of select="@nameStart"/>
                                                          </td>
                                                          <th align="right" nowrap="nowrap"> to: </th>
                                                          <td align="left">
                                                              <xsl:value-of select="@nameEnd"/>
                                                          </td>
                                                          <th align="right" nowrap="nowrap"> </th>
                                                          <td align="left">
                                                              <xsl:value-of select="cif:directionFormat(number(@direction))"/>
                                                          </td>
                                                      </tr>
                                                      <tr>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap"></th>
                                                          
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Dist: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@distance))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Slope Dist: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@slopeDistance))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Elev Diff: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@elevationDiff))"/>
                                                          </td>
                                                          <th class="underline" lang="en" align="right" nowrap="nowrap">Grade: </th>
                                                          <td class="underline" lang="en" align="left">
                                                              <xsl:value-of select="cif:distanceFormat(number(@grade))"/>
                                                          </td>
                                                        
                                                      </tr>
                                                  </xsl:for-each>                                            
                                                </xsl:for-each>                                            
                                            </xsl:for-each>
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
    <xsl:template name="StyleSheetHelp">
        <div class="section1">
            <h4 lang="en">Notes</h4>
            <p class="normal1" lang="en">
             You must have at least one field book in Project Explorer (Survey) which contains a minimum of one linear feature to get results from this report.
	</p>

<p class="normal1">For best results, run the report from the Details panel.  Select All Linear Features or any combination of Features in Project Explorer, which populates the Details panel. Note the linear features do not need to be displayed. Highlight the row(s) to be included in the report, right click, and select Report on Selected Items.
</p>
<p class="normal1">Running the report from the generic survey report tool, or right clicking on a graphic only reports on the individually selected element. 
</p>
            <p class="normal1">Once the Civil Report Browser is open, you can select any other linear features report, which utilizes the same data as the original report.</p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
