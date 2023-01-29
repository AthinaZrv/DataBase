BEGIN;

/* Find all rentings from all houses that took place in the
16th of May 2020 .
Output: 11541 rows
1
*/

SELECT "Listings".id, "Listings".listing_url, "Calendar".date
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Calendar".date = '2020-05-16';

/* Find the reviews from all houses at Pagrati .
Output: 15956 rows
2
*/

SELECT "Listings".id, "Reviews".comments,"Listings".neighbourhood_cleansed,"Reviews".date
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".neighbourhood_cleansed = 'ΠΑΓΚΡΑΤΙ';

/* Find the reviews score rating with their comments from all houses at Keramikos .
Output: 13050 rows
3
*/

SELECT "Listings".review_scores_rating, "Reviews".comments,"Listings".neighbourhood_cleansed
FROM "Listings"
LEFT OUTER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".neighbourhood_cleansed = 'ΚΕΡΑΜΕΙΚΟΣ';

/* Find the streets , the names and the first coordinate from all houses 
at Agios Nikolaos , Keramikos , Pagrati order by neighborhood .
Output: 915 rows
4
*/

SELECT "Listings".street,"Listings".name,"Geolocation".properties_neighbourhood,"Geolocation".geometry_coordinates_0_0_0_0
FROM "Listings"
INNER JOIN "Geolocation"
ON "Listings".neighbourhood_cleansed = "Geolocation".properties_neighbourhood
WHERE "Listings".neighbourhood_cleansed = 'ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ'
OR "Listings".neighbourhood_cleansed = 'ΚΕΡΑΜΕΙΚΟΣ'
OR "Listings".neighbourhood_cleansed = 'ΠΑΓΚΡΑΤΙ'
ORDER BY "Geolocation".properties_neighbourhood;

/* Find the min and max nights and the average of all bedrooms from all neighborhoods
that their names begins with letter 'Α' .
Output: 1 row
5
*/

SELECT MAX("Listings".maximum_nights),MIN("Listings".minimum_nights),
AVG("Listings".bedrooms)
FROM "Listings"
WHERE "Listings".neighbourhood_cleansed LIKE 'Α%';

/* Find count of reviewers id from all neighborhoods
that their names begins with letter 'Π' .
Output: 9 rows
6
*/

SELECT "Listings".neighbourhood_cleansed,COUNT("Reviews".reviewer_id) AS "COUNT_OF_REVIEWERS_ID"
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Listings".neighbourhood_cleansed LIKE 'Π%'
GROUP BY "Listings".neighbourhood_cleansed;

/* Find comments that contains word 'space' and last review is between 9th of Semptember 2018
and 13th of March 2020 and print them with their prices and id with rows limit 13 .
Output: 13 rows
7
*/

SELECT "Listings".id,"Listings".last_review,"Listings".price,"Reviews".comments
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
WHERE "Reviews".comments LIKE '%money%'
AND "Listings".last_review BETWEEN '2018-09-09' AND '2020-03-13'
LIMIT 13;

/* Find id from all houses where they are available and their date is between 9th of January 2020 and 6th of November 2021
and their price is between 1 and 600 dolars and the name of their neighborhood begins with letter 'Γ'
or their neighborhood is Abelokipi with rows limit 150 and method distinct to remove the duplicates . 
Output: 150 rows
8
*/

SELECT DISTINCT"Listings".id , "Listings".neighbourhood_cleansed
FROM "Listings"
INNER JOIN "Calendar"
ON "Listings".id = "Calendar".listing_id
WHERE "Calendar".available = 't'
AND "Calendar".date BETWEEN '2020-01-09' AND '2021-11-06'
AND "Calendar".price BETWEEN '$1'AND '$600'
AND ("Listings".neighbourhood_cleansed LIKE 'Γ%' 
	OR "Listings".neighbourhood_cleansed= 'ΑΜΠΕΛΟΚΗΠΟΙ')
LIMIT 150;

/* Find the distance of the neighborhood Abelokipi squares from all the houses 
at Abelokipi and print their neighbourhood group .
Output: 330 rows
9
*/

SELECT "Listings".name, "Listings".square_feet,
"Neighbourhoods".neighbourhood , "Neighbourhoods".neighbourhood_group
FROM "Listings"
LEFT OUTER JOIN "Neighbourhoods"
ON "Listings".neighbourhood_cleansed = "Neighbourhoods".neighbourhood
WHERE"Neighbourhoods".neighbourhood = 'ΑΜΠΕΛΟΚΗΠΟΙ'
LIMIT 330;

/* Find the comments of the reveiews from the houses that
contains the varchar'$10' inside their prices , order by date .
Output: 200 rows
10
*/

SELECT "Listings".name, "Calendar".price,"Calendar".date,"Reviews".comments
FROM "Listings"
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
INNER JOIN "Calendar"
ON "Calendar".listing_id = "Reviews".listing_id
WHERE "Calendar".price LIKE '%$10%'
ORDER BY "Calendar".date
LIMIT 200;

/* Find the names , the comments of the reviews and the geometry_coordinates_0_0_6_1
from the houses that belongs at Abelokipi neighborhood and contains more than 1 bedrooms .
Output: 3144 rows
11
*/

SELECT "Listings".name,"Reviews".comments,"Neighbourhoods".neighbourhood,
"Geolocation".geometry_coordinates_0_0_6_1
FROM "Listings"
INNER JOIN "Neighbourhoods"
ON "Listings".neighbourhood_cleansed = "Neighbourhoods".neighbourhood
INNER JOIN "Reviews"
ON "Listings".id = "Reviews".listing_id
INNER JOIN "Geolocation"
ON "Neighbourhoods".neighbourhood = "Geolocation".properties_neighbourhood
WHERE "Neighbourhoods".neighbourhood = 'ΑΜΠΕΛΟΚΗΠΟΙ'
AND "Listings".bedrooms > 1
;

/* Find the minimum_nights , the comments from the reveiewers and the cleaning fee 
from all houses that their cleening fee are $48 or $40
Output: 550 rows
12
*/

SELECT "Calendar".minimum_nights,"Reviews".comments,"Listings".cleaning_fee
FROM "Calendar"
INNER JOIN "Reviews"
ON "Calendar".listing_id = "Reviews".listing_id
LEFT OUTER JOIN "Listings"
ON  "Calendar".listing_id = "Listings".id
WHERE "Listings".cleaning_fee LIKE '%$48.00%' 
OR "Listings".cleaning_fee LIKE '$40.00%'
ORDER BY "Calendar".minimum_nights DESC
LIMIT 550
;
 
COMMIT;
