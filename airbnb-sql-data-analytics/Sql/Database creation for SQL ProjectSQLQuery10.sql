CREATE DATABASE GreekAirbnb COLLATE Greek_CI_AI;
GO

USE GreekAirbnb
GO

CREATE TABLE dbo.Listings (
id                          BIGINT NOT NULL PRIMARY KEY,
listing_url                 NVARCHAR(500) NULL, 
name                        NVARCHAR(200) NOT NULL,
description                 NVARCHAR(200) NOT NULL,
host_id                     BIGINT NOT NULL,
host_url                    NVARCHAR(500)   NULL,
    host_name               NVARCHAR(100)   NULL,
    host_since              DATE            NULL,
    host_location           NVARCHAR(200)   NULL,
    host_about              NVARCHAR(MAX)   NULL,
    host_response_time      NVARCHAR(50)    NULL,
    host_response_rate      NVARCHAR(50)    NULL,   -- parse to % later if needed
    host_acceptance_rate    NVARCHAR(50)    NULL,
    host_is_superhost       BIT             NULL,
    host_thumbnail_url      NVARCHAR(500)   NULL,
    host_picture_url        NVARCHAR(500)   NULL,
    host_verifications      NVARCHAR(200)   NULL,
    host_has_profile_pic    BIT             NULL,
    host_identity_verified  BIT             NULL,

    neighbourhood_cleansed  NVARCHAR(200)   NULL,
    latitude                DECIMAL(9,6)    NULL,
    longitude               DECIMAL(9,6)    NULL,

    property_type           NVARCHAR(100)   NULL,
    room_type               NVARCHAR(50)    NULL,
    accommodates            INT             NULL,
    bathrooms               DECIMAL(4,2)    NULL,
    bathrooms_text          NVARCHAR(100)   NULL,
    bedrooms                INT             NULL,
    beds                    INT             NULL,
    amenities               NVARCHAR(MAX)   NULL,   -- JSON (keep raw)
    price                   DECIMAL(12,2)   NULL,
    minimum_nights          INT             NULL,
    maximum_nights          INT             NULL,
    has_availability        BIT             NULL,

    review_scores_rating        DECIMAL(3,2) NULL,
    review_scores_accuracy      DECIMAL(3,2) NULL,
    review_scores_cleanliness   DECIMAL(3,2) NULL,
    review_scores_checkin       DECIMAL(3,2) NULL,
    review_scores_communication DECIMAL(3,2) NULL,
    review_scores_location      DECIMAL(3,2) NULL,
    review_scores_value         DECIMAL(3,2) NULL,

    instant_bookable        BIT             NULL
);
GO

SELECT TOP (5) *
FROM dbo.Listings


CREATE TABLE dbo.Reviews (
listing_id	    BIGINT           NOT NULL PRIMARY KEY,
id              INT           NOT NULL,
date            DATE          NULL,
reviewer_id	    INT           NULL,
reviewer_name   NVARCHAR(100) NULL,
comments        NVARCHAR(MAX) NOT NULL

CONSTRAINT FK_reviews_listings
FOREIGN KEY (listing_id) REFERENCES dbo.Listings(id))

CREATE TABLE dbo.Bookings (
listing_id	    BIGINT        NOT NULL, 
date            DATE          NOT NULL,
available		VARCHAR(1)    NULL,
price           DECIMAL       NULL,
adjusted_price  DECIMAL       NULL,
minimum_nights  INT           NULL,
maximum_nights  INT           NULL,

CONSTRAINT PK_Bookings PRIMARY KEY (listing_id, [date]),
CONSTRAINT FK_Bookings_Listings
FOREIGN KEY (listing_id) REFERENCES dbo.Listings(id))