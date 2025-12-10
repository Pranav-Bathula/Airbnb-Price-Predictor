#!/bin/bash

# Setup script for local SQLite database
# This script creates the database file and runs the schema

set -e

echo "Setting up local SQLite database..."

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCHEMA_FILE="$SCRIPT_DIR/schema/01_logical_schema_sqlite.sql"
DB_FILE="$SCRIPT_DIR/../data/airbnb.db"

# Create data directory if it doesn't exist
mkdir -p "$(dirname "$DB_FILE")"

# Check if schema file exists
if [ ! -f "$SCHEMA_FILE" ]; then
    echo "Error: Schema file not found at $SCHEMA_FILE"
    exit 1
fi

# Remove existing database if it exists (optional - comment out if you want to keep existing data)
# Accept --force flag to skip interactive prompt
FORCE_MODE=false
if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    FORCE_MODE=true
fi

if [ -f "$DB_FILE" ]; then
    if [ "$FORCE_MODE" = true ]; then
        # Non-interactive mode: automatically remove existing database
        rm "$DB_FILE"
        echo "Removed existing database file (--force mode)"
    else
        # Interactive mode: ask user
        echo "Warning: Database file already exists at $DB_FILE"
        read -p "Do you want to delete it and start fresh? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$DB_FILE"
            echo "Removed existing database file"
        else
            echo "Keeping existing database. Schema will be applied to existing database."
        fi
    fi
fi

# Run schema using sqlite3
echo "Creating database and running schema..."
sqlite3 "$DB_FILE" < "$SCHEMA_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Database setup complete!"
    echo ""
    echo "Database file: $DB_FILE"
    echo ""
    echo "You can now run the populate_database.ipynb notebook to load data."
else
    echo "Error: Failed to create database"
    exit 1
fi

