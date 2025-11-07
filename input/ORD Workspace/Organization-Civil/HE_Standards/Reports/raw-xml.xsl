<?xml version="1.0"?>
<!-- Generic stylesheet for viewing XML -->
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Raw View of XML Data</title>
            </head>
            <body>
                <div style="font-size:10pt; margin-bottom:2em">
                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="*">
        <div style="margin-left:2em; color:blue">
            &lt;<span style="color:green"><xsl:value-of select="name()"/></span><xsl:text>&#xa0;</xsl:text><xsl:apply-templates select="@*"/>/&gt;
        </div>
    </xsl:template>
    <xsl:template match="*[node()]">
        <div style="margin-left:2em; color:blue">
            &lt;<span style="color:green"><xsl:value-of select="name()"/><xsl:text>&#xa0;</xsl:text><xsl:apply-templates select="@*"/></span>&gt;
            <xsl:apply-templates select="node()"/>
            &lt;/<span style="color:green"><xsl:value-of select="name()"/></span>&gt;
        </div>
    </xsl:template>
    <xsl:template match="@*">
        <span style="color:blue">
            <span style="color:maroon"><xsl:value-of select="name()"/></span>="<span style="color:black; font-weight:bold"><xsl:value-of select="."/></span>"
        </span>
    </xsl:template>
    <xsl:template match="comment()">
        <div style="margin-left:2em; color:blue">
            &lt;!--<span style="color:gray"><xsl:value-of select="."/></span>--&gt;
        </div>
    </xsl:template>
    <xsl:template match="processing-instruction()">
        <div style="margin-left:2em; color:gray">
            &lt;?<xsl:value-of select="."/>?&gt;
        </div>
    </xsl:template>
    <xsl:template match="text()">
        <span style="color:black; font-weight:bold"><xsl:value-of select="."/></span>
    </xsl:template>
</xsl:stylesheet>
