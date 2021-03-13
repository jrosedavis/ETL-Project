-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/mH3E2h
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- -     - one TO one
-- -<    - one TO many
-- >-    - many TO one
-- >-<   - many TO many
-- For this ERD, all relationships are many to many

CREATE TABLE "reservations" (
    "OrderNumber" varchar   NOT NULL,
    "Park" varchar   NOT NULL,
    "SiteType" varchar   NOT NULL,
    "FacilityID" int   NOT NULL,
    "FacilityState" varchar   NOT NULL,
    "StartDate" date   NOT NULL,
    "EndDate" date   NOT NULL,
    "NumberOfPeople" float   NOT NULL
);

CREATE TABLE "NatPark_All_Comments" (
    "Park" varchar   NOT NULL,
    "State" varchar   NOT NULL,
    "Year" date   NOT NULL,
    "CollectedDate" date   NOT NULL,
    "Comments" varchar   NOT NULL
);

CREATE TABLE "Reverse_GeocodeInfo" (
    "RegionDescription" varchar   NOT NULL,
    "Park" varchar   NOT NULL,
    "FacilityID" int   NOT NULL,
    "FacilityState" varchar   NOT NULL,
    "FacilityLongitude" int   NOT NULL,
    "FacilityLatitude" int   NOT NULL,
    "CityPlace" varchar   NOT NULL,
    "County" varchar   NOT NULL
);

CREATE TABLE "nps_summary" (
    "Park" varchar   NOT NULL,
    "State" varchar   NOT NULL,
    "Year" date   NOT NULL,
    "Month" varchar   NOT NULL,
    "Recreation_Visitors" int   NOT NULL,
    "Non_Recreation_Visitors" int   NOT NULL,
    "Recreation_Visitor_Hours" int   NOT NULL,
    "Non_Recreation_Hours" int   NOT NULL,
    "Concession_Lodging" int   NOT NULL,
    "Tent_Campers" int   NOT NULL,
    "RV_Campers" int   NOT NULL,
    "Backcountry_Campers" int   NOT NULL,
    "Misc_Campers" int   NOT NULL,
    "Total_Overnight_Stays" int   NOT NULL
);

ALTER TABLE "reservations" ADD CONSTRAINT "fk_reservations_Park" FOREIGN KEY("Park")
REFERENCES "Reverse_GeocodeInfo" ("RegionDescription");

ALTER TABLE "reservations" ADD CONSTRAINT "fk_reservations_FacilityState" FOREIGN KEY("FacilityState")
REFERENCES "nps_summary" ("State");

ALTER TABLE "NatPark_All_Comments" ADD CONSTRAINT "fk_NatPark_All_Comments_Park" FOREIGN KEY("Park")
REFERENCES "nps_summary" ("Park");

ALTER TABLE "NatPark_All_Comments" ADD CONSTRAINT "fk_NatPark_All_Comments_State" FOREIGN KEY("State")
REFERENCES "reservations" ("FacilityState");

ALTER TABLE "Reverse_GeocodeInfo" ADD CONSTRAINT "fk_Reverse_GeocodeInfo_RegionDescription" FOREIGN KEY("RegionDescription")
REFERENCES "nps_summary" ("Park");

ALTER TABLE "nps_summary" ADD CONSTRAINT "fk_nps_summary_State_Year" FOREIGN KEY("State", "Year")
REFERENCES "NatPark_All_Comments" ("State", "Year");

