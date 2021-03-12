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
​
CREATE TABLE "nps_comments" (
    "Park" varchar   NOT NULL,
    "State" varchar   NOT NULL,
    "Year" date   NOT NULL,
    "CollectedDate" date   NOT NULL,
    "Comments" varchar   NOT NULL
);
​
CREATE TABLE "nps_summary" (
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
​
ALTER TABLE "reservations" ADD CONSTRAINT "fk_reservations_Park" FOREIGN KEY("Park")
REFERENCES "nps_comments" ("Park");
​
ALTER TABLE "reservations" ADD CONSTRAINT "fk_reservations_FacilityState" FOREIGN KEY("FacilityState")
REFERENCES "nps_summary" ("State");
​
ALTER TABLE "nps_comments" ADD CONSTRAINT "fk_nps_comments_Park" FOREIGN KEY("Park")
REFERENCES "nps_summary" ("Park");
​
ALTER TABLE "nps_comments" ADD CONSTRAINT "fk_nps_comments_State" FOREIGN KEY("State")
REFERENCES "reservations" ("FacilityState");
​
ALTER TABLE "nps_summary" ADD CONSTRAINT "fk_nps_summary_Park" FOREIGN KEY("Park")
REFERENCES "reservations" ("Park");
​
ALTER TABLE "nps_summary" ADD CONSTRAINT "fk_nps_summary_Year" FOREIGN KEY("State", "Year")
REFERENCES "nps_comments" ("State", "Year");

select count(*) from reservations

drop table reservations

select * from nps_summary

select count(*) from nps_summary
drop table nps_summary