-- SQLite Schema for Airbnb Price Predictor
-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

CREATE TABLE neighbourhood (
    neighbourhood_id INTEGER PRIMARY KEY AUTOINCREMENT,
    borough          TEXT,                 
    neighbourhood_name TEXT NOT NULL
);

CREATE TABLE listing (
    listing_id   INTEGER PRIMARY KEY, 
    
    neighbourhood_id INTEGER REFERENCES neighbourhood(neighbourhood_id),
    city         TEXT,  -- NYC, Boston, or Washington DC

    --Host Information
    host_id      INTEGER,
    host_name    TEXT,
    host_since   DATE,
    host_is_superhost INTEGER,  -- 0 = false, 1 = true

    --Property Information
    room_type    TEXT,
    property_type TEXT,
    accommodates INTEGER,
    bedrooms     INTEGER,
    beds         INTEGER,
    bathrooms    REAL,
    bathrooms_text TEXT,

    latitude     REAL,
    longitude    REAL,

    --Price and Availability
    price        REAL,      
    number_of_reviews INTEGER,
    availability_365 INTEGER,
    estimated_revenue REAL,

    --Review Information
    first_review DATE,
    last_review  DATE,
    review_scores_rating REAL,

    instant_bookable INTEGER,  -- 0 = false, 1 = true
    calculated_host_listings_count INTEGER,
    reviews_per_month REAL
);
