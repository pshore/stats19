
-- Assumes the currrent working directory is the root of the stats19 project.

TRUNCATE accident, casualty, vehicle,
  Accident_Severity, Day_of_Week, Light_Conditions, Local_Authority_District, Local_Authority_Highway, Ped_Cross_Human, Ped_Cross_Physical, Urban_Rural, Police_Force, Police_Officer_Attend,
  Road_Class, Road_Type, Junction_Detail, Junction_Control,
  Casualty_Class, Casualty_Severity, Casualty_Type, Ped_Location, Ped_Movement, Age_Band,
  Junction_Location, Sex_of_Driver, Vehicle_Location, Vehicle_Manoeuvre, Vehicle_Type;

-- lookup table data  

\COPY Accident_Severity FROM data/lookup-tables/Accident_Severity.csv CSV HEADER
\COPY Day_of_Week FROM data/lookup-tables/Day_of_Week.csv CSV HEADER
\COPY Light_Conditions FROM data/lookup-tables/Light_Conditions.csv CSV HEADER
\COPY Local_Authority_District FROM data/lookup-tables/Local_Authority_District.csv CSV HEADER
\COPY Local_Authority_Highway FROM data/lookup-tables/Local_Authority_Highway.csv CSV HEADER
\COPY Ped_Cross_Human FROM data/lookup-tables/Ped_Cross_Human.csv CSV HEADER
\COPY Ped_Cross_Physical FROM data/lookup-tables/Ped_Cross_Physical.csv CSV HEADER
\COPY Urban_Rural FROM data/lookup-tables/Urban_Rural.csv CSV HEADER
\COPY Police_Force FROM data/lookup-tables/Police_Force.csv CSV HEADER
\COPY Police_Officer_Attend FROM data/lookup-tables/Police_Officer_Attend.csv CSV HEADER

\COPY Road_Class FROM data/lookup-tables/Road_Class.csv CSV HEADER
\COPY Road_Type FROM data/lookup-tables/Road_Type.csv CSV HEADER
\COPY Junction_Detail FROM data/lookup-tables/Junction_Detail.csv CSV HEADER
\COPY Junction_Control FROM data/lookup-tables/Junction_Control.csv CSV HEADER

\COPY Casualty_Class FROM data/lookup-tables/Casualty_Class.csv CSV HEADER
\COPY Casualty_Severity FROM data/lookup-tables/Casualty_Severity.csv CSV HEADER
\COPY Casualty_Type FROM data/lookup-tables/Casualty_Type.csv CSV HEADER
\COPY Ped_Location FROM data/lookup-tables/Ped_Location.csv CSV HEADER
\COPY Ped_Movement FROM data/lookup-tables/Ped_Movement.csv CSV HEADER
\COPY Age_Band FROM data/lookup-tables/Age_Band.csv CSV HEADER

\COPY Junction_Location FROM data/lookup-tables/Junction_Location.csv CSV HEADER
\COPY Sex_of_Driver FROM data/lookup-tables/Sex_of_Driver.csv CSV HEADER
\COPY Vehicle_Location FROM data/lookup-tables/Vehicle_Location.csv CSV HEADER
\COPY Vehicle_Manoeuvre FROM data/lookup-tables/Vehicle_Manoeuvre.csv CSV HEADER
\COPY Vehicle_Type FROM data/lookup-tables/Vehicle_Type.csv CSV HEADER


-- big data

-- Since 2014 the data is provided in one big file Stats19_Data_2005-2014.zip
-- Unzipped, contains these 3:

\COPY Accident FROM data/core-tables/Accidents0514.csv CSV HEADER
\COPY Casualty FROM data/core-tables/Casualties0514.csv CSV HEADER
\COPY Vehicle FROM data/core-tables/Vehicles0514.csv CSV HEADER
