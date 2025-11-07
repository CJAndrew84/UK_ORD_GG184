<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <xsl:variable name="uniqueObjectName" select="//ClearancePoints/ClearancePoint[not (@objectName = preceding-sibling::ClearancePoint/@objectName)]/@objectName"/>
    <!-- Horizontal Alignment Review Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title>Feature to Feature Clearance Report</title>
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
                                <h2 lang="en">Feature to Feature Clearance Report</h2>
                                <p lang="en">
                                    Report Created: &#xa0;<xsl:value-of select="cif:date()"/><br/>
                                    Time: &#xa0;<xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <xsl:for-each select="GeometryProject/HorizontalAlignment/ClearancePoints">
                                <table class="margin" width="90%" border="1" cellpadding="3" cellspacing="0">
                                    <thead style="display:table-header-group">
                                        <tr>
                                            <th lang="en" valign="bottom">Chainage</th>
                                            <th lang="en" valign="bottom">Feature<br/><xsl:value-of select="$uniqueObjectName[1]"/></th>
                                            <th lang="en" valign="bottom">Feature<br/><xsl:value-of select="$uniqueObjectName[2]"/></th>
                                            <th lang="en" valign="bottom">Height<br/>Difference</th>
                                            <th lang="en" valign="bottom">Average<br/>Area</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="ClearancePoint[@objectName = $uniqueObjectName[1]]">
                                            <xsl:variable name="ftr1Elev" select="offsetPoint/@elevation"/>
                                            <xsl:variable name="ftr2Elev" select="following-sibling::*[centerLinePoint/point/station/@internalStation = current()/centerLinePoint/point/station/@internalStation][not (@objectName = $uniqueObjectName[1])]/offsetPoint/@elevation"/>
                                            <xsl:variable name="curDifference" select="$ftr2Elev - $ftr1Elev"/>
                                            <xsl:variable name="prevFtr1Elev" select="preceding-sibling::*[1]/offsetPoint/@elevation"/>
                                            <xsl:variable name="prevFtr2Elev" select="following-sibling::*[centerLinePoint/point/station/@internalStation = current()/preceding-sibling::*[1]/centerLinePoint/point/station/@internalStation][not (@objectName = $uniqueObjectName[1])]/offsetPoint/@elevation"/>
                                            <xsl:variable name="prevDifference" select="$prevFtr2Elev - $prevFtr1Elev"/>
                                            <tr>
                                                <td align="center">
                                                    <xsl:value-of select="cif:stationFormat(number(centerLinePoint/point/station/@externalStation), string(centerLinePoint/point/station/@externalStationName))"/>
                                                </td>
                                                <td align="center">
                                                    <xsl:value-of select="cif:ordinateFormat(number($ftr2Elev))"/>
                                                </td>
                                                <td align="center">
                                                    <xsl:value-of select="cif:ordinateFormat(number($ftr1Elev))"/>
                                                </td>
                                                <td align="center">
                                                    <xsl:value-of select="cif:ordinateFormat(number($curDifference))"/>
                                                </td>
                                                <td align="center">
                                                    <xsl:choose>
                                                        <xsl:when test="position() = 1">
                                                            <xsl:value-of select="cif:areaFormat(number(($curDifference) * (following-sibling::*/centerLinePoint/point/station/@internalStation - centerLinePoint/point/station/@internalStation) div 2))"/>
                                                        </xsl:when>
                                                        <xsl:when test="position() = last()">
                                                            <xsl:value-of select="cif:areaFormat(number(($curDifference) * (centerLinePoint/point/station/@internalStation - preceding-sibling::*[1]/centerLinePoint/point/station/@internalStation) div 2))"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="cif:areaFormat(number((($curDifference + $prevDifference) div 2) * (following-sibling::*/centerLinePoint/point/station/@internalStation - centerLinePoint/point/station/@internalStation)))"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
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
                You must also include <strong>two</strong> features on the <em>Features</em> leaf.
            </p>
            <p class="normal1" lang="en">
                This style sheet compares the elevations of two features and calculates the average area 
                between the two.&#xa0; It may not display correctly if more than two features are 
                contained in the XML data file.&#xa0; The two features should be approximately parallel to 
                the alignment or feature selected on the <em>General</em> leaf.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
