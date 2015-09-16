/* 
 * This file is normally called from create-db.sql to create the tables.
 * 
 * DATA FROM: http://www.data.gov.uk/dataset/road-accidents-safety-data
 * 
 * TEST CASE accident_index=2011350754511 cycle/car serious 
 *           accident_index=2011350551611 ped/bus fatal
 */

-- accident table lookup tables
CREATE TABLE Accident_Severity (code smallint PRIMARY KEY, label text );
CREATE TABLE Day_of_Week (code smallint PRIMARY KEY, label text );
CREATE TABLE Light_Conditions (code smallint PRIMARY KEY, label text );
CREATE TABLE Local_Authority_District (code smallint PRIMARY KEY, label text );
CREATE TABLE Local_Authority_Highway (code text PRIMARY KEY, label text );
CREATE TABLE Ped_Cross_Human (code smallint PRIMARY KEY, label text );
CREATE TABLE Ped_Cross_Physical (code smallint PRIMARY KEY, label text );
CREATE TABLE Urban_Rural (code smallint PRIMARY KEY, label text );
CREATE TABLE Police_Force (code smallint PRIMARY KEY, label text );
CREATE TABLE Police_Officer_Attend (code smallint PRIMARY KEY, label text );
CREATE TABLE Road_Class (code smallint PRIMARY KEY, label text );
CREATE TABLE Road_Type (code smallint PRIMARY KEY, label text );
CREATE TABLE Junction_Detail (code smallint PRIMARY KEY, label text );
CREATE TABLE Junction_Control (code smallint PRIMARY KEY, label text );

--casualty table lookup tables
CREATE TABLE Casualty_Class (code smallint PRIMARY KEY, label text );
CREATE TABLE Casualty_Severity (code smallint PRIMARY KEY, label text );
CREATE TABLE Casualty_Type (code smallint PRIMARY KEY, label text );
CREATE TABLE Ped_Location (code smallint PRIMARY KEY, label text );
CREATE TABLE Ped_Movement (code smallint PRIMARY KEY, label text );
CREATE TABLE Age_Band (code smallint PRIMARY KEY, label text );

--vehicle lookup tables
CREATE TABLE Junction_Location (code smallint PRIMARY KEY, label text );
CREATE TABLE Sex_of_Driver (code smallint PRIMARY KEY, label text );
CREATE TABLE Vehicle_Location (code smallint PRIMARY KEY, label text );
CREATE TABLE Vehicle_Manoeuvre (code smallint PRIMARY KEY, label text );
CREATE TABLE Vehicle_Type (code smallint PRIMARY KEY, label text );

-- other
/*
CREATE TABLE Point_of_Impact (code smallint PRIMARY KEY, label text );
CREATE TABLE Journey_Purpose (code smallint PRIMARY KEY, label text );
CREATE TABLE Junction_Location (code smallint PRIMARY KEY, label text );
*/

CREATE TABLE accident
(
Accident_Index text PRIMARY KEY,
Location_Easting_OSGR integer,
Location_Northing_OSGR integer,
Longitude double precision,
Latitude double precision,
Police_Force smallint REFERENCES Police_Force(code),
Accident_Severity smallint REFERENCES Accident_Severity(code),
Number_of_Vehicles smallint,
Number_of_Casualties smallint,
Date date,
Day_of_Week smallint REFERENCES Day_of_Week(code),
Time time,
Local_Authority_District smallint REFERENCES Local_Authority_District(code),
Local_Authority_Highway text REFERENCES Local_Authority_Highway(code),
First_Road_Class smallint,
First_Road_Number smallint,
Road_Type smallint,
Speed_limit smallint,
Junction_Detail smallint,
Junction_Control smallint,
Second_Road_Class smallint,
Second_Road_Number smallint,
Ped_Cross_Human smallint REFERENCES Ped_Cross_Human(code),
Ped_Cross_Physical smallint REFERENCES Ped_Cross_Physical(code),
Light_Conditions smallint REFERENCES Light_Conditions(code),
Weather_Conditions smallint,
Road_Surface_Conditions smallint,
Special_Conditions_at_Site smallint,
Carriageway_Hazards smallint,
Urban_Rural smallint REFERENCES Urban_Rural(code),
Police_Officer_Attend smallint REFERENCES Police_Officer_Attend(code),
LSOA_of_Accident_Location text
);
CREATE INDEX acc_idx ON accident(accident_index, police_force, local_authority_district);


CREATE TABLE casualty
(
Accident_Index text REFERENCES accident(Accident_Index),
Vehicle_Reference smallint,
Casualty_Reference smallint,
Casualty_Class smallint,
Sex_of_Casualty smallint REFERENCES Sex_of_Driver(code),
Age_of_Casualty smallint,
Age_Band_of_Casualty smallint REFERENCES Age_Band(code),
Casualty_Severity smallint,
Ped_Location smallint REFERENCES Ped_Location(code),
Ped_Movement smallint REFERENCES Ped_Movement(code),
Car_Passenger smallint,
Bus_or_Coach_Passenger smallint,
Pedestrian_Road_Maintenance_Worker smallint,
Casualty_Type smallint,
Casualty_Home_Area_Type smallint,
CONSTRAINT casualty_pk PRIMARY KEY(Accident_Index,Vehicle_Reference,Casualty_Reference)
);
CREATE INDEX cas_idx ON casualty(accident_index, casualty_type);

CREATE TABLE vehicle 
(
Accident_Index text REFERENCES accident(Accident_Index),
Vehicle_Reference smallint,
Vehicle_Type smallint REFERENCES Vehicle_Type(code),
Towing_and_Articulation smallint,
Vehicle_Manoeuvre smallint REFERENCES Vehicle_Manoeuvre(code),
Vehicle_Location_Restricted_Lane smallint,
Junction_Location smallint REFERENCES Junction_Location(code),
Skidding_and_Overturning smallint,
Hit_Object_in_Carriageway smallint,
Vehicle_Leaving_Carriageway smallint,
Hit_Object_off_Carriageway smallint,
First_Point_of_Impact smallint,
Was_Vehicle_Left_Hand_Drive smallint,
Journey_Purpose_of_Driver smallint,
Sex_of_Driver smallint REFERENCES Sex_of_Driver(code),
Age_of_Driver smallint,
Age_Band_of_Driver smallint,
Engine_Capacity_CC bigint,
Propulsion_Code smallint,
Age_of_Vehicle smallint,
Driver_IMD_Decile smallint,
Driver_Home_Area_Type smallint,
CONSTRAINT vehicle_pk PRIMARY KEY(Accident_Index,Vehicle_Reference)
);
CREATE INDEX veh_idx ON vehicle(accident_index, vehicle_reference);
CREATE INDEX vehtype_idx ON vehicle(vehicle_type);


-- Holds more friendly local names of road references (eg C123 = High Street, My Town)
CREATE TABLE road_name
(
    Road_Class smallint,
    Road_Number smallint,
    Road_Name text
);
