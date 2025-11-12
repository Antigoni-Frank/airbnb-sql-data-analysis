--- Data Analytics Portfolio: Airbnb SQL Data Analysis


SELECT COUNT(*) AS Greek2
FROM listings;

SELECT COUNT(*) AS reviewsnumber
FROM reviews;

SELECT COUNT(*) AS totalbookings
FROM calendar
WHERE available = '0'


SELECT COUNT(DISTINCT host_id) AS TotalUniqueHosts
FROM listings;

SELECT DISTINCT neighbourhood_cleansed AS UniqueArea
FROM listings;

SELECT 
    neighbourhood_cleansed,
    COUNT(*) AS listings_num,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM listings) AS percentage
FROM listings
GROUP BY neighbourhood_cleansed
ORDER BY percentage DESC;


SELECT host_is_superhost, COUNT(*) AS NumberOfHosts
FROM listings
GROUP BY host_is_superhost
ORDER BY NumberOfHosts DESC;

SELECT HOST_NAME,
COUNT (*) AS numofhosts
FROM listings
GROUP BY host_name
ORDER BY numofhosts DESC;


SELECT * FROM listings 
WHERE neighbourhood_cleansed LIKE N'?%';


SELECT *
FROM listings
WHERE price BETWEEN 0 AND 100;

select *
from listings
where price > 0 and price <= 100 


SELECT * 
FROM listings 
WHERE id NOT IN (SELECT DISTINCT listing_id FROM reviews);


SELECT COUNT(*) AS hosts_with_photo
FROM listings
WHERE host_picture_url IS NOT NULL AND host_picture_url <> '';


SELECT 
    neighbourhood,
    AVG(price) AS average_price
FROM listings
GROUP BY neighbourhood
ORDER BY average_price DESC;


SELECT TOP 1 property_type,
AVG(price) AS aveprice
FROM listings
GROUP BY property_type
ORDER BY aveprice DESC;

SELECT neighbourhood, 
       AVG(price) AS aveprice
FROM listings
GROUP BY neighbourhood
HAVING AVG(price) > 200
ORDER BY aveprice DESC;

SELECT l.property_type, COUNT(DISTINCT c.listing_id) AS total_reservations
FROM calendar c
JOIN listings l ON c.listing_id = l.id
WHERE c.available = '1'
GROUP BY l.property_type;

SELECT TOP 1 l.room_type,
    COUNT(*) AS review_count
FROM reviews r
JOIN listings l ON r.listing_id = l.id
GROUP BY l.room_type
ORDER BY review_count DESC;

SELECT TOP 1 * FROM reviews;
SELECT TOP 1 * FROM listings;

SELECT 
    l.id AS ListingID,
    l.name AS ListingName,
    l.host_name AS HostName,
    l.price AS Price,
    COUNT(r.id) AS ReviewCount
FROM 
    listings l
LEFT JOIN 
    reviews r ON l.id = r.listing_id
GROUP BY 
    l.id, l.name, l.host_name, l.price
ORDER BY 
    ReviewCount DESC;