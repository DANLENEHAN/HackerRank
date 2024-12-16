-- https://www.hackerrank.com/challenges/weather-observation-station-20/problem

WITH RN_Q AS (
    SELECT
        LAT_N,
        ROW_NUMBER() OVER (ORDER BY LAT_N ASC) AS rn FROM STATION
), MED_Q AS (
    SELECT
        CEIL(COUNT(LAT_N) / 2) AS N,
            CASE WHEN
                MOD(COUNT(LAT_N), 2) = 0 THEN MOD(COUNT(LAT_N), 2) + 1
                ELSE -1
                END AS N_ONE
            FROM STATION
)

SELECT ROUND(AVG(RN_Q.LAT_N), 4) FROM RN_Q CROSS JOIN MED_Q WHERE RN_Q.rn IN (MED_Q.N, MED_Q.N_ONE);
