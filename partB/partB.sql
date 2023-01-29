

// 1o erwtima 

SELECT COUNT(title) as count_of_movies , split_part(release_date::TEXT,'-',1) AS YEAR 
FROM movies_metadata
GROUP BY YEAR

// 2o erwtima 

UPDATE movies_metadata
SET genres =REPLACE(genres,E'\'', E'\"') ;


SELECT
y.x->'name' "name" , COUNT (id) 
FROM movies_metadata 
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y
GROUP BY y.x;

// 3o erwtima 

SELECT
 y.x->'name' "name" ,
 split_part(release_date::TEXT,'-',1) AS YEAR,
 COUNT (id) COUNT_OF_MOVIES 

FROM movies_metadata 
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y
GROUP BY y.x , YEAR;

// 4o erwtima 

ALTER TABLE ratings_small
ALTER COLUMN rating TYPE numeric USING rating::numeric;

SELECT
 y.x->'name' "name" ,
 SUM(rating)/COUNT(ratings_small.rating) as rating
FROM movies_metadata 
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y

INNER JOIN ratings_small
ON movies_metadata.id = ratings_small.movieid
GROUP BY y.x  
;

// 5o erwtima 

SELECT 
userid ,
COUNT(ratings_small.rating) as count_of_ratings
FROM ratings_small
GROUP BY userid 
ORDER BY userid
;

//6o erwtima

SELECT 
userid ,
SUM(ratings_small.rating)/COUNT(ratings_small.rating) as avg_of_ratings
FROM ratings_small
GROUP BY userid 
ORDER BY userid
;

// view table 


CREATE TABLE view_table as(
SELECT 
userid ,
COUNT(ratings_small.rating) AS count_of_ratings,
SUM(ratings_small.rating)/COUNT(ratings_small.rating) as avg_of_ratings
FROM ratings_small
GROUP BY userid 
ORDER BY userid)
;

ALTER TABLE view_table
ADD PRIMARY KEY (userid);

ALTER TABLE ratings_small
ADD FOREIGN KEY (userid) REFERENCES view_table(userid);

// insight

Φτιάχνουμε τον πίνακα view_table με τα στοιχεία τα οποία μας δίνουν να καταλάβουμε
, το πόσο αυστηρός κριτής είναι ο κάθε χρήστης και τη συχνότητα που βλέπει
ταινίες ο ίδιος .