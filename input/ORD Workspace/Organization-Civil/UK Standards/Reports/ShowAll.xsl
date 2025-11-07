<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">
    <xsl:param name="xslShowHelp" select="cif:xslShowHelp"/>
    <xsl:param name="xslRootDirectory" select="cif:xslRootDirectory"/>
    <!-- Show All -->
    <xsl:template match="/">
        <xsl:variable name="gridOut" select="cif:SetGridOut(number(InRoads/@outputGridScaleFactor))"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="{$xslRootDirectory}/_Themes/engineer/theme.css"/>
                <!--Title displayed in browser Title Bar-->
                <title lang="en">Show All</title>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test="$xslShowHelp = 'true'">
                        <xsl:call-template name="StyleSheetHelp"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <table border="1" cellpadding="2" cellspacing="0" style="font-size: 80%">
                            <xsl:apply-templates/>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="*">
        <xsl:variable name="Level">
            <xsl:number count="*" level="multiple" from="/"/>
        </xsl:variable>
        <tr>
            <xsl:call-template name="AddCells">
                <xsl:with-param name="level-numbers" select="$Level"/>
            </xsl:call-template>
            <th align="left"><xsl:value-of select="name()"/></th>
            <td><xsl:value-of select="."/></td>
        </tr>
        <xsl:if test="@*">
            <tr>
                <td> &#xa0;</td>
                <xsl:call-template name="AddCells">
                    <xsl:with-param name="level-numbers" select="$Level"/>
                </xsl:call-template>
                <xsl:apply-templates select="@*" mode="AttName"/>
            </tr>
            <tr>
                <td> &#xa0;</td>
                <xsl:call-template name="AddCells">
                    <xsl:with-param name="level-numbers" select="$Level"/>
                </xsl:call-template>
                <xsl:apply-templates select="@*" mode="AttValue"/>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template match="*[node()]">
        <xsl:variable name="Level">
            <xsl:number count="*" level="multiple" from="/"/>
        </xsl:variable>
        <tr>
            <xsl:call-template name="AddCells">
                <xsl:with-param name="level-numbers" select="$Level"/>
            </xsl:call-template>
            <th align="left"><xsl:value-of select="name()"/></th>
            <td><xsl:value-of select="."/></td>
        </tr>
        <xsl:if test="@*">
            <tr>
                <td> &#xa0;</td>
                <xsl:call-template name="AddCells">
                    <xsl:with-param name="level-numbers" select="$Level"/>
                </xsl:call-template>
                <xsl:apply-templates select="@*" mode="AttName"/>
            </tr>
            <tr>
                <td> &#xa0;</td>
                <xsl:call-template name="AddCells">
                    <xsl:with-param name="level-numbers" select="$Level"/>
                </xsl:call-template>
                <xsl:apply-templates select="@*" mode="AttValue"/>
            </tr>
        </xsl:if>
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    <xsl:template match="@*" mode="AttName">
        <th align="left" valign="top"><em><xsl:value-of select="name()"/></em></th>
    </xsl:template>
    <xsl:template match="@*" mode="AttValue">
        <td nowrap="nowrap" valign="top"><xsl:value-of select="."/></td>
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
                This generic style sheet displays the contents of any XML data file in a hierarchical 
                table, but it works best when values are stored in attributes rather than in elements.
            </p>
            <p class="small" lang="en">
                <em>&#xa9; 2018 Bentley Systems, Inc</em>
            </p>
        </div>
    </xsl:template>
</xsl:stylesheet>
