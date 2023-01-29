UPDATE "Calendar"
SET price = REPLACE (price ,'$' , '')
;

UPDATE "Calendar"
SET price = REPLACE (price ,',' , '')
;


UPDATE "Calendar"
SET adjustable_price = REPLACE (adjustable_price ,'$' , '')
;

UPDATE "Calendar"
SET adjustable_price = REPLACE (adjustable_price ,',' , '')
;


ALTER TABLE "Calendar"
    ALTER COLUMN price TYPE numeric(10) USING price::numeric,
    ALTER COLUMN adjustable_price TYPE numeric(10) USING adjustable_price::numeric,
    ALTER COLUMN available TYPE boolean USING available::boolean;