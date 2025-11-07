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
                <title lang="en">Survey Field Book Report</title>
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
                                <h2 lang="en">Survey Field Book Report</h2>
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
                                <!-- Cogo Point Data -->
                                <table class="margin" cellpadding="2" cellspacing="2" width="80%">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th class="underline" lang="en" align="left">Name</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Control<br/>Points</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Data<br/>Files</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Chains</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Points</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Setups</th>
                                            <th class="underline" lang="en" align="right">Number<br/>of<br/>Observations</th>
                                        </tr>
                                    </thead>
                                    <xsl:for-each select="SurveyDatasetList">
                                        <tbody>
                                            <xsl:for-each select="SurveyDataset">
                                                <tr>
                                                    <td align="left">
                                                        <xsl:value-of select="@name"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfControlPoints"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfDataFiles"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfChains"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfPoints"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfSetups"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="@numberOfObservations"/>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </tbody>
                                    </xsl:for-each>
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
                     You must have at least one field book in Project Explorer (Survey) which contains processed adjustment to get results from this report.
	</p>

<p class="normal1">  In Project Explorer, ensure the green icon is to the right of Adjustments (indicating completed processing). Right-click on Adjustment, select Adjustment Results and the desired report. </p>
            <p class="normal1">Once the Civil Report Browser is open, you can select any other Adjustment report.</p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
