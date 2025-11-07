<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Sight Visibility Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Sight Visibility Report Alternate</title>
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
                                <h2 lang="en">Sight Visibility Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Sight Visibility Section Data -->
                            <xsl:for-each select="SightVisibilitySection">
                                <xsl:variable name="requiredDist" select="@sightDistanceRequired"/>
                                <xsl:variable name="relaxedDist" select="@sightDistanceRelaxed"/>
                                <table class="margin" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">Sight Visibility Section Name:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="@sectionName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Reference Alignment Name:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="@referenceAlignmentName"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Required Sight Distance:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="cif:distanceFormat(number(@sightDistanceRequired))"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Relaxed Sight Distance:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="cif:distanceFormat(number(@sightDistanceRelaxed))"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Eye Interval:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="cif:distanceFormat(number(@eyeInterval))"/>
                                            </td>
                                            <th align="right" lang="en">Object Interval:&#xa0; </th>
                                            <td align="right">
                                                <xsl:value-of select="cif:distanceFormat(number(@objectInterval))"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="right" lang="en">Eye Offset:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="cif:distanceFormat(number(@eyeOffset))"/>
                                            </td>
                                            <th align="right" lang="en">Object Offset:&#xa0; </th>
                                            <td align="right">
                                                <xsl:value-of select="cif:distanceFormat(number(@objectOffset))"/>
                                            </td>
                                        </tr>
                                        <tr>

                                            <th align="right" lang="en">Eye Height:&#xa0; </th>
                                            <td align="left">
                                                <xsl:value-of select="cif:distanceFormat(number(@eyeHeight))"/>
                                            </td>
                                            <th align="right" lang="en">Object Height:&#xa0; </th>
                                            <td align="right">
                                                <xsl:value-of select="cif:distanceFormat(number(@objectHeight))"/>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Sight Line Information -->
                                <table class="margin" width="50%">
                                    <xsl:for-each select="SightVisibilityLines">
                                        <thead style="display:table-header-group">
                                            <tr>
                                                <th class="underline" lang="en">Eye Position</th>
                                                <th class="underline" lang="en">Object Position</th>
                                                <th class="underline" lang="en">Sight Distance Achieved</th>
                                                <th class="underline" lang="en">Sight Line Status</th>
                                            </tr>
                                        </thead>
                                        <xsl:for-each select="SightLine">
                                            <tbody>
                                                <xsl:choose>
                                                <xsl:when test="@sightLineType = 'Relaxed'">
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap" style="color:orange;">
                                                        <xsl:value-of select="cif:stationFormat(number(EyePositionDistanceAlongReferenceHorizontal/@externalStation), string(EyePositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap" style="color:orange;">
                                                        <xsl:value-of select="cif:stationFormat(number(ObjectPositionDistanceAlongReferenceHorizontal/@externalStation), string(ObjectPositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap" style="color:orange;">
                                                        <xsl:value-of select="cif:distanceFormat(number(@sightDistanceAchieved))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap" style="color:orange;">
                                                        <xsl:value-of select="@sightLineType"/>
                                                    </td>
                                                </tr>
                                                </xsl:when>
                                                    <xsl:when test="@sightLineType = 'Unacceptable'">
                                                        <tr>
                                                            <td class="sidepad" align="right" nowrap="nowrap" style="color:red;">
                                                                <xsl:value-of select="cif:stationFormat(number(EyePositionDistanceAlongReferenceHorizontal/@externalStation), string(EyePositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                            </td>
                                                            <td class="sidepad" align="right" nowrap="nowrap" style="color:red;">
                                                                <xsl:value-of select="cif:stationFormat(number(ObjectPositionDistanceAlongReferenceHorizontal/@externalStation), string(ObjectPositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                            </td>
                                                            <td class="sidepad" align="right" nowrap="nowrap" style="color:red;">
                                                                <xsl:value-of select="cif:distanceFormat(number(@sightDistanceAchieved))"/>
                                                            </td>
                                                            <td class="sidepad" align="right" nowrap="nowrap" style="color:red;">
                                                                <xsl:value-of select="@sightLineType"/>
                                                            </td>
                                                        </tr>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                <tr>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(EyePositionDistanceAlongReferenceHorizontal/@externalStation), string(EyePositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:stationFormat(number(ObjectPositionDistanceAlongReferenceHorizontal/@externalStation), string(ObjectPositionDistanceAlongReferenceHorizontal/@externalStationName))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="cif:distanceFormat(number(@sightDistanceAchieved))"/>
                                                    </td>
                                                    <td class="sidepad" align="right" nowrap="nowrap">
                                                        <xsl:value-of select="@sightLineType"/>
                                                    </td>
                                                </tr>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </tbody>
                                        </xsl:for-each>
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
                You must select a Sight Visibility Section with a minimum of one Sight Line to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
