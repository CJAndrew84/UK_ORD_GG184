<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Template List Report -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!-- Title displayed in browser Title Bar -->
                <title lang="en">Template List Report</title>
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
                                <h2 lang="en">Template List Report</h2>
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
                                <table>
                                    <tbody>
                                        <xsl:apply-templates select="//Category | //Template"/>
                                    </tbody>
                                </table>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="Category">
        <xsl:variable name="Level">
            <xsl:number count="*" level="multiple" from="/"/>
        </xsl:variable>
        <tr>
            <xsl:call-template name="AddCells">
                <xsl:with-param name="level-numbers" select="$Level"/>
            </xsl:call-template>
            <th align="right" lang="en">Category: &#xa0;</th>
            <td><xsl:value-of select="@name"/></td>
        </tr>
        <xsl:apply-templates/>
        <tr><td>&#xa0;</td></tr>
    </xsl:template>
    <xsl:template match="Template">
        <xsl:variable name="Level">
            <xsl:number count="*" level="multiple" from="/"/>
        </xsl:variable>
        <xsl:if test="position() = 1">
            <tr>
                <xsl:call-template name="AddCells">
                    <xsl:with-param name="level-numbers" select="$Level"/>
                </xsl:call-template>
                <th align="left" lang="en">Template Name</th>
                <th align="left" lang="en">Last Revised</th>
            </tr>
        </xsl:if>
        <tr>
            <xsl:call-template name="AddCells">
                <xsl:with-param name="level-numbers" select="$Level"/>
            </xsl:call-template>
            <td>
                <xsl:value-of select="@name"/>
                <xsl:if test="@description != ''">
                    &#xa0; - &#xa0;<xsl:value-of select="@description"/>
                </xsl:if>
            </td>
            <td><xsl:value-of select="concat(@lastRevisedBy, '  ', @lastRevisedDate)"/></td>
        </tr>
    </xsl:template>
    <xsl:template name="AddCells">
        <xsl:param name="level-numbers"/>
        <xsl:variable name="first" select="substring-before($level-numbers, '.')"/>
        <xsl:variable name="rest" select="substring-after($level-numbers, '.')"/>
        <xsl:if test="$rest">
            <td> &#xa0;</td>
            <xsl:call-template name="AddCells">
                <xsl:with-param name="level-numbers" select="$rest"/>
            </xsl:call-template>
        </xsl:if>
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
