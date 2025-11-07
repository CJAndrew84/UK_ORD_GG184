This blank workspace folder can be used to store report style sheets.

By default reports are read from:
C:\Program Files\Bentley\OpenRoads Designer CONNECT Edition\OpenRoadsDesigner\Default\Reports\...
  
IMPORTANT:  If any .xsl file exists in the Organization-Civil/Reports folder, 
            then reports are read from there instead of \Program Files\ folder.

To use your own customized style sheets, the following is recommended:

1. Copy the entire folder structure, files in the Reports folder, and 
   all subfolders under the Reports folder located here:
   
   C:\Program Files\Bentley\OpenRoads Designer CONNECT Edition\OpenRoadsDesigner\Default\Reports\
      
   ...to your Organizational Reports folder structure (i.e.):
   
   C:\ProgramData\Bentley\OpenRoads Designer CE\Configuration\Organization-Civil\MyDOT_Standards\Reports\

2. For custom style sheets that were developed prior to OpenRoads Designer CONNECT Edition,
   it is likely you will need to run the migration utility to upgrade your style sheet.
   The migration utility can be found here:
   C:\ProgramData\Bentley\OpenRoads Designer CE\Configuration\Organization-Civil\Migration Utilities\XSL Style Sheets Converter\
   
   