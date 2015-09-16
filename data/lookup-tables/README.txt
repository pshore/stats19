The DfT provides a "Lookup up tables for variables" XLS file at the same
location as the main data.

  http://data.gov.uk/dataset/road-accidents-safety-data

The contents of this folder are a manual extraction from each tab of that 
spreadsheet, with the following modifications:


1st_Road_Class and 2nd_Road_Class tabs are identical - saved in Road_Class.csv


1st_Point_of_Impact has been saved in Point_of_Impact.csv


To fix foreign key reference errors, the following tables have had a -1 option added:
 "-1,Data missing or out of range"

  Age_Band.csv
  Casualty_Class.csv
  Police_Officer_Attend.csv
  


