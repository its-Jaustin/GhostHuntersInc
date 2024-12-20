/*
 * Ghost Hunters INC Database Project
 * 
 * This project was worked on by:
 * Mallory Jacobs
 * Austin Jackson
 */


--Step 1: Database Schema Creation

--GhostType table
DROP TABLE IF EXISTS GhostType cascade;
CREATE TABLE  GhostType (
	g_type varchar(20) PRIMARY KEY
);
INSERT INTO GhostType (g_type) VALUES --INSERT ghost types IN here
	('Unknown'),
	('None'),
	('Spirit'),
	('Poltergeist'),
	('Mare'),
	('Demon'),
	('Yokai'),
	('Myling'),
	('Raiju'),
	('Moroi'),
	('Wraith'),
	('Banshee'),
	('Revenant'),
	('Yurei'),
	('Hantu'),
	('Onryo'),
	('Obake'),
	('Deogen'),
	('Phantom'),
	('Jinn'),
	('Shade'),
	('Oni'),
	('Goryo'),
	('The Twins'),
	('The Mimic'),
	('Thaye'),
	('The Screamer'),
	('Apothicon'),
	('Professor')
;
DROP TABLE IF EXISTS Ghost cascade;
--Ghost table
create TABLE Ghost (
    ghostID INT PRIMARY KEY,
    haunting_type VARCHAR(50) not null DEFAULT 'Unknown' REFERENCES GhostType(g_type),
    name VARCHAR(50),
    spookiness_level INT CHECK (spookiness_level BETWEEN 1 AND 10),
    speed INT CHECK (speed BETWEEN 1 AND 5)
);

DROP TABLE IF EXISTS Hunter cascade;
--Hunter table
create TABLE Hunter (
    hunterID INT PRIMARY KEY,
    name VARCHAR(50),
    experience_level VARCHAR(50) check (experience_level in ('Beginner', 'Novice', 'Intermediate','Expert','Master')),
    speed INT CHECK (speed BETWEEN 1 AND 4)
);


DROP TABLE IF EXISTS Equipment cascade;
--Equipment table
create TABLE Equipment (
    equipmentID INT PRIMARY KEY,
    equipment_type VARCHAR(50) NOT null,
    model VARCHAR(50) NOT null,
    working BOOLEAN
);
DROP TABLE IF EXISTS Location cascade;
--Location table
create TABLE Location (
    locationID INT PRIMARY KEY,
    building VARCHAR(100),
    room VARCHAR(50),
    vacancy VARCHAR(50) check (vacancy IN ('Abandoned', 'Occupied')),
    construction_date DATE
);
DROP TABLE IF EXISTS Evidence cascade;
--Evidence TABLE *weak entity*
CREATE TABLE Evidence (
    evidenceID INT primary key,
    locationID INT not null REFERENCES Location(locationID),
    hunterID INT not null REFERENCES Hunter(hunterID),
    equipmentID INT not null REFERENCES Equipment(equipmentID),
    date DATE not null,
    time TIME not null
);

--relationship tables
DROP TABLE IF EXISTS Ghost_is_GhostType;
--Ghost_is_GhostType
CREATE TABLE Ghost_is_GhostType (
	ghostID INT PRIMARY KEY REFERENCES Ghost(ghostID),
	g_type varchar(20) REFERENCES GhostType(g_type) 
);
DROP TABLE IF EXISTS Equipment_Detects_GhostType;
--Equipment_Detects_GhostType relationship table
CREATE TABLE Equipment_Detects_GhostType (
    equipmentID INT,
    g_type varchar(20),
    PRIMARY KEY (equipmentID, g_type),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID),
    FOREIGN KEY (g_type) REFERENCES GhostType(g_type)
);
DROP TABLE IF EXISTS Hunter_Has_Equipment;
--Hunter_Has_Equipment relationship table
CREATE TABLE Hunter_Has_Equipment (
    hunterID INT,
    equipmentID INT,
    PRIMARY KEY (hunterID, equipmentID),
    FOREIGN KEY (hunterID) REFERENCES Hunter(hunterID),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
);
DROP TABLE IF EXISTS Ghost_FavoriteLocation_Location;
--Ghost_FavoriteLocation_Location relationship table
CREATE TABLE Ghost_FavoriteLocation_Location (
    ghostID INT,
    locationID INT,
    PRIMARY KEY (ghostID, locationID),
    FOREIGN KEY (ghostID) REFERENCES Ghost(ghostID),
    FOREIGN KEY (locationID) REFERENCES Location(locationID)
);
DROP TABLE IF EXISTS Evidence_FoundBy_Hunter;
--Evidence_FoundBy_Hunter relationship table
CREATE TABLE Evidence_FoundBy_Hunter (
    hunterID INT REFERENCES Hunter(hunterID),
    evidenceID INT PRIMARY key REFERENCES Evidence(evidenceID)
);

DROP TABLE IF EXISTS Evidence_FoundWith_Equipment;
--Evidence_FoundWith_Equipment relationship table
CREATE TABLE Evidence_FoundWith_Equipment (
	evidenceID INT PRIMARY KEY REFERENCES Evidence(evidenceID),
	equipmentID INT REFERENCES Equipment(equipmentID)
);

DROP TABLE IF EXISTS Evidence_FoundIn_Location;
--Evidence_FoundIn_Location relationship table
CREATE TABLE Evidence_FoundIn_Location (
	evidenceID INT PRIMARY KEY REFERENCES Evidence(evidenceID),
	locationID INT REFERENCES Location(locationID)
);


--Step 2: Insert Sample Data


--Insert data into the Ghost table
INSERT INTO Ghost (ghostID, haunting_type, name, spookiness_level, speed) 
VALUES 
    (1, 'Spirit', 'Lady in Red', 9, 2),
    (2, 'Poltergeist', 'The Screamer', 10, 5),
    (3, 'Apothicon', 'Shadow Man', 8, 4),
    (4, 'Banshee', 'The Whisper', 7, 3),
    (5, 'Demon', 'The Jester', 10, 4),
    (6, 'Poltergeist', 'Purple Guy', 10, 2),
    (7, 'Phantom', 'Golden Freddy', 5, 1),
    (8, 'Spirit', 'Casper', 1, 3),
    (9, 'Professor', 'Dr. Rafiq', 10, 5)
    (10, 'Apothicon', 'Samantha', 10, 2)
;
--Insert data into the Equipment table
INSERT INTO Equipment (equipmentID, equipment_type, model, working) 
VALUES
    (1, 'Flashlight', 'Basic Flashlight', TRUE),
    (2, 'Flashlight', 'Strong Flashlight', TRUE),
    (3, 'Thermometer', 'Simple Thermometer', TRUE),
    (4, 'EMF Reader', 'K-II EMF Meter', TRUE),
    (5, 'Camera', 'Photo Camera', TRUE),
    (6, 'Camera', 'Video Camera', TRUE),
    (7, 'Camera', 'Head-Mounted Camera', TRUE),
    (8, 'Spirit Box', 'SB7 Spirit Box', TRUE),
    (9, 'UV Light', 'UV Glow Stick', TRUE),
    (10, 'Ghost Writing Book', 'Notebook and Pen', TRUE),
    (11, 'Motion Sensor', 'PIR Sensor', TRUE),
    (12, 'Sound Sensor', 'Directional Microphone', TRUE),
    (13, 'Crucifix', 'Wooden Cross', TRUE),
    (14, 'Smudge Stick', 'Sage Stick', TRUE),
    (15, 'Salt', 'Rock Salt Shaker', TRUE),
    (16, 'Tripod', 'Camera Tripod', TRUE),
    (17, 'Candle', 'Wax Candle', TRUE),
    (18, 'Fire Source', 'Matches', TRUE),
    (19, 'Parabolic Microphone', 'Dish Microphone', TRUE),
    (20, 'DOTS Projector', 'Laser Grid Projector', TRUE),
    (21, 'Camera', 'Ghost Orb Detector', TRUE)
;

--Insert data into the Location TABLE
INSERT INTO Location (locationID, building, room, vacancy, construction_date) 
VALUES 
	(1, 'Old Mill', 'Boiler Room', 'Abandoned', '1890-01-01'),
	(2, 'Queen Hotel', 'Suite 304', 'Occupied', '1920-01-01'),
	(3, 'Shadows of Evil', 'Undercroft', 'Occupied', '1915-01-01'),
	(4, 'Lincol n Church', 'Crypt', 'Abandoned', '1850-01-01'),
	(5, 'Downtown Library', 'Basement', 'Occupied', '1940-01-01'),
    (6, 'Old Mill', 'Storage Room', 'Abandoned', '1890-01-01'),
    (7, 'Old Mill', 'Control Room', 'Abandoned', '1890-01-01'),
    (8, 'Old Mill', 'Foundry', 'Abandoned', '1890-01-01'),
    (9, 'Queen Hotel', 'Lobby', 'Occupied', '1920-01-01'),
    (10, 'Queen Hotel', 'Suite 101', 'Occupied', '1920-01-01'),
    (11, 'Queen Hotel', 'Suite 505', 'Occupied', '1920-01-01'),
    (12, 'Smith Mansion', 'Master Bedroom', 'Abandoned', '1915-01-01'),
    (13, 'Smith Mansion', 'Dining Room', 'Abandoned', '1915-01-01'),
    (14, 'Smith Mansion', 'Library', 'Abandoned', '1915-01-01'),
    (15, 'Lincoln Church', 'Chapel', 'Abandoned', '1850-01-01'),
    (16, 'Lincoln Church', 'Sacristy', 'Abandoned', '1850-01-01'),
    (17, 'Lincoln Church', 'Choir Loft', 'Abandoned', '1850-01-01'),
    (18, 'Downtown Library', 'Archives', 'Occupied', '1940-01-01'),
    (19, 'Downtown Library', 'Study Hall', 'Occupied', '1940-01-01'),
    (20, 'Downtown Library', 'Reading Room', 'Occupied', '1940-01-01'),
	(21, '6 Tanglewood Dr.', 'Foyer', 'Occupied', '1970-01-01'),
	(22, '6 Tanglewood Dr.', 'Living Room', 'Occupied', '1970-01-01'),
	(23, '6 Tanglewood Dr.', 'Dining Room', 'Occupied', '1970-01-01'),
	(24, '6 Tanglewood Dr.', 'Kitchen', 'Occupied', '1970-01-01'),
	(25, '6 Tanglewood Dr.', 'Utility Room', 'Occupied', '1970-01-01'),
	(26, '6 Tanglewood Dr.', 'Garage', 'Occupied', '1970-01-01'),
	(27, '6 Tanglewood Dr.', 'Master Bedroom', 'Occupied', '1970-01-01'),
	(28, '6 Tanglewood Dr.', 'Master Bathroom', 'Occupied', '1970-01-01'),
	(29, '6 Tanglewood Dr.', 'Master Closet', 'Occupied', '1970-01-01'),
	(30, '6 Tanglewood Dr.', 'Boy Bedroom', 'Occupied', '1970-01-01'),
	(31, '6 Tanglewood Dr.', 'Nursery', 'Occupied', '1970-01-01'),
	(32, '6 Tanglewood Dr.', 'Main Bathroom', 'Occupied', '1970-01-01'),
	(33, '6 Tanglewood Dr.', 'Basement', 'Occupied', '1970-01-01'),
	(34, 'Moon Base', 'MPD', 'Abandoned', '1890-01-01')
;


--Insert data into the Hunter table
INSERT INTO Hunter(hunterID, name, experience_level, speed)
values
	(1, 'Mallory Jacobs', 'Intermediate', 4),
    (2, 'Austin Jackson', 'Intermediate', 3),
    (3, 'Morgan Hale', 'Beginner', 2),
    (4, 'Dr. Patil', 'Master', 4),
    (5, 'Taylor Reid', 'Novice', 3),
    (6, 'Charlie Brooks', 'Intermediate', 4),
    (7, 'Jordan Bell', 'Expert', 3),
    (8, 'Riley Carter', 'Beginner', 1),
    (9, 'Quinn Taylor', 'Novice', 2),
    (10, 'Dakota Lee', 'Intermediate', 3)
;


--Insert data into the Evidence table

INSERT INTO Evidence (evidenceID, locationID, hunterID, equipmentID, date, time)
VALUES 
    (1, 1, 1, 4, '2024-12-01', '23:15:00'), -- EMF reading in the Boiler Room by Mallory Jacobs
    (2, 6, 2, 10, '2024-12-02', '02:30:00'), -- Writing in the Storage Room by Austin Jackson
    (3, 11, 3, 5, '2024-12-03', '01:00:00'), -- Photograph in Suite 505 by Dr. Patil
    (4, 15, 4, 19, '2024-12-03', '22:45:00'), -- Parabolic sound detected in the Chapel by Pat Jordan
    (5, 20, 5, 8, '2024-12-04', '00:05:00'),
    (6, 21, 1, 21, '2024-12-01', '22:15:00'),
	(7, 21, 2, 8, '2024-12-01', '22:30:00'),
	(8, 22, 3, 20, '2024-12-01', '23:00:00'),
	(9, 23, 1, 3, '2024-12-02', '00:15:00'),
	(10, 21, 2, 10, '2024-12-02', '00:45:00'),
	(11, 24, 3, 9, '2024-12-02', '01:30:00'),
	(12, 21, 1, 4, '2024-12-03', '02:00:00'),
	(13, 25, 2, 21, '2024-12-03', '02:30:00'),
	(14, 26, 3, 8, '2024-12-03', '03:00:00'),
	(15, 21, 1, 20, '2024-12-04', '03:30:00')
;
--Insert data into relationship tables

TRUNCATE table Equipment_Detects_GhostType;
INSERT INTO Equipment_Detects_GhostType(equipmentID,g_type)
values
	--ghost orbs
	(21,'Mare'),
	(21,'Yokai'),
	(21,'Raiju'),
	(21,'Banshee'),
	(21,'Revenant'),
	(21,'Yurei'),
	(21,'Hantu'),
	(21,'Onryo'),
	(21,'Obake'),
	(21,'The Mimic'),
	(21,'Thaye'),
	(21,'Professor'),
	--spirit box
	(8,'Spirit'),
	(8,'Poltergeist'),
	(8,'Mare'),
	(8,'Yokai'),
	(8,'Moroi'),
	(8,'Wraith'),
	(8,'Onryo'),
	(8,'Deogen'),
	(8,'Phantom'),
	(8,'The Twins'),
	(8,'The Mimic'),
	(8,'Apothicon'),
	--DOTS projector
	(20,'Yokai'),
	(20,'Raiju'),
	(20,'Wraith'),
	(20,'Banshee'),
	(20,'Yurei'),
	(20,'Deogen'),
	(20,'Phantom'),
	(20,'Oni'),
	(20,'Goryo'),
	(20,'Thaye'),
	(20,'The Screamer'),
	--freezing-temps
	(3,'Demon'),
	(3,'Moroi'),
	(3,'Revenant'),
	(3,'Yurei'),
	(3,'Hantu'),
	(3,'Onryo'),
	(3,'Jinn'),
	(3,'Shade'),
	(3,'Oni'),
	(3,'The Twins'),
	(3,'The Mimic'),
	(3,'Apothicon'),
	--writing
	(10,'Spirit'),
	(10,'Poltergeist'),
	(10,'Mare'),
	(10,'Demon'),
	(10,'Myling'),
	(10,'Moroi'),
	(10,'Revenant'),
	(10,'Deogen'),
	(10,'Shade'),
	(10,'Thaye'),
	(10,'Professor'),
	--ultraviolet
	(9,'Poltergeist'),
	(9,'Demon'),
	(9,'Myling'),
	(9,'Banshee'),
	(9,'Hantu'),
	(9,'Obake'),
	(9,'Phantom'),
	(9,'Jinn'),
	(9,'Goryo'),
	(9,'The Mimic'),
	(9,'Professor'),
	(9,'The Screamer'),
	--emf-5
	(4,'Spirit'),
	(4,'Myling'),
	(4,'Raiju'),
	(4,'Wraith'),
	(4,'Obake'),
	(4,'Jinn'),
	(4,'Shade'),
	(4,'Oni'),
	(4,'Goryo'),
	(4,'The Twins'),
	(4,'Apothicon'),
	(4,'The Screamer')
;

TRUNCATE table Hunter_Has_Equipment;
INSERT INTO Hunter_Has_Equipment(hunterID,equipmentID)
VALUES 
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 5),
	(5, 6)
;


TRUNCATE table Ghost_FavoriteLocation_Location;
INSERT INTO Ghost_FavoriteLocation_Location (ghostID,locationID)
VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(10,34)
;


TRUNCATE TABLE Ghost_is_GhostType;
-- Insert data into Ghost_is_GhostType based on Ghost table's haunting_type
INSERT INTO Ghost_is_GhostType (ghostID, g_type)
SELECT ghostID, haunting_type
FROM Ghost;

--Sample Queries

--Retrieve the spookiest/quickest ghosts recorded by each hunter
--This query fetches the spookiest and/or quickest ghost sighted by each hunter.


-- Spookiest ghost recorded by each hunter
SELECT 
    h.name AS hunter_name,
    g.name AS ghost_name,
    MAX(g.spookiness_level) AS spookiness_level
FROM Evidence e
JOIN Ghost g ON e.locationID IN (
    SELECT locationID 
    FROM Ghost_FavoriteLocation_Location 
    WHERE ghostID = g.ghostID
)
JOIN Hunter h ON e.hunterID = h.hunterID
GROUP BY h.name, g.name;

-- Quickest ghost recorded by each hunter
SELECT 
    h.name AS hunter_name,
    g.name AS ghost_name,
    MAX(g.speed) AS ghost_speed
FROM Evidence e
JOIN Ghost g ON e.locationID IN (
    SELECT locationID 
    FROM Ghost_FavoriteLocation_Location 
    WHERE ghostID = g.ghostID
)
JOIN Hunter h ON e.hunterID = h.hunterID
GROUP BY h.name, g.name;

--Find ghost sightings with specific equipment (e.g., camera) 
--This query identifies sightings that used specific equipment like a camera.


SELECT 
    e.evidenceID,
    e.date,
    e.time,
    h.name AS hunter_name,
    g.name AS ghost_name,
    eq.equipment_type,
    eq.model
FROM Evidence e
JOIN Hunter h ON e.hunterID = h.hunterID
JOIN Equipment eq ON e.equipmentID = eq.equipmentID
JOIN Ghost g ON e.locationID IN (
    SELECT locationID 
    FROM Ghost_FavoriteLocation_Location 
    WHERE ghostID = g.ghostID
)
WHERE eq.equipment_type = 'Camera';


--List top-rated hunters based on the spookiness of ghosts they’ve sighted  
--This query ranks hunters by the spookiness level of ghosts they’ve encountered.


SELECT 
    h.name AS hunter_name,
    SUM(g.spookiness_level) AS total_spookiness,
    COUNT(e.evidenceID) AS sightings_count
FROM Evidence e
JOIN Hunter h ON e.hunterID = h.hunterID
JOIN Ghost g ON e.locationID IN (
    SELECT locationID 
    FROM Ghost_FavoriteLocation_Location 
    WHERE ghostID = g.ghostID
)
GROUP BY h.name
ORDER BY total_spookiness DESC, sightings_count DESC;

--Specialized Query (Dr. Patil and Dr. Rafiq):
--If we want the query to focus specifically on Dr. Patil as the hunter and Dr. Rafiq as the ghost:

SELECT 
    e.evidenceID,
    e.date,
    e.time,
    h.name AS hunter_name,
    g.name AS ghost_name,
    g.spookiness_level,
    g.speed,
    eq.equipment_type,
    eq.model
FROM Evidence e
JOIN Hunter h ON e.hunterID = h.hunterID
JOIN Equipment eq ON e.equipmentID = eq.equipmentID
JOIN Ghost g ON e.locationID IN (
    SELECT locationID 
    FROM Ghost_FavoriteLocation_Location 
    WHERE ghostID = g.ghostID
)
WHERE h.name = 'Dr. Patil' AND g.name = 'Dr. Rafiq';



--Find the ghost type based on all the evidence in that building location.

-- Step 1: Filter evidence for whatever
WITH FilteredEvidence AS (
    SELECT 
        E.evidenceID,
        E.equipmentID,
        L.building,
        E.date
    FROM Evidence E
    JOIN Location L ON E.locationID = L.locationID
    WHERE E.date = '2024-12-01' -- Replace with desired date
      AND L.building = '6 Tanglewood Dr.' -- Replace with desired building name
),
-- Step 2: Map equipment to ghost types
MappedGhostTypes AS (
    SELECT 
        FE.evidenceID,
        EDT.g_type AS GhostType
    FROM FilteredEvidence FE
    JOIN Equipment_Detects_GhostType EDT ON FE.equipmentID = EDT.equipmentID
),
-- Step 3: Deduce ghost type based on evidence
DeducedGhostType AS (
    SELECT 
        GhostType,
        COUNT(DISTINCT evidenceID) AS EvidenceCount
    FROM MappedGhostTypes
    GROUP BY GhostType
    HAVING COUNT(DISTINCT evidenceID) >= 3 -- Require at least 3 unique evidence types
)
SELECT GhostType FROM DeducedGhostType;


-- Query to find the favorite room of every known Apothicon
SELECT 
    G.name AS GhostName,
    G.haunting_type as Type,
    L.room AS FavoriteRoom,
    L.building AS Building
FROM Ghost G
JOIN Ghost_FavoriteLocation_Location GFL ON G.ghostID = GFL.ghostID
JOIN Location L ON GFL.locationID = L.locationID
WHERE G.haunting_type = 'Apothicon';









