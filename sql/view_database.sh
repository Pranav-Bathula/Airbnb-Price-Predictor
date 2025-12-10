#!/bin/bash

# Script to view the SQLite database in an organized way

DB_FILE="data/airbnb.db"

if [ ! -f "$DB_FILE" ]; then
    echo "Error: Database file not found at $DB_FILE"
    exit 1
fi

echo "=== Airbnb Database Viewer ==="
echo ""

# Show all tables
echo "📊 Tables in database:"
sqlite3 "$DB_FILE" ".tables"
echo ""

# Show schema for each table
echo "📋 Database Schema:"
sqlite3 "$DB_FILE" ".schema"
echo ""

# Show row counts
echo "📈 Row Counts:"
sqlite3 "$DB_FILE" <<EOF
SELECT 'neighbourhood' as table_name, COUNT(*) as row_count FROM neighbourhood
UNION ALL
SELECT 'listing', COUNT(*) FROM listing;
EOF

echo ""
echo "💡 To explore interactively, run: sqlite3 $DB_FILE"
echo "💡 Useful commands:"
echo "   .tables          - List all tables"
echo "   .schema          - Show database schema"
echo "   .schema table    - Show schema for specific table"
echo "   SELECT * FROM table LIMIT 10;  - View sample data"
echo "   .quit            - Exit"

