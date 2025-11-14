--Database Greek2


--1 Πόσα καταλύματα υπάρχουν;
SELECT COUNT(*) AS Greek2
FROM listings;

--2 Πόσες αξιολογήσεις έχουν γίνει;
SELECT COUNT(*) AS reviewsnumber
FROM reviews;

--3 (mesa ston pinaka emfanizete san 1 kai 0, oxi f) Πόσες κρατήσεις έχουν γίνει (Πρέπει το available να είναι ίσο με ‘f’)
SELECT COUNT (*) AS totalbookings
FROM calendar
WHERE available = '0'

--4 Πόσοι μοναδικοί οικοδεσπότες υπάρχουν;
SELECT COUNT(DISTINCT host_id) AS TotalUniqueHosts
FROM listings;

--5 (324 entries) Ποιες είναι οι μοναδικές περιοχές που προσφέρονται τα καταλύματα;
SELECT DISTINCT neighbourhood_cleansed AS UniqueArea
FROM listings;

--6 Ποιο είναι το ποσοστό καταλυμάτων ανά περιοχή; 
SELECT 
    neighbourhood_cleansed,
    COUNT(*) AS listings_num,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM listings) AS percentage
FROM listings
GROUP BY neighbourhood_cleansed
ORDER BY percentage DESC;

--7 Ποιος τύπος οικοδεσπότη (superhost/nonsuperhost) έχει τα περισσότερα καταλύματα;
SELECT host_is_superhost, COUNT(*) AS NumberOfHosts
FROM listings
GROUP BY host_is_superhost
ORDER BY NumberOfHosts DESC;

--8 Πόσα καταλύματα έχει ο κάθε οικοδεσπότης (να φέρετε το όνομά του)
SELECT HOST_NAME,
COUNT (*) AS numofhosts
FROM listings
GROUP BY host_name
ORDER BY numofhosts DESC;

--9 Αντλήστε τα καταλύματα των οποίων η περιοχή που βρίσκονται ξεκινά από Π
SELECT * FROM listings 
WHERE neighbourhood_cleansed LIKE N'Π%';

--10 Αντλήστε τα καταλύματα των οποίων η τιμή είναι μεταξύ 0 και 100
select *
from listings
where price > 0 and price <= 100 

--11 Ποια καταλύματα δεν έχουν καμία αξιολόγηση; (Hint: Για να βρείτε όλα τα καταλύματα που έχουν αξιολογήσεις select distinct listing_id from reviews)
SELECT * 
FROM listings 
WHERE id NOT IN (SELECT DISTINCT listing_id FROM reviews);

--12 Πόσοι οικοδεσπότες έχουν φωτογραφία προφίλ
SELECT COUNT(*) AS hosts_with_photo
FROM listings
WHERE host_picture_url IS NOT NULL AND host_picture_url <> '';

--13 Ποια είναι η μέση τιμή ανά περιοχή (neighborhood);
SELECT 
    neighbourhood,
    AVG(price) AS average_price
FROM listings
GROUP BY neighbourhood
ORDER BY average_price DESC;

--14 Ποιος τύπος property έχει την μεγαλύτερη μέση τιμή; (Κρατήστε ακριβώς τον πρώτο)
SELECT TOP 1 property_type,
AVG(price) AS aveprice
FROM listings
GROUP BY property_type
ORDER BY aveprice DESC;

--15 Ποιες περιοχές έχουν μέση τιμή μεγαλύτερη από 200 ευρώ ανά βραδιά;
SELECT neighbourhood, 
       AVG(price) AS aveprice
FROM listings
GROUP BY neighbourhood
HAVING AVG(price) > 200
ORDER BY aveprice DESC;

--16 Πόσες κρατήσεις έχουν γίνει ανά τύπο property; 
SELECT l.property_type, COUNT(c.date) AS total_reservations
FROM calendar c
JOIN listings l ON c.listing_id = l.id
WHERE c.available = '0'
GROUP BY l.property_type;


--17 Ποιος είναι ο τύπος δωματίου με τις περισσότερες αξιολογήσεις;
SELECT TOP 1 l.room_type,
    COUNT(*) AS review_count
FROM reviews r
JOIN listings l ON r.listing_id = l.id
GROUP BY l.room_type
ORDER BY review_count DESC;


--18 Εμφανίστε την ονομασία ενός καταλύματος, την ονομασία του οικοδεσπότη, την τιμή, το πλήθος αξιολογήσεων, το πλήθος κρατήσεων (Optional)

WITH ReviewCountCTE AS (SELECT listing_id, COUNT(*) AS ReviewsCount
						FROM reviews
						GROUP BY listing_id),
CalendarCountCTE AS (SELECT listing_id, COUNT(*) AS CalendarCount
					FROM calendar
					WHERE available = '1'
					GROUP BY listing_id)

SELECT listings.name, 
	   listings.host_name,
	   listings.price,
	   ReviewCountCTE.ReviewsCount,
	   CalendarCountCTE.CalendarCount
FROM listings
INNER JOIN ReviewCountCTE
ON listings.id = ReviewCountCTE.listing_id
INNER JOIN CalendarCountCTE
ON listings.id = CalendarCountCTE.listing_id;
