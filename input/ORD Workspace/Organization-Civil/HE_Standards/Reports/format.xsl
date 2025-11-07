<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:inr="inr">
    <!-- The following Java Script functions are the functions used to format -->
    <!-- the numbers from the InRoads XML data structure.  You can use these  -->
    <!-- as is, or modify or replace them with your own formatting functions. -->
    <!-- These functions are not required to create reports.                  -->
    <msxsl:script implements-prefix="inr" language="JScript">
        <![CDATA[
            // Decimal Separator
            var decSep = ".";
            function SetDecSep( dS )
            {
                decSep = dS;
                return 1;
            }

            // Sets whether to include the angular suffix or not
            var useAngSuffix = false;
            function UseAngSuffix( bAngSuffix )
            {
                useAngSuffix = bAngSuffix;
                return 1;
            }

            // This function formats a number to a specified precision.
            // It pads it with 0's if needed.
            // num - number from the xml
            // prec - number of decimal places after the decimal point
            function formatNumber(num, prec)
            {
                // Make sure we have a valid number
                if (!isNaN(num))
                {
                    if (num < 0)
                    {
                        //takes the absolute value of num
                        var absolutenum = Math.abs(num); 
                        var str = "" + Math.round(absolutenum * Math.pow(10, prec));
                        var absolutenum = Math.abs(num);
                        while (str.length <= prec)
                        {
                            str = "0" + str;
                        }
                        var decpoint = str.length - prec;
                        // replaces the negative sign if the number was
                        // negative
                        if (prec != 0)
                        {
                            return "-" + str.substring(0, decpoint) + decSep + str.substring(decpoint, str.length);
                        }
                        else
                        {
                            return "-" + str;
                        }
                    }
                    else
                    {
                        var str = "" + Math.round (num * Math.pow(10,prec));
                        while (str.length <= prec)
                        {
                            str = "0" + str;
                        }
                        var decpoint = str.length - prec;
                        if (prec != 0)
                        {
                            return str.substring(0, decpoint) + decSep + str.substring(decpoint, str.length);
                        }
                        else
                        {
                            return str;
                        }
                    }
                }
                return num;
            }
            
            // This function sets the format of angular information.
            // n - value from xml
            // format - (1 - "ddd^mm'ss.s", 2 - "ddd.ddd")
            // formatMethod - (1 - Degrees, 2 - Grads, 3 - Radians, 4 - Mils)
            // precision - the number of digits after the decimal point
            function angularFormat(n, format, precision, formatMethod)
            {
                // Checking to see if the number is valid
                if (!isNaN(n))
                {
                    // converts from Radians to Degrees and formats the
                    // value
                    if (formatMethod == 1)
                    {
                        var decdeg = (n * 180) / Math.PI;
                        // format 1 - this converts the number to
                        // "ddd^mm'ss.s"
                        if (format == 1)
                        {
                            // takes only the whole number (ddd)
                            var deg = Math.floor(Math.abs(decdeg));
                            
                            // multiplies the decimal portion time 60 to get the minutes.
                            var decmin = (Math.abs(decdeg) - deg) * 60;
                            
                            // takes only the whole part of that number (mm')
                            var min = Math.floor(decmin);
                            
                            // multiplies the decimal portion time 60 to get the seconds.
                            var decsec = (decmin - min) * 60;
                            
                            // this calls the function that gives the number the correct precision
                            var str = formatNumber(decsec, precision);
                            
                            if (  str.substring(0,2) == "60" )
                            {
                                decsec = 0;
                                str = formatNumber(decsec, precision);
                                min = min+1;
                                if ( min == 60 )
                                {
                                    min = 0;
                                    deg = deg + 1;
                                }
                            }
                                
                            if ( min < 10 )
                            {
                                min = "0" + min;
                            }
                            var sec = str;
                            if ( sec < 10 )
                            {
                                sec = "0" + sec;
                            }
                            
                            var msg;
                            if( decdeg >= 0 || decdeg <= -1 )
                            {
                                if( decdeg < 0 )
                                    msg =  "-" + deg + unescape("%b0") + min + "'" + sec + '"';
                                else
                                    msg =  deg + unescape("%b0") + min + "'" + sec + '"';
                            }
                            else
                                msg =  "-0" + unescape("%b0") + min + "'" + sec + '"';
                                
                            return msg;
                        }
                        // format 2 - "ddd.ddd"
                        if (format == 2)
                        {
                            // this calls the function that gives the
                            // number the correct precision
                            var str = formatNumber(decdeg, precision);
                            if (useAngSuffix == true)
                            {
                                str = str + unescape("%b0");
                            }
                            return str;
                        }
                    }
                    //converts Radians to Grads
                    if (formatMethod == 2)
                    {
                        var radtograd = (n * 200) / Math.PI;
                        var grad = formatNumber(radtograd, precision);
                        if (useAngSuffix == true)
                        {
                            grad = grad + "g";
                        }
                        return grad;
                    }
                    // value in Radians needs to be formated
                    if (formatMethod == 3)
                    {
                        // this calls the function that gives the number
                        // the correct precision
                        var radian = formatNumber(n, precision);
                        if (useAngSuffix == true)
                        {
                            radian = radian + "r";
                        }
                        return radian;
                    }
                    //converts Radians to Mils
                    if (formatMethod == 4 )
                    {
                         var radtomils = n * (6400.0 / (2.0 * Math.PI));
                         var mils = formatNumber( radtomils, precision );
                         return mils;
                    }
                }
                return "";
             }
        ]]>
    </msxsl:script>

    <xsl:variable name="CONVERT_TO_CY" select="'1'"/>
    <xsl:param name="xslConvertToCY" select="$CONVERT_TO_CY"/>
</xsl:stylesheet>
