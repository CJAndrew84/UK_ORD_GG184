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
                <title lang="en">Survey Setup Report</title>
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
                                <h2 lang="en">Survey Setup Report</h2>
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
                                <!-- Survey Setup Data -->
                                <xsl:for-each select="SurveyStationList">
                                    <table class="margin" cellpadding="2" cellspacing="1" width="100%">
                                        <colgroup span="2">
                                            <col width="30%"/>
                                            <col width="70%"/>
                                        </colgroup>
                                        <tbody>
                                            <xsl:for-each select="SurveyStation">
                                                <tr>
                                                    <th align="right" lang="en">Name:&#xa0; </th>
                                                    <td><xsl:value-of select="@name"/></td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Instrument Height:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:distanceFormat(number(@instrumentHeight))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Occupied Point:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@occupiedPoint"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">BackSight Point:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@backSightPoint"/>
                                                    </td>                                                    
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">BackSight Direction:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:angularFormat(number(@backSightDirection))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">BackSight Type:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@backSightType"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Circle:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:angularFormat(number(@circle))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Std. Error Direction:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="cif:angularFormat(number(@standardErrorDirection))"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Data File:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@dataFile"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="right" lang="en">Field Book:&#xa0; </th>
                                                    <td>
                                                        <xsl:value-of select="@fieldBook"/>
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
                You must have at least one field book in Project Explorer (Survey) which contains a minimum of one survey setup to get results from this report.
	</p>

<p class="normal1">For best results, run the report from the Details panel. Select All Setups in Project Explorer, which populates the Details panel.  Highlight the row(s) to be included in the report, right click, and select Report on Selected Items.
</p>
<p class="normal1">Running the report from the generic survey report tool, or right clicking on a graphic only reports on the individually selected element. 


            </p>
            <p class="normal1">Once the Civil Report Browser is open, you can select any other setup report, which utilizes the same data as the original report.</p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
