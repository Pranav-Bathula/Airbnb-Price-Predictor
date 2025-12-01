CREATE SCHEMA IF NOT EXISTS airbnb;
SET search_path TO airbnb, public;

CREATE TABLE neighbourhood (
    neighbourhood_id SERIAL PRIMARY KEY,
    borough          TEXT,                 
    neighbourhood_name TEXT NOT NULL
);

CREATE TABLE listing (
    listing_id   BIGINT PRIMARY KEY, 

    
    neighbourhood_id INT REFERENCES neighbourhood(neighbourhood_id),

    --Host Information
    host_id      BIGINT,
    host_name    TEXT,
    host_since   DATE,
    host_is_superhost BOOLEAN,


    --Property Information
    room_type    TEXT,
    property_type TEXT,
    accommodates INT,
    bedrooms     INT,
    beds         INT,
    bathrooms    NUMERIC(3,1),
    bathrooms_text TEXT,

    latitude     DOUBLE PRECISION,
    longitude    DOUBLE PRECISION,

    
    --Price and Availability
    price        NUMERIC(10,2),      
    maximum_nights INT,
    number_of_reviews INT,
    availability_365 INT,

    
    --Review Information
    first_review DATE,
    last_review  DATE,
    review_scores_rating NUMERIC(3,2),

    instant_bookable BOOLEAN,
    calculated_host_listings_count INT,
    reviews_per_month NUMERIC(5,2)
);

CREATE TABLE calendar (
    listing_id  BIGINT REFERENCES listing(listing_id),
    date        DATE,
    available   BOOLEAN,      
    minimum_nights INT,
    maximum_nights INT,

    PRIMARY KEY (listing_id, date)


);

CREATE TABLE review (
    review_id     BIGINT PRIMARY KEY,
    listing_id    BIGINT REFERENCES listing(listing_id),
    date          DATE,
    reviewer_id   BIGINT,
    reviewer_name TEXT,
    comments      TEXT
);