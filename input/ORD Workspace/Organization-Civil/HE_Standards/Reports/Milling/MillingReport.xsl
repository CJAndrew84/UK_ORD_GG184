<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Roadway Design Milling Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Template Drops with Constraints Report</title>
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
                                <h2 lang="en">Milling Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <hr/>
                            <!-- Project Data -->
                            <xsl:for-each select="RoadwayDesignProject">
                                <!-- Milling Station Data -->
                                <table class="margin" cellpadding="2" cellspacing="4" width="90%">
                                    <thead>
                                        <tr>
                                            <th class="underline" align="right" lang="en">Chainage</th>
                                            <th class="underline" align="right" lang="en">Left Offset/<br/>Elevation</th>
                                            <th class="underline" align="right" lang="en">Right Offset/<br/>Elevation</th>
                                            <th class="underline" align="right" lang="en">Planar Area</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="MillingStations/MillingStation/MillingComponents">
                                            <xsl:for-each select="MillingComponent">
                                                <tr>
                                                    <td align="right" valign="top">
                                                        <xsl:choose>
                                                            <xsl:when test="position() = 1">
                                                                <xsl:value-of select="cif:stationFormat(number(../../@externalStation), string(../../@externalStationName))"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>&#xa0;</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                    <td align="right" valign="top">
                                                        <xsl:for-each select="OffsetValues">
                                                            <xsl:value-of select="cif:distanceFormat(number(@leftOffset))"/><br/>
                                                            <xsl:value-of select="cif:ordinateFormat(number(@leftElevation))"/><br/>
                                                        </xsl:for-each>
                                                        <br/>
                                                    </td>
                                                    <td align="right" valign="top">
                                                        <xsl:for-each select="OffsetValues">
                                                            <xsl:value-of select="cif:distanceFormat(number(@rightOffset))"/><br/>
                                                            <xsl:value-of select="cif:ordinateFormat(number(@rightElevation))"/><br/>
                                                        </xsl:for-each>
                                                        <br/>
                                                    </td>
                                                    <td align="right" valign="top">
                                                        <xsl:choose>
                                                            <xsl:when test="position() = last()">
                                                                <xsl:value-of select="cif:areaFormat(number(sum(..//@planarArea)) )"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>&#xa0;</xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                </tr>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                        <tr><th colspan="4"><hr/></th></tr>
                                        <tr>
                                            <th align="right" colspan="3">Total Planar Area:</th>
                                            <td align="right">
                                                <xsl:value-of select="cif:areaFormat(number(sum(//MillingComponent/@planarArea)))"/>
                                            </td>
                                        </tr>
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
                You must have at least one Overlay/Stripping component with the Stripping flag set.&#xa0; 
                This component will represent the milling.&#xa0; Also, a Process All should be performed 
                before creating a Milling report.
            </p>
            <p class="normal1" lang="en">
                The report is generated from the <em>Milling 
                Report</em> command.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
