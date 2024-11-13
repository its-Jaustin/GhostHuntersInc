
--Step 1: Database Schema Creation

--GhostTypes table
CREATE TABLE GhostType (
	g_type varchar(20) PRIMARY KEY
);
INSERT INTO GhostTypes (g_type) VALUES --INSERT ghost types IN here
	('Demon'),
	('Spirit'),
	('Deogen'),
	('Mare'),
	('Hantu'),
	('Phantom'),
	('The Twins')
;

--Ghost table
CREATE TABLE Ghost (
    ghostID INT PRIMARY KEY,
    name VARCHAR(50),
    --insert your ghost types in here this list will be the same as
    haunting_type VARCHAR(50) CHECK IN GhostTypes --since this ONLY has one ATTRIBUTE it should act AS a SEQUENCE / list
    spookiness_level INT,
    speed INT
);

--Hunter table
CREATE TABLE Hunter (
    hunterID INT PRIMARY KEY,
    name VARCHAR(50),
    experience_level VARCHAR(50),
    specialty_type VARCHAR(50),
    speed INT
);

--Equipment table
CREATE TABLE Equipment (
    equipmentID INT PRIMARY KEY,
    equipment_type VARCHAR(50),
    model VARCHAR(50),
    detection_type VARCHAR(50),
    working BOOLEAN
);

--Location table
CREATE TABLE Location (
    locationID INT PRIMARY KEY,
    building VARCHAR(100),
    room VARCHAR(50),
    vacancy VARCHAR(50),
    construction_date DATE
);

--Evidence TABLE *weak entity*
CREATE TABLE Evidence (
    evidenceID INT PRIMARY KEY,
    locationID INT,
    equipmentID INT,
    date DATE,
    time TIME
);

Equipment_Detects_Ghost relationship table
CREATE TABLE Equipment_Detects_Ghost (
    equipmentID INT,
    ghostID INT,
    PRIMARY KEY (equipmentID, ghostID),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID),
    FOREIGN KEY (ghostID) REFERENCES Ghost(ghostID)
);

Hunter_Uses_Equipment relationship table
CREATE TABLE Hunter_Uses_Equipment (
    hunterID INT,
    equipmentID INT,
    PRIMARY KEY (hunterID, equipmentID),
    FOREIGN KEY (hunterID) REFERENCES Hunter(hunterID),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
);

Ghost_FavoriteLocation_Location relationship table
CREATE TABLE Ghost_FavoriteLocation_Location (
    ghostID INT,
    locationID INT,
    PRIMARY KEY (ghostID, locationID),
    FOREIGN KEY (ghostID) REFERENCES Ghost(ghostID),
    FOREIGN KEY (locationID) REFERENCES Location(locationID)
);

Hunter_Records_Evidence relationship table
CREATE TABLE Hunter_Records_Evidence (
    hunterID INT,
    evidenceID INT,
    PRIMARY KEY (hunterID, evidenceID),
    FOREIGN KEY (hunterID) REFERENCES Hunter(hunterID),
    FOREIGN KEY (evidenceID) REFERENCES Evidence(evidenceID)
);


--Step 2: Insert Sample Data


--Insert data into the Ghost table
--ghostID, name, haunting_type, spookiness_level INT, speed INT
INSERT INTO Ghost VALUES (1, 'Lady in Red', 'Residual Haunt', 9, 2);
INSERT INTO Ghost VALUES (2, 'The Screamer', 'Poltergeist', 10, 5);
INSERT INTO Ghost VALUES (3, 'Shadow Man', 'Shadow Person', 8, 4);
INSERT INTO Ghost VALUES (4, 'The Whisper', 'Intelligent Haunt', 7, 3);
INSERT INTO Ghost VALUES (5, 'The Jester', 'Demonic', 10, 6);
INSERT INTO Ghost VALUES (6, 'Purple Guy', 'Poltergeist', )



--Insert data into the Evidence table
--evidenceID, locationID, equipmentID, date DATE, time TIME
INSERT INTO Evidence VALUES (1, 1, 2, '2024-10-01', '23:15');
INSERT INTO Evidence VALUES (2, 3, 4, '2024-10-10', '00:30');
INSERT INTO Evidence VALUES (3, 2, 1, '2024-10-15', '21:45');
INSERT INTO Evidence VALUES (4, 4, 3, '2024-10-20', '02:10');
INSERT INTO Evidence VALUES (5, 2, 2, '2024-11-01', '19:00');

--Insert data into the Equipment table
--equipmentID, type, model , detection_type, working BOOLEAN
INSERT INTO Equipment VALUES (1, 'EMF Reader', 'GhostMeter Pro', 'Electromagnetic', TRUE);
INSERT INTO Equipment VALUES (2, 'Camera', 'NightSight 3000', 'Visual', TRUE);
INSERT INTO Equipment VALUES (3, 'Thermometer', 'ColdSpot', 'Temperature', FALSE);
INSERT INTO Equipment VALUES (4, 'Recorder', 'EVP Catcher', 'Audio', TRUE);
INSERT INTO Equipment VALUES (5, 'Spirit Box', 'Whisperer', 'Audio', TRUE);

--Insert data into the Location TABLE
--locationID, building, room, vacancy, construction_date DATE
INSERT INTO Location VALUES (1, 'Old Mill', 'Boiler Room', 'Abandoned', '1890-01-01');
INSERT INTO Location VALUES (2, 'Queen Hotel', 'Suite 304', 'Occupied', '1920-01-01');
INSERT INTO Location VALUES (3, 'Smith Mansion', 'Attic', 'Abandoned', '1915-01-01');
INSERT INTO Location VALUES (4, 'Lincoln Church', 'Crypt', 'Abandoned', '1850-01-01');
INSERT INTO Location VALUES (5, 'Downtown Library', 'Basement', 'Occupied', '1940-01-01');


--Insert data into the Hunter table
--hunterID, name, experience_level, specialty_type, speed INT
INSERT INTO Hunter VALUES (1, 'Alex Marks', 'Expert', 'Poltergeist', 4);
INSERT INTO Hunter VALUES (2, 'Jamie Lee', 'Intermediate', 'Shadow Person', 3);
INSERT INTO Hunter VALUES (3, 'Morgan Hale', 'Beginner', 'Residual Haunt', 2);
INSERT INTO Hunter VALUES (4, 'Pat Jordan', 'Expert', 'Intelligent Haunt', 5);
INSERT INTO Hunter VALUES (5, 'Taylor Reid', 'Novice', 'Demonic', 3);


Insert data into relationship tables
INSERT INTO Hunter_Records_Evidence VALUES (1, 1);
INSERT INTO Hunter_Records_Evidence VALUES (2, 2);
INSERT INTO Hunter_Records_Evidence VALUES (3, 3);
INSERT INTO Hunter_Records_Evidence VALUES (4, 4);
INSERT INTO Hunter_Records_Evidence VALUES (5, 5);

INSERT INTO Equipment_Detects_Ghost VALUES (1, 2);
INSERT INTO Equipment_Detects_Ghost VALUES (2, 3);
INSERT INTO Equipment_Detects_Ghost VALUES (3, 4);
INSERT INTO Equipment_Detects_Ghost VALUES (4, 1);
INSERT INTO Equipment_Detects_Ghost VALUES (5, 5);

INSERT INTO Hunter_Uses_Equipment VALUES (1, 1);
INSERT INTO Hunter_Uses_Equipment VALUES (1, 2);
INSERT INTO Hunter_Uses_Equipment VALUES (2, 3);
INSERT INTO Hunter_Uses_Equipment VALUES (3, 4);
INSERT INTO Hunter_Uses_Equipment VALUES (4, 1);
INSERT INTO Hunter_Uses_Equipment VALUES (5, 5);

INSERT INTO Ghost_FavoriteLocation_Location VALUES (1, 1);
INSERT INTO Ghost_FavoriteLocation_Location VALUES (2, 2);
INSERT INTO Ghost_FavoriteLocation_Location VALUES (3, 3);
INSERT INTO Ghost_FavoriteLocation_Location VALUES (4, 4);
INSERT INTO Ghost_FavoriteLocation_Location VALUES (5, 5);
```

--Step 3: Sample Queries

--1. Retrieve the spookiest or quickest ghosts recorded by each hunter.
   
   SELECT Hunter.name AS hunter_name, Ghost.name AS ghost_name, 
          Ghost.spookiness_level, Ghost.speed
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment_Detects_Ghost ON Evidence.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   ORDER BY Ghost.spookiness_level DESC, Ghost.speed DESC;
   

--2. List all ghost sightings that used specific equipment.

   
   SELECT Hunter.name AS hunter_name, Ghost.name AS ghost_name, Equipment.type AS equipment_type, 
          Evidence.date, Evidence.time
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment ON Evidence.equipmentID = Equipment.equipmentID
   JOIN Equipment_Detects_Ghost ON Equipment.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   WHERE Equipment.type = 'Camera';
   

--3. Find the top-rated hunters based on the spookiness of the ghosts they’ve sighted.

   
   SELECT Hunter.name AS hunter_name, 
          AVG(Ghost.spookiness_level) AS avg_spookiness
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment_Detects_Ghost ON Evidence.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   GROUP BY Hunter.name
   ORDER BY avg_spookiness DESC;
  

--4. Find all sightings in abandoned locations.


   SELECT Hunter.name AS hunter_name, Ghost.name AS ghost_name, Location.building, Location.room
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Location ON Evidence.locationID = Location.locationID
  

 JOIN Equipment_Detects_Ghost ON Evidence.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   WHERE Location.vacancy = 'Abandoned';


--5. Retrieve the locations most frequented by specific ghosts.

   SELECT Ghost.name AS ghost_name, Location.building, Location.room
   FROM Ghost
   JOIN Ghost_FavoriteLocation_Location ON Ghost.ghostID = Ghost_FavoriteLocation_Location.ghostID
   JOIN Location ON Ghost_FavoriteLocation_Location.locationID = Location.locationID
   ORDER BY Ghost.name;











































--Sample Queries

--1. Retrieve the spookiest or quickest ghosts recorded by each hunter.

   ```sql
   SELECT Hunter.name AS hunter_name, Ghost.name AS ghost_name, 
          Ghost.spookiness_level, Ghost.speed
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment_Detects_Ghost ON Evidence.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   ORDER BY Ghost.spookiness_level DESC, Ghost.speed DESC;
   ```

--2. Find ghost sightings with specific equipment.

   ```sql
   SELECT Hunter.name AS hunter_name, Ghost.name AS ghost_name, Equipment.type AS equipment_type, 
          Evidence.date, Evidence.time
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment ON Evidence.equipmentID = Equipment.equipmentID
   JOIN Equipment_Detects_Ghost ON Equipment.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   WHERE Equipment.type = 'Camera';
   ```

--3. List top-rated hunters based on spookiness of ghosts they’ve sighted.

   
   SELECT Hunter.name AS hunter_name, 
          AVG(Ghost.spookiness_level) AS avg_spookiness
   FROM Hunter
   JOIN Hunter_Records_Evidence ON Hunter.hunterID = Hunter_Records_Evidence.hunterID
   JOIN Evidence ON Hunter_Records_Evidence.evidenceID = Evidence.evidenceID
   JOIN Equipment_Detects_Ghost ON Evidence.equipmentID = Equipment_Detects_Ghost.equipmentID
   JOIN Ghost ON Equipment_Detects_Ghost.ghostID = Ghost.ghostID
   GROUP BY Hunter.name
   ORDER BY avg_spookiness DESC;
   ```

