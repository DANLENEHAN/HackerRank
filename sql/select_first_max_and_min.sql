-- My Initial Solution
WITH SHORT_CITIES AS (
    SELECT
        CITY,
        LENGTH(CITY) AS CITY_LENGTH
    FROM STATION
    WHERE LENGTH(CITY) = (SELECT MIN(LENGTH(CITY)) FROM STATION)
    ORDER BY CITY
    LIMIT 1
), LONG_CITIES AS (
    SELECT
        CITY,
        LENGTH(CITY) AS CITY_LENGTH
    FROM STATION
    WHERE LENGTH(CITY) = (SELECT MAX(LENGTH(CITY)) FROM STATION)
    ORDER BY CITY
    LIMIT 1
)

SELECT * FROM SHORT_CITIES
UNION ALL
SELECT * FROM LONG_CITIES;

/*
A more optimal Solution

Min and max is done in a single query meaning less scans. As one is performed to calculate each value.
City length is also done in a single query meaning less scans. Prevents redundant calculations.
Then we get our short and long cities.

*/
WITH CITY_LENGTHS AS (
    SELECT 
        CITY,
        LENGTH(CITY) AS CITY_LENGTH
    FROM STATION
),
MIN_MAX_LENGTHS AS (
    SELECT
        MIN(CITY_LENGTH) AS MIN_LENGTH,
        MAX(CITY_LENGTH) AS MAX_LENGTH
    FROM CITY_LENGTHS
),
SHORT_CITIES AS (
    SELECT 
        CITY,
        CITY_LENGTH
    FROM CITY_LENGTHS, MIN_MAX_LENGTHS
    WHERE CITY_LENGTH = MIN_LENGTH
    ORDER BY CITY
    LIMIT 1
),
LONG_CITIES AS (
    SELECT 
        CITY,
        CITY_LENGTH
    FROM CITY_LENGTHS, MIN_MAX_LENGTHS
    WHERE CITY_LENGTH = MAX_LENGTH
    ORDER BY CITY
    LIMIT 1
)

SELECT * FROM SHORT_CITIES
UNION ALL
SELECT * FROM LONG_CITIES;
