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
                <title lang="en">Survey Observation Report</title>
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
                                <h2 lang="en">Survey Observation Report</h2>
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
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Units:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@surveyLinearUnits"/></td>
                                        </tr>                                        
                                    </tbody>
                                </table>
                                <hr />
                                <!-- Survey Observation Data -->
                                <xsl:for-each select="SurveyObsList">
                                    <table class="margin" cellpadding="2" cellspacing="1" width="100%">
                                        <colgroup span="2">
                                            <col width="30%"/>
                                            <col width="70%"/>
                                        </colgroup>
                                        <tbody>
                                            <xsl:for-each select="SurveyObservation">
                                                <tr>
                                                    <th align="right" lang="en">Name:&#xa0; </th>
                                                    <td><xsl:value-of select="@name"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Description:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@description"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Feature Definitioin:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@code"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Link Code:&#xa0; </th>
                                                    <td><xsl:value-of select="@linkCode"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Zone:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@zone"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Terrain Attribute:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@terrainAttribute"/>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <th align="right" lang="en">Attributes Pair:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@attributesPair"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Control Codes:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@controlCodes"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Instrument Orientation:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@instrumentOrientation"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Set Number:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@setNumber"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Rod Height:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@rodHeight"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Horizontal Angle:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:angularFormat(number(@horizontalAngle))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Vertical Angle:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:angularFormat(number(@verticalAngle))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Slope Distance:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:distanceFormat(number(@slopeDistance))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Setup Name:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@setupName"/>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <th align="right" lang="en">Data File:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@dataFile"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">VBA Macro:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@vbaMacro"/>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <th align="right" lang="en">Field Book:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@fieldBook"/>
                                                    </td>
                                                </tr>
                                               <tr>
                                                    <th align="right" lang="en">Style Name:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@styleName"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Rod Stadia:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@rodStadia"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Lower Stadia:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@lowerStadia"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Upper Stadia:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@upperStadia"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Time Stamp:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@timeStamp"/>
                                                    </td>
                                                </tr>
                                                <tr><td colspan="2">&#xa0;</td></tr>
                                            </xsl:for-each>
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
            You must have at least one field book in Project Explorer (Survey) which contains a minimum of one Survey Observation to get results from this report.
	</p>

<p class="normal1">For best results, run the report from the Details panel.  Select All Observations in Project Explorer, which populates the Details panel. Highlight the row(s) to be included in the report, right click, and select Report on Selected Items.
</p>
<p class="normal1">Running the report from the generic survey report tool, or right clicking on a graphic only reports on the individually selected element. 
</p>
            <p class="normal1">Once the Civil Report Browser is open, you can select any other Survey Observations report, which utilizes the same data as the original report.</p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
