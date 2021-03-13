-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/mH3E2h
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
​
-- Modify this code to update the DB schema diagram.
-- -     - one TO one
-- -<    - one TO many
-- >-    - many TO one
-- >-<   - many TO many
-- For this ERD, all relationships are many to many
​
CREATE TABLE "reservations" (
    "OrderNumber" varchar   NOT NULL,
    "Park" varchar  ,
    "SiteType" varchar   ,
    "FacilityID" int   ,
    "FacilityState" varchar   ,
    "StartDate" date   ,
    "EndDate" date   ,
    "NumberOfPeople" float  
);

ALTER TABLE reservations
ADD Primary Key ("OrderNumber");

​
CREATE TABLE "nps_summary" (
	"ID" serial  primary key,
    "Park" varchar   NOT NULL,
    "State" varchar   ,
    "Year" int   NOT NULL,
    "Month" varchar   NOT NULL,
    "Recreation_ Visitors" int   ,
    "Non_Recreation_Visitors" int   ,
    "Recreation_Visitor_Hours" int   ,
    "Non_Recreation_Hours" int   ,
    "Concession_Lodging" int   ,
    "Tent_Campers" int   ,
    "RV_Campers" int   ,
    "Backcountry_Campers" int   ,
    "Misc_Campers" int  ,
    "Total_Overnight_Stays" int 
);

CREATE TABLE "nps_comments" (
	"ID" serial  primary key,
    "Park" varchar   ,
    "State" varchar   ,
    "Year" int   ,
    "CollectedDate" date   ,
    "Comments" varchar   NOT NULL
);

CREATE TABLE "geocode_info" (
    "RegionDescription" varchar   ,
    "Park" varchar   NOT NULL,
    "FacilityID" int   ,
    "FacilityState" varchar   ,
    "FacilityLongitude" int   ,
    "FacilityLatitude" int   ,
    "CityPlace" varchar  ,
    "County" varchar   
);

ALTER TABLE geocode_info
ADD Primary Key ("FacilityID");

-- drop table reservations

SELECT * FROM reservations 
WHERE "SiteType" = 'TENT ONLY NONELECTRIC' ;


select count(*) from reservations

-- drop table nps_summary

select * from nps_summary

select count(*) from nps_summary

-- drop table geocode_info

select * from geocode_info

select count(*) from geocode_info

-- drop table nps_comments

select * from nps_comments

select count(*) from nps_comments


-- Kevin wants to go tent camping with 15 family members. Where can he camp in Colorado?

SELECT * FROM reservations 
WHERE "NumberOfPeople" >= 15 and "SiteType" = 'TENT ONLY NONELECTRIC';

-- Sara loves tent camping, but only with a group of friends! She wants to know if there is a location at Sand Dunes where she can tent camp.
select "Park","FacilityID", "SiteType"
from reservations
where "SiteType"='GROUP TENT ONLY AREA NONELECTRIC' 
AND "FacilityID" IN
	(select  "FacilityID"
	 from geocode_info
	 where  "RegionDescription"='Great Sand Dunes NP & PRES')
Group BY "Park", "FacilityID", "SiteType"

-- Leah hates crowds but loves camping. She wants to find out which campground is the least busy at rocky mountian national park.
select "Park","FacilityID", count("OrderNumber") 
from reservations
where "FacilityID" IN
	(select  "FacilityID"
	 from geocode_info
	 where  "RegionDescription"='Rocky Mountain NP')
Group BY "Park", "FacilityID"
Order BY count("OrderNumber") ASC

-- Adrienne has decided to go to Mesa Verde national park. She wants to know what people are saying about that park?
Select "Park", "CollectedDate", "Comments"
FROM nps_comments
Where "Park"='Mesa Verde NP'
Order By "CollectedDate" DESC


