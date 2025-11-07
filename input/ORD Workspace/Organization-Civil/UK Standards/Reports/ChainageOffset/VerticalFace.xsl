<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:variable name="uniqueOffsetAlignment" select="//StationOffsetPoints/StationOffsetPoint[not (@offsetAlignmentName = preceding-sibling::StationOffsetPoint/@offsetAlignmentName)]/@offsetAlignmentName"/>
    <xsl:variable name="totalArea" select="0"/>

    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <title lang="en">Vertical Face Report</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="InRoads">
                            <center>
                                <h2 lang="en">Vertical Face Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>

                            <xsl:for-each select="GeometryProject">
                                <table class="margin" cellpadding="2" width="90%">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Project:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@name"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Description:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@description"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="@file"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Last Revised:&#xa0; </th>
                                            <td align="left" colspan="2">
                                                <xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en" style="font-size: 80%">Input Grid Factor:&#xa0; </th>
                                            <td align="left" style="font-size: 80%">
                                                <xsl:value-of select="../@inputGridScaleFactor" />
                                            </td>
                                            <td align="right" lang="en" style="font-size: 80%">
                                                <strong>Note:&#xa0; </strong>All units in this report are in
                                                <xsl:if test="//@linearUnits = 'Imperial'">feet</xsl:if>
                                                <xsl:if test="//@linearUnits = 'Metric'">meters</xsl:if>
                                                unless specified otherwise.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>

                                <table class="margin" cellpadding="2" width="80%">
                                    <xsl:for-each select="HorizontalAlignment[StationOffsetPoints]">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <td colspan="5" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; Alignment Name:&#xa0; </strong>
                                                    <xsl:value-of select="@name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5" lang="en">
                                                    <strong>Alignment Description:&#xa0; </strong>
                                                    <xsl:value-of select="@description"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5" lang="en">
                                                    <strong>&#xa0; &#xa0; &#xa0; &#xa0; &#xa0; &#xa0;Alignment Style:&#xa0; </strong>
                                                    <xsl:value-of select="@style"/>
                                                    <br/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5">&#xa0;</td>
                                            </tr>
                                            <tr>
                                                <th class="underline" lang="en" valign="bottom">Chainage</th>
                                                <th class="underline" lang="en" valign="bottom">
                                                    Elevation<br/>Feature 1<br/>
                                                    (<xsl:value-of select="$uniqueOffsetAlignment[1]"/>)
                                                </th>
                                                <th class="underline" lang="en" valign="bottom">
                                                    Elevation<br/>Feature 2<br/>
                                                    (<xsl:value-of select="$uniqueOffsetAlignment[2]"/>)
                                                </th>
                                                <th class="underline" lang="en" valign="bottom">Difference</th>
                                                <th class="underline" lang="en" valign="bottom">Area</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="StationOffsetPoints/StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[1]]">
                                                <xsl:variable name="curStation" select="centerLinePoint/point/station/@externalStation"/>
                                                <xsl:variable name="curFtr1Elev" select="offsetLinePoint/point/@elevation"/>
                                                <xsl:variable name="curFtr2Elev" select="//StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[2] and centerLinePoint/point/station/@externalStation = current()/centerLinePoint/point/station/@externalStation]/offsetLinePoint/point/@elevation"/>
                                                <xsl:variable name="curDiff" select="$curFtr2Elev - $curFtr1Elev"/>
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number($curStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number($curFtr1Elev))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number($curFtr2Elev))"/>
                                                    </td>
                                                    <td class="sidepad" align="right">
                                                        <xsl:value-of select="cif:ordinateFormat(number($curDiff))"/>
                                                    </td>
                                                    <xsl:choose>
                                                        <xsl:when test="position() = 1">
                                                            <td class="sidepad" align="center">---</td>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:variable name="prvStation" select="preceding-sibling::*[1]/centerLinePoint/point/station/@externalStation"/>
                                                            <xsl:variable name="prvFtr1Elev" select="preceding-sibling::*[1]/offsetLinePoint/point/@elevation"/>
                                                            <xsl:variable name="prvFtr2Elev" select="//StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[2] and centerLinePoint/point/station/@externalStation = current()/preceding-sibling::*[1]/centerLinePoint/point/station/@externalStation]/offsetLinePoint/point/@elevation"/>
                                                            <xsl:variable name="prvDiff" select="$prvFtr2Elev - $prvFtr1Elev"/>
                                                            <xsl:variable name="areaFace" select="(($curDiff + $prvDiff) div 2) * ($curStation - $prvStation)"/>
                                                            <td class="sidepad" align="right">
                                                                <xsl:value-of select="cif:areaFormat(number($areaFace))"/>
                                                            </td>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </tr>
                                            </xsl:for-each>
                                            <tr>
                                                <td class="sidepad" colspan="5">
                                                    <hr size="1"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="sidepad" align="right" colspan="4" lang="en">Total:&#xa0; </th>
                                                <td class="sidepad" align="right">
                                                    <xsl:variable name="faceAreas">
                                                        <xsl:for-each select="//StationOffsetPoints/StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[1]]">
                                                            <xsl:choose>
                                                                <xsl:when test="position() = 1"/>
                                                                <xsl:otherwise>
                                                                    <xsl:variable name="curStation" select="centerLinePoint/point/station/@externalStation"/>
                                                                    <xsl:variable name="curFtr1Elev" select="offsetLinePoint/point/@elevation"/>
                                                                    <xsl:variable name="curFtr2Elev" select="//StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[2] and centerLinePoint/point/station/@externalStation = current()/centerLinePoint/point/station/@externalStation]/offsetLinePoint/point/@elevation"/>
                                                                    <xsl:variable name="curDiff" select="$curFtr2Elev - $curFtr1Elev"/>
                                                                    <xsl:variable name="prvStation" select="preceding-sibling::*[1]/centerLinePoint/point/station/@externalStation"/>
                                                                    <xsl:variable name="prvFtr1Elev" select="preceding-sibling::*[1]/offsetLinePoint/point/@elevation"/>
                                                                    <xsl:variable name="prvFtr2Elev" select="//StationOffsetPoint[@offsetAlignmentName = $uniqueOffsetAlignment[2] and centerLinePoint/point/station/@externalStation = current()/preceding-sibling::*[1]/centerLinePoint/point/station/@externalStation]/offsetLinePoint/point/@elevation"/>
                                                                    <xsl:variable name="prvDiff" select="$prvFtr2Elev - $prvFtr1Elev"/>
                                                                    <number>
                                                                        <xsl:value-of select="(($curDiff + $prvDiff) div 2) * ($curStation - $prvStation)"/>
                                                                    </number>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </xsl:variable>
                                                    <xsl:value-of select="cif:areaFormat(number(sum(msxsl:node-set($faceAreas)/number)))"/>
                                                </td>
                                            </tr>
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
                This report is designed to work best with one base alignment (or feature) and two offset
                features at an interval specified by the user.&#xa0; Other XML data may not give
                satisfactory results.
            </p>
            <p class="normal1" lang="en">
                You must create station offset points for this report by selecting <em>
                    Tools &gt; XML
                    Reports &gt; Station Base
                </em>.
            </p>
            <p class="normal1" lang="en">
                You must include at least one horizontal alignment or one feature on the <em>General</em>
                leaf in the <em>From</em> fields.&#xa0; You must also include two features on the
                <em>Features</em> leaf.
            </p>
            <p class="normal1" lang="en">
                You must choose at least one option on the <em>Include</em> leaf (<em>
                    Horizontal On-
                    Alignment Points, Horizontal Event Points, Vertical On-Alignment Points, Vertical Event
                    Points
                </em> or <em>Interval</em>.)
            </p>
            <p class="normal1" lang="en">
                <em>Station Limits</em> only apply to computed data, ie, event points by interval.
            </p>
            <p class="normal1" lang="en">
                It is very important that the two offset features have data at each station.&#xa0; If any
                data is missing for either one, <em>NaN</em> (Not a Number) will be displayed.&#xa0; Also,
                the sum function cannot properly sum if any value is not a number, so it will also display
                <em>NaN</em>.&#xa0; The easiest way to fix issues like this is to find the station offset
                points outside the desired range, based on the value in
                <code>centerLinePoint/point/station/@externalStation</code> and delete them from the XML
                data file.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
