<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Template Component Constraints Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Template Component Constraints Report</title>
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
                                <h2 lang="en">Template Component Constraints Report</h2>
                                <p lang="en">
                                    Report Created:&#xa0; <xsl:value-of select="cif:date()"/><br/>
                                    Time:&#xa0; <xsl:value-of select="cif:time()"/>
                                </p>
                            </center>
                            <!-- Template Library Data -->
                            <xsl:for-each select="TemplateLibrary">
                                <table class="margin" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <th align="right" lang="en">File Name:&#xa0; </th>
                                            <td align="left"><xsl:value-of select="@fileName"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr/>
                                <!-- Template Information -->
                                <table style="font-size: 90%" width="100%">
                                    <xsl:for-each select="//Category[Template]">
                                        <tr>
                                            <td><strong>Category:&#xa0; </strong><xsl:value-of select="@name"/></td>
                                        </tr>
                                        <tr style="line-height:75%"><td><hr size="1"/></td></tr>
                                        <tr>
                                            <td>
                                                <table class="margin" style="font-size: 90%" width="95%">
                                                    <xsl:for-each select="Template">
                                                        <tr>
                                                            <td lang="en">
                                                                <strong>Template:&#xa0; </strong><xsl:value-of select="@name"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td lang="en">
                                                                <strong>Description:&#xa0; </strong><xsl:value-of select="@description"/>
                                                            </td>
                                                        </tr>
                                                        <tr style="line-height:75%"><td><hr size="1"/></td></tr>
                                                        <tr>
                                                            <td>
                                                                <table class="margin" style="font-size: 90%" width="95%">
                                                                    <colgroup span="9">
                                                                        <col width="19%"/>
                                                                        <col width="7%"/>
                                                                        <col width="7%"/>
                                                                        <col width="12%"/>
                                                                        <col width="11%"/>
                                                                        <col width="19%"/>
                                                                        <col width="11%"/>
                                                                        <col width="7%"/>
                                                                        <col width="7%"/>
                                                                    </colgroup>
                                                                    <xsl:for-each select="Components/Component">
                                                                        <tr>
                                                                            <td colspan="9" lang="en">
                                                                                <strong>Component:&#xa0; </strong>
                                                                                <xsl:value-of select="@name"/>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="9" lang="en">
                                                                                <strong>Description:&#xa0; </strong>
                                                                                <xsl:value-of select="@description"/>
                                                                            </td>
                                                                        </tr>
                                                                        <xsl:if test="@type = 'EndCondition'">
                                                                            <tr>
                                                                                <td colspan="9" lang="en">
                                                                                    <strong>End Condition Type:&#xa0; </strong>
                                                                                    <xsl:value-of select="EndConditionTarget/@targetType"/>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="9" lang="en">
                                                                                    <strong>End Condition Target:&#xa0; </strong>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="EndConditionTarget/@targetName = ''">
                                                                                            not specified
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <xsl:value-of select="EndConditionTarget/@targetName"/>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                        <tr>
                                                                            <th class="underline" align="left" lang="en" rowspan="2" valign="bottom">
                                                                                Point Name<br/>Feature Name
                                                                            </th>
                                                                            <th class="underline" lang="en" rowspan="2" valign="bottom">
                                                                                Style
                                                                            </th>
                                                                            <th class="underline" lang="en" rowspan="2" valign="bottom">
                                                                                X<br/>Y
                                                                            </th>
                                                                            <th colspan="3" lang="en" valign="bottom">
                                                                                - - - - Constraints - - - -
                                                                            </th>
                                                                            <th class="underline" lang="en" rowspan="2" valign="bottom">
                                                                                Slope
                                                                            </th>
                                                                            <th class="underline" lang="en" rowspan="2" valign="bottom">
                                                                                Width
                                                                            </th>
                                                                            <th class="underline" lang="en" rowspan="2" valign="bottom">
                                                                                Delta Y
                                                                            </th>
                                                                        </tr>
                                                                        <tr>
                                                                            <th class="underline" lang="en" valign="bottom">Type</th>
                                                                            <th class="underline" lang="en" valign="bottom">Value</th>
                                                                            <th class="underline" lang="en" valign="bottom">Parent</th>
                                                                        </tr>
                                                                        <xsl:for-each select="Vertex">
                                                                            <xsl:variable name="nextPoint" select="following-sibling::*[1]/@name"/>
                                                                            <xsl:variable name="width" select="../../../Points/Point[@name = $nextPoint]/@x - ../../../Points/Point[@name = current()/@name]/@x"/>
                                                                            <xsl:variable name="depth" select="../../../Points/Point[@name = $nextPoint]/@y - ../../../Points/Point[@name = current()/@name]/@y"/>
                                                                            <tr>
                                                                                <td>
                                                                                    <xsl:value-of select="@name"/><br/>
                                                                                    <xsl:value-of select="../../../Points/Point[@name = current()/@name]/@featureName"/>
                                                                                </td>
                                                                                <td>
                                                                                    <xsl:value-of select="../../../Points/Point[@name = current()/@name]/@style"/>
                                                                                </td>
                                                                                <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                    <xsl:value-of select="cif:distanceFormat(number(../../../Points/Point[@name = current()/@name]/@x))"/>
                                                                                    <br/>
                                                                                    <xsl:value-of select="cif:distanceFormat(number(../../../Points/Point[@name = current()/@name]/@y))"/>
                                                                                </td>
                                                                                <td class="sidepad">
                                                                                    <xsl:value-of select="../../../Points/Point[@name = current()/@name]/Constraint[1]/@type"/><br/>
                                                                                    <xsl:value-of select="../../../Points/Point[@name = current()/@name]/Constraint[2]/@type"/>
                                                                                </td>
                                                                                <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[1]/@type = 'Slope'">
                                                                                            <xsl:value-of select="cif:gradeFormat(number(../../../Points/Point[@name = current()/@name]/Constraint[1]/@value))"/><br/>
                                                                                        </xsl:when>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[1]/@type = 'None'">
                                                                                            &#xa0;<br/>&#xa0;
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <xsl:value-of select="cif:distanceFormat(number(../../../Points/Point[@name = current()/@name]/Constraint[1]/@value))"/><br/>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[2]/@type = 'Slope'">
                                                                                            <xsl:value-of select="cif:gradeFormat(number(../../../Points/Point[@name = current()/@name]/Constraint[2]/@value))"/>
                                                                                        </xsl:when>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[1]/@type = 'None'">
                                                                                            &#xa0;<br/>&#xa0;
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <xsl:value-of select="cif:distanceFormat(number(../../../Points/Point[@name = current()/@name]/Constraint[1]/@value))"/><br/>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </td>
                                                                                <td>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[1]/@parent">
                                                                                            <xsl:value-of select="../../../Points/Point[@name = current()/@name]/Constraint[1]/@parent"/><br/>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>&#xa0;<br/></xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="../../../Points/Point[@name = current()/@name]/Constraint[2]/@parent">
                                                                                            <xsl:value-of select="../../../Points/Point[@name = current()/@name]/Constraint[2]/@parent"/>
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>&#xa0;</xsl:otherwise>
                                                                                    </xsl:choose>
                                                                                </td>
                                                                            </tr>
                                                                            <xsl:choose>
                                                                                <xsl:when test="position() != last()">
                                                                                    <tr>
                                                                                        <td colspan="6">&#xa0;</td>
                                                                                        <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                            <xsl:value-of select="cif:gradeFormat(number($depth div $width))"/>
                                                                                        </td>
                                                                                        <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                            <xsl:value-of select="cif:distanceFormat(number($width))"/>
                                                                                        </td>
                                                                                        <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                            <xsl:value-of select="cif:distanceFormat(number($depth))"/>
                                                                                        </td>
                                                                                    </tr>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:variable name="firstPoint" select="preceding-sibling::*[last()]/@name"/>
                                                                                    <xsl:variable name="finalWidth" select="../../../Points/Point[@name = $firstPoint]/@x - ../../../Points/Point[@name = current()/@name]/@x"/>
                                                                                    <xsl:variable name="finalDepth" select="../../../Points/Point[@name = $firstPoint]/@y - ../../../Points/Point[@name = current()/@name]/@y"/>
                                                                                    <xsl:if test="../@isClosed = 'true'">
                                                                                        <tr>
                                                                                            <td colspan="6">&#xa0;</td>
                                                                                            <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                                <xsl:value-of select="cif:gradeFormat(number($finalDepth div $finalWidth))"/>
                                                                                            </td>
                                                                                            <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                                <xsl:value-of select="cif:distanceFormat(number($finalWidth))"/>
                                                                                            </td>
                                                                                            <td class="sidepad" align="right" style="white-space:nowrap">
                                                                                                <xsl:value-of select="cif:distanceFormat(number($finalDepth))"/>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </xsl:if>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:for-each>
                                                                        <xsl:if test="@displayExpression != ''">
                                                                            <tr>
                                                                                <td colspan="2">Display Expression:&#xa0; </td>
                                                                                <td colspan="7">
                                                                                    <xsl:value-of select="@displayExpression"/>
                                                                                </td>
                                                                            </tr>
                                                                        </xsl:if>
                                                                        <tr style="line-height:75%"><td colspan="9"><hr size="1"/></td></tr>
                                                                        <tr style="line-height:75%"><td colspan="9">&#xa0;</td></tr>
                                                                    </xsl:for-each>
                                                                    <tr>
                                                                        <td colspan="9">
                                                                            <xsl:for-each select="DisplayRules">
                                                                                <table style="font-size:100%" width="100%">
                                                                                    <tbody>
                                                                                        <tr><th align="left" colspan="7" lang="en">Display Rules</th></tr>
                                                                                        <tr>
                                                                                            <th lang="en">Name</th>
                                                                                            <th lang="en">Description</th>
                                                                                            <th lang="en">Type</th>
                                                                                            <th lang="en">Point 1</th>
                                                                                            <th lang="en">Point 2</th>
                                                                                            <th lang="en">Test</th>
                                                                                            <th lang="en">Value</th>
                                                                                        </tr>
                                                                                        <xsl:for-each select="DisplayRule">
                                                                                            <tr>
                                                                                                <td><xsl:value-of select="@name"/></td>
                                                                                                <td><xsl:value-of select="@descripton"/></td>
                                                                                                <td><xsl:value-of select="@type"/></td>
                                                                                                <td><xsl:value-of select="@point1"/></td>
                                                                                                <td><xsl:value-of select="@point2"/></td>
                                                                                                <td><xsl:value-of select="@test"/></td>
                                                                                                <td>
                                                                                                    <xsl:value-of select="cif:distanceFormat(number(@value))"/>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </xsl:for-each>
                                                                                        <tr style="line-height:75%"><td colspan="9"><hr size="1"/></td></tr>
                                                                                        <tr style="line-height:75%"><td colspan="9">&#xa0;</td></tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </xsl:for-each>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td>&#xa0;</td></tr>
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
                You must open a Template Library file by selecting <em>File &gt; Open</em> on the 
                <em>Report Browser</em> menu and setting the <em>Files of type</em> field to <em>Template 
                Library (*.itl)</em>.
            </p>
            <p class="normal1" lang="en">
                You must also have at least one template defined in the <em>Modeler &gt; Create Template
                </em> command to get results from this report.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
