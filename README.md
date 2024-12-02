# Ghost Hunter Database

## Project Overview
This project involves creating a **Ghost Hunter Database** that enables ghost hunters to log sightings, capture evidence, and track equipment used during investigations. The database stores essential information about ghosts, hunters, sightings, equipment, and locations. It also tracks relationships between various entities such as ghosts, hunters, and the equipment used.

### Client Requirements:
- Ghost hunters can log their ghost sightings and capture evidence.
- Each sighting includes associated details such as location, type of haunting, and spookiness level.
- Ghosts have attributes such as speed, favorite location, and spookiness level.
- Equipment used during sightings is tracked (e.g., EMF reader, camera).
- GhostType can be determined by evidence linked to different equipment.
  
### Entity Sets & Relationships:

#### Entities:
1. **Ghost**: Contains attributes like ghost ID, name, haunting type, spookiness level, and speed.
2. **Hunter**: Contains hunter ID, name, experience level, and speed.
3. **Evidence**: Contains evidence ID, location ID, equipment ID, date, and time.
4. **Equipment**: Contains equipment ID, type, model, and working status (whether the equipment is functional).
5. **Location**: Contains location ID, building, room, vacancy status, and construction date.
6. **GhostType**: Contains the ghost type (g_type).

#### Relationships:
- **Ghost_is_GhostType**: Relates ghosts to their specific types.
- **Equipment_Detects_GhostType**: Links equipment to the ghost types they can detect.
- **Hunter_Has_Equipment**: Tracks which equipment a hunter possesses.
- **Ghost_FavoriteLocation_Location**: Tracks a ghost's favorite location.
- **Evidence_FoundBy_Hunter**: Links evidence to the hunter who found it.
- **Evidence_FoundWith_Equipment**: Links evidence to the equipment used during the sighting.
- **Evidence_FoundIn_Location**: Tracks where the evidence was found.

### Attributes:
- **Ghost**: ghost ID, name, haunting type, spookiness level, speed.
- **Hunter**: hunter ID, name, experience level, speed.
- **Evidence**: evidence ID, location ID, equipment ID, date, time.
- **Equipment**: equipment ID, type, model, working (boolean).
- **Location**: location ID, building, room, vacancy (abandoned or not), construction date.
- **GhostType**: g_type (type of ghost).

### Sample Queries:
- Retrieve the spookiest/quickest ghosts recorded by each hunter.
- Find ghost sightings with specific equipment (e.g., camera).
- List top-rated hunters based on the spookiness of ghosts they’ve sighted.
- Find the ghost type based on all the evidence in a given location.
- /*insert final query here*/
---

## Project Files

This repository includes the following files:
- **ER Diagram Image**: A visual representation of the Entity-Relationship Diagram that captures the entities and relationships in the database.
- **Relational Schema Image**: A diagram depicting the relational schema with tables, attributes, primary keys, and foreign key relationships.
- **SQL Implementation File**: A SQL file containing the full database implementation, including the creation of tables, relationships, and sample data inserts.

---

## Installation Instructions

To run this project:

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/ghost-hunter-database.git
   ```
2. Open your PostgreSQL environment or SQL editor (e.g., pgAdmin, DBeaver).

3.Create a new database for this project:
   ```bash
    CREATE DATABASE ghost_hunter_db;
   ```
4. Run the SQL implementation file to create the tables, relationships, and insert sample data:
   ```bash
   \i path/to/sqlfile.sql
   ```

##Future Enhancements
- Adding more detailed tracking for ghost sightings, including timestamps and investigation reports.
Integrating additional equipment types for further detection capabilities.
- Implementing a front-end interface to interact with the database.
- Implementing advanced queries to track ghost sighting trends over time.