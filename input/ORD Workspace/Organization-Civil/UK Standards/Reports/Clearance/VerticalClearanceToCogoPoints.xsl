<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Vertical Clearance from Alignment to Cogo Points Report -->
    <xsl:variable name="uniqueClearanceAlignments" select="//ClearancePoints/ClearancePoint[not(@clearanceAlignmentName = preceding-sibling::ClearancePoint/@clearanceAlignmentName )]/@clearanceAlignmentName"/>
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Vertical Clearance from Alignment to Cogo Points Report</title>
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
                                <h2 lang="en">Vertical Clearance from Alignment to Cogo Points Report</h2>
                                <p lang="en">
                                    Report Created: &#xa0;<xsl:value-of select="cif:date()"/><br/>
                                    Time: &#xa0;<xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Project Data -->
                            <xsl:for-each select="GeometryProject">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@description"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="@file"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Baseline Alignment:&#xa0; </th>
                                            <td align="left" colspan="2"><xsl:value-of select="HorizontalAlignment/@name"/></td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%"><xsl:value-of select="../@inputGridScaleFactor" /></td>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr />
                                <!-- Clearance Points from Cogo Data -->
                                <xsl:for-each select="HorizontalAlignment/ClearancePoints">
                                    <table class="margin" cellpadding="2" width="90%">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th align="left" colspan="2" lang="en" valign="bottom"><br/>Clearance Alignment:<br/></th>
                                                <td align="left" colspan="8" valign="bottom"><xsl:value-of select="."/></td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Name</th>
                                                <th colspan="3" lang="en">- - - - - - Cogo Point - - - - - -</th>
                                                <th colspan="4" lang="en">- - - - - - - - Centerline Point - - - - - - - -</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Horizontal<br/>Offset</th>
                                                <th class="underline" lang="en" rowspan="2" valign="bottom">Vertical<br/>Difference</th>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en">X</th>
                                                <th class="underline" lang="en">Y</th>
                                                <th class="underline" lang="en">Z</th>
                                                <th class="underline" lang="en">Chainage</th>
                                                <th class="underline" lang="en">X</th>
                                                <th class="underline" lang="en">Y</th>
                                                <th class="underline" lang="en">Z</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="ClearancePoint[@origin = 'point'][offsetPoint]">
                                                <xsl:sort select="centerLinePoint/point/station/@internalStation" data-type="number"/>
                                                <tr>
                                                    <td align="center">
                                                        <xsl:value-of select="offsetPoint/@name"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@easting))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@northing))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@elevation))"/>
                                                    </td>
                                                    <td align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@easting))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@northing))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(centerLinePoint/point/@elevation))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:distanceFormat(number(@firstOffset))"/>
                                                    </td>
                                                    <td align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number(offsetPoint/@elevation - centerLinePoint/point/@elevation))"/>
                                                    </td>
                                                </tr>
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
                You must create clearance points for this report by selecting <em>Tools &gt; XML Reports 
                &gt; Clearance</em>.
            </p>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment or feature on the <em>General</em> leaf 
                in the <em>From</em> fields.
            </p>
            <p class="normal1" lang="en">
                You must also include at least one cogo point on the <em>Cogo Points</em> leaf.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
