/* vriskoume tis gitonies kai ta ta spitia pou einai diathesima gia mia sigkekrimeni xroniki periodo
 emfanizontas tis evlomadiees times tous 
 Output : 1000 rows
1 */ 

SELECT DISTINCT "Location".listing_id, "Location".neighbourhood_cleansed,"Calendar".date,"Room".weekly_price
FROM "Location"
INNER JOIN "Calendar" ON "Location".listing_id ="Calendar".listing_id
LEFT OUTER JOIN "Room" ON "Room".listing_id= "Location".listing_id
WHERE "Calendar".date BETWEEN '2020-09-01' AND '2020-11-10'
LIMIT 1000 ;

/* vriskoume tis sintetagmenes spitiwn me zipcode 11526 , to opoio anikei stous ampelokipous
 Output : 10 rows  
2 */ 

SELECT "Geolocation".geometry_coordinates_0_0_0_0, "Geolocation".geometry_coordinates_0_0_0_1 ,
"Location".zipcode
FROM "Geolocation"
INNER JOIN "Location" ON  "Geolocation".properties_neighbourhood="Location".neighbourhood_cleansed
WHERE "Location".zipcode LIKE '%11526';

/* vriskoume ta stoixeia epivaivewsis tou host , ti geitonia , ta sxolia gia ti geitonia kai ti timi .
 Output : 11541 rows  
3 */ 

SELECT "Host".verifications ,"Host".neighbourhood,"Listing".neighborhood_overview,"Price".price
FROM "Listing"
LEFT OUTER JOIN "Host" 
ON "Host".id = "Listing".host_id 
INNER JOIN "Price" 
ON "Listing".id="Price".listing_id
WHERE "Listing".has_availability= 'true';

/* vriskoume to street pou i evdomadiea timi twn spitiwn tou street einai mikroteri apo 550$ kai to extra_people 
einai megalitero apo 5 , kanontas group by ana street .
// Output : 118 rows  
4 */ 

SELECT "Location".street, SUM("Price".price*7) AS Price
FROM "Price"
INNER JOIN "Location" ON  "Location".listing_id="Price".listing_id
WHERE "Price".extra_people > 5
GROUP BY "Location".street
HAVING SUM(price*7) < 550 ;

/* vriskoume to ploithos twn comments kai to athroisma twn reviews , kanontas group by an listing_id kai epilegontas 
count twn comments megalitero tou 150 .
// Output : 642 rows  
5 */ 

SELECT "Review".listing_id, COUNT("Review".comments) AS Count_of_Reviews_number , 
SUM("Listing".number_of_reviews) AS SUM_of_reviews_number
FROM "Listing"
INNER JOIN "Review" ON  "Listing".id="Review".listing_id
GROUP BY "Review".listing_id
HAVING COUNT("Review".comments) > 150 ;