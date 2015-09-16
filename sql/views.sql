/* 
 * This file is normally called from create-db.sql to create the views.
 * 
 * Below are some views that try to simplify many of the queries.
 * 
 * DATA FROM: http://www.data.gov.uk/dataset/road-accidents-safety-data
 * 
 * TEST CASE accident_index=2011350754511 cycle/car serious 
 *           accident_index=2011350551611 ped/bus fatal
 */

-- shows a combined view of vehicle (labels) involved in each accident
CREATE VIEW accident_vehicle_label AS
 select v.accident_index as accident_index, array_agg(vt.label) as vehicle_labels
 from vehicle v, vehicle_type vt 
 where v.vehicle_type=vt.code 
 group by v.accident_index
 order by accident_index, vehicle_labels;

-- accidents for vulnerables, pedestrians and cyclists.
CREATE VIEW vulnerable_accident AS
  select distinct a.accident_index as accident_index
  from accident a, casualty c 
  where a.accident_index=c.accident_index 
  and c.casualty_type in (0,1);

-- accidents involving pedestrians.
CREATE VIEW pedestrian_accident AS
  select distinct a.accident_index as accident_index
  from accident a, casualty c 
  where a.accident_index=c.accident_index 
  and c.casualty_type in (0);

-- accidents involving cyclists.
CREATE VIEW cycle_accident AS
  select distinct a.accident_index as accident_index
  from accident a, casualty c 
  where a.accident_index=c.accident_index 
  and c.casualty_type in (1);

-- Create a view of the critical accident properties with some labels conveniently joined.
CREATE OR REPLACE VIEW accidentv AS
	SELECT
	Accident_Index,
	Location_Easting_OSGR,
	Location_Northing_OSGR,
	Longitude,
	Latitude,
	Police_Force,
    asv.label as accident_severity,
	Number_of_Vehicles,
	Number_of_Casualties,
	Date,
	Day_of_Week,
	Time,
	Local_Authority_District,
	Local_Authority_Highway,
	rc1.label as First_Road_Class,
	First_Road_Number,
	rt.label as Road_Type,
	Speed_limit,
	jd.label as Junction_Detail,
	jc.label as Junction_Control,
	rc2.label as Second_Road_Class,
	Second_Road_Number,
	Ped_Cross_Human,
	Ped_Cross_Physical,
	lc.label as light_conditions,
	Weather_Conditions,
	Road_Surface_Conditions,
	Special_Conditions_at_Site,
	Carriageway_Hazards,
	Urban_Rural,
	Police_Officer_Attend,
	LSOA_of_Accident_Location
	FROM accident
	left outer join accident_severity asv on (accident_severity=asv.code)
	left outer join light_conditions lc on (light_conditions=lc.code)
    left outer join road_class rc1 on (first_road_class=rc1.code)
    left outer join road_class rc2 on (second_road_class=rc2.code)
    left outer join road_type rt on (road_type=rt.code)
    left outer join junction_detail jd on (junction_detail=jd.code)
    left outer join junction_control jc on (junction_control=jc.code)
;

-- Create a view of the critical casulalty properties with some labels conveniently joined.
CREATE OR REPLACE VIEW casualtyv AS
  SELECT
	Accident_Index,
	Vehicle_Reference,
	Casualty_Reference,
	Casualty_Class,
	Sex_of_Casualty,
	ab.label as Age_Band_of_Casualty,
	cs.label as casualty_severity,
	pl.label as Ped_Location,
	pm.label as Ped_Movement,
	Car_Passenger,
	Bus_or_Coach_Passenger,
	Pedestrian_Road_Maintenance_Worker,
	ct.label as casualty_type,
	Casualty_Home_Area_Type
  FROM casualty
    left join casualty_severity cs on (casualty_severity=cs.code)
    left join casualty_type ct on (casualty_type=ct.code)
    left join ped_location pl on (ped_location=pl.code)
    left join ped_movement pm on (ped_movement=pm.code)
    left join age_band ab on (age_band_of_casualty=ab.code)
;

-- Create a view of the critical vehicle properties with some labels conveniently joined.
CREATE OR REPLACE VIEW vehiclev AS
	SELECT
	Accident_Index,
	Vehicle_Reference,
	vt.label as vehicle_type,
	Towing_and_Articulation,
	Vehicle_Manoeuvre,
	vl.label as Vehicle_Location_Restricted_Lane,
	Junction_Location,
	Skidding_and_Overturning,
	Hit_Object_in_Carriageway,
	Vehicle_Leaving_Carriageway,
	Hit_Object_off_Carriageway,
	First_Point_of_Impact,
	Was_Vehicle_Left_Hand_Drive,
	Journey_Purpose_of_Driver,
	Sex_of_Driver,
	Age_Band_of_Driver,
	Engine_Capacity_CC,
	Propulsion_Code,
	Age_of_Vehicle,
	Driver_IMD_Decile,
	Driver_Home_Area_Type
	FROM vehicle
    left join vehicle_type vt on (vehicle_type=vt.code)
    left join vehicle_location vl on (Vehicle_Location_Restricted_Lane=vl.code)
;

-- find other vehicles involved vulnerable road user accidents.
CREATE OR REPLACE VIEW other_vehicle AS
  select v1.accident_index, v1.vehicle_reference from vehicle v1
  EXCEPT
  select v2.accident_index, v2.vehicle_reference from vehicle v2, casualty c
  where v2.accident_index=c.accident_index
  and c.casualty_type>0
  and v2.vehicle_reference=c.vehicle_reference
;

-- combine the first and second road data into a simplified view.
CREATE OR REPLACE VIEW roads AS
	select a.accident_index, a.accident_severity, rc.label as road_class_label, a.first_road_class as road_class, a.first_road_number as road_number
	from accident a, road_class rc
    where a.first_road_class=rc.code
	UNION ALL
	select a.accident_index, a.accident_severity, rc.label as road_class_label, a.second_road_class as road_class, a.second_road_number as road_number
	from accident a, road_class rc
    where a.second_road_class=rc.code
;

