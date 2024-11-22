﻿# GhostHuntersInc 

## tables

# Ghost table
# CREATE TABLE Ghost (
    ghostID INT PRIMARY KEY,
    name VARCHAR(50),
    haunting_type VARCHAR(50),
    spookiness_level INT,
    speed INT
);

# Hunter table
# CREATE TABLE Hunter (
    hunterID INT PRIMARY KEY,
    name VARCHAR(50),
    experience_level VARCHAR(50),
    specialty_type VARCHAR(50),
    speed INT
);

# Evidence table
# CREATE TABLE Evidence (
    evidenceID INT PRIMARY KEY,
    locationID INT,
    equipmentID INT,
    date DATE,
    time TIME
);

# Equipment table
# CREATE TABLE Equipment (
    equipmentID INT PRIMARY KEY,
    type VARCHAR(50),
    model VARCHAR(50),
    detection_type VARCHAR(50),
    working BOOLEAN
);

# Location table
# CREATE TABLE Location (
    locationID INT PRIMARY KEY,
    building VARCHAR(100),
    room VARCHAR(50),
    vacancy VARCHAR(50),
    construction_date DATE
);

# Hunter_Records_Evidence relationship table
# CREATE TABLE Hunter_Records_Evidence (
    hunterID INT,
    evidenceID INT,
    PRIMARY KEY (hunterID, evidenceID),
    FOREIGN KEY (hunterID) REFERENCES Hunter(hunterID),
    FOREIGN KEY (evidenceID) REFERENCES Evidence(evidenceID)
);

# Equipment_Detects_Ghost relationship table
# CREATE TABLE Equipment_Detects_Ghost (
    equipmentID INT,
    ghostID INT,
    PRIMARY KEY (equipmentID, ghostID),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID),
    FOREIGN KEY (ghostID) REFERENCES Ghost(ghostID)
);

# Hunter_Uses_Equipment relationship table
# CREATE TABLE Hunter_Uses_Equipment (
    hunterID INT,
    equipmentID INT,
    PRIMARY KEY (hunterID, equipmentID),
    FOREIGN KEY (hunterID) REFERENCES Hunter(hunterID),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
);

# Ghost_FavoriteLocation_Location relationship table
# CREATE TABLE Ghost_FavoriteLocation_Location (
    ghostID INT,
    locationID INT,
    PRIMARY KEY (ghostID, locationID),
    FOREIGN KEY (ghostID) REFERENCES Ghost(ghostID),
    FOREIGN KEY (locationID) REFERENCES Location(locationID)
);

