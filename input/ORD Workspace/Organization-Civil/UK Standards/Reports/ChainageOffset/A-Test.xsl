<?xml version="1.0"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:cif="cif">

  <xsl:key name="chainages" match="StationOffsetPoints/StationOffsetPoint/centerLinePoint/point/station" use="@internalStation"/>

  <xsl:template match="/">
  <html>
    <table border="1">

	  <tbody>
	  
     <xsl:for-each select="//StationOffsetPoint/centerLinePoint/point/station[generate-id(.)=generate-id(key('chainages', @internalStation)[1])]">
        <xsl:sort select="@internalStation" data-type="number"/> 
		<xsl:sort select="//StationOffsetPoint/@firstOffset" data-type="number"/>
		<tr>
		
        <!--      <xsl:text> Outer </xsl:text> <xsl:value-of select="//StationOffsetPoint/@firstOffset"/>  -->
		</tr>
		
        <xsl:for-each select="key('chainages', @internalStation)">
        
          <tr>
			<td>
				<xsl:value-of select="position()"/>
			</td>
				
              <td valign="center" >
                  <xsl:value-of select="count(key('chainages', @internalStation))"/>
                <b>
                  <xsl:text>  - Chainage </xsl:text><xsl:value-of select="@internalStation"/>
                </b>
              </td>

            <td align="right">
              
              <xsl:text> Hello </xsl:text> <xsl:value-of select="//StationOffsetPoint/@firstOffset[position"/>
            </td>
          </tr>
        </xsl:for-each>  
      </xsl:for-each>  
		</tbody>
    </table>
	</html>
  </xsl:template>

</xsl:stylesheet>