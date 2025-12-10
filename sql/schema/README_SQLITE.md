# SQLite Database Setup

This project uses SQLite as the database, which stores everything in a single file at `data/airbnb.db`.

## Quick Start

1. **Create the database and schema:**
   ```bash
   ./sql/setup_local_db_sqlite.sh
   ```
   
   Or manually:
   ```bash
   sqlite3 data/airbnb.db < sql/schema/01_logical_schema_sqlite.sql
   ```

2. **Populate the database:**
   - Open `sql/etl/populate_database.ipynb`
   - Run all cells in order
   - This will populate:
     - `neighbourhood` table from `data/neighbourhoods.csv`
     - `listing` table from `data/processed/listings_cleaned.csv`
     - `calendar` table from `data/calendar.csv`

## Database File

- **Location:** `data/airbnb.db`
- **Format:** SQLite 3 database file
- **Size:** Will grow as data is inserted (calendar data is large)

## Schema Files

- **SQLite schema:** `sql/schema/01_logical_schema_sqlite.sql`
- **PostgreSQL schema (legacy):** `sql/schema/01_logical_schema.sql`

## Differences from PostgreSQL

1. **No server required** - SQLite runs as a library
2. **File-based** - Everything in one `.db` file
3. **Built-in** - Uses Python's `sqlite3` module (no extra dependencies)
4. **Simpler setup** - No user/password/port configuration needed

## Querying the Database

You can query the database using:

**Python:**
```python
import sqlite3
conn = sqlite3.connect('data/airbnb.db')
cur = conn.cursor()
cur.execute("SELECT * FROM listing LIMIT 10;")
results = cur.fetchall()
```

**Command line:**
```bash
sqlite3 data/airbnb.db
sqlite> SELECT COUNT(*) FROM listing;
sqlite> .tables
sqlite> .quit
```

## Notes

- The database file (`data/airbnb.db`) is ignored by git (via `.gitignore`)
- Foreign key constraints are enabled automatically when connecting
- Boolean values are stored as INTEGER (0 = false, 1 = true)

