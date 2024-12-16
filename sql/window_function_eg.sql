WITH Doctors AS (
    SELECT 
        DISTINCT(CASE WHEN Occupation = "Doctor" THEN Name ELSE "" END) AS Doctor,
        ROW_NUMBER() OVER (ORDER BY Name) as ROW_NUM
    FROM Occupations
    HAVING Doctor != ""
), Professors AS (
    SELECT 
        DISTINCT(CASE WHEN Occupation = "Professor" THEN Name ELSE "" END) AS Professor,
        ROW_NUMBER() OVER (ORDER BY Name) as ROW_NUM
    FROM Occupations
    HAVING Professor != ""
), Singers AS (
    SELECT 
        DISTINCT(CASE WHEN Occupation = "Singer" THEN Name ELSE "" END) AS Singer,
        ROW_NUMBER() OVER (ORDER BY Name) as ROW_NUM
    FROM Occupations
    HAVING Singer != ""
), Actors AS (
    SELECT 
        DISTINCT(CASE WHEN Occupation = "Actor" THEN Name ELSE "" END) AS Actor,
        ROW_NUMBER() OVER (ORDER BY Name) as ROW_NUM
    FROM Occupations
    HAVING Actor != ""
), JOIN_ONE AS (
    SELECT Doctors.Doctor, Professors.Professor, Doctors.ROW_NUM
    FROM Doctors
        LEFT JOIN Professors ON Doctors.ROW_NUM = Professors.ROW_NUM
    UNION
    SELECT Doctors.Doctor, Professors.Professor, Professors.ROW_NUM
    FROM Doctors
        RIGHT JOIN Professors ON Doctors.ROW_NUM = Professors.ROW_NUM
), JOIN_TWO AS (
    SELECT JOIN_ONE.Doctor, JOIN_ONE.Professor, Singers.Singer, JOIN_ONE.ROW_NUM
    FROM JOIN_ONE
        LEFT JOIN Singers ON JOIN_ONE.ROW_NUM = Singers.ROW_NUM
    UNION
    SELECT JOIN_ONE.Doctor, JOIN_ONE.Professor, Singers.Singer, Singers.ROW_NUM
    FROM JOIN_ONE
        RIGHT JOIN Singers ON JOIN_ONE.ROW_NUM = Singers.ROW_NUM
)

SELECT JOIN_TWO.Doctor, JOIN_TWO.Professor, JOIN_TWO.Singer, Actors.Actor
    FROM JOIN_TWO
        LEFT JOIN Actors ON JOIN_TWO.ROW_NUM = Actors.ROW_NUM
UNION
SELECT JOIN_TWO.Doctor, JOIN_TWO.Professor, JOIN_TWO.Singer, Actors.Actor
    FROM JOIN_TWO
        RIGHT JOIN Actors ON JOIN_TWO.ROW_NUM = Actors.ROW_NUM
ORDER BY ISNULL(Doctor), Doctor, ISNULL(Professor), Professor, ISNULL(Singer), Singer, ISNULL(Actor), Actor



/*
A very clever way to do it (ChatGBT). First you caculate the row numbers partitioned by the
Occupations. Now we can group the occupations by the row number. Which was what I was trying to do with
my joins essentially. But instead of performing an aggreation on the grouped names we can pivot here and
create our occupation columns. Remember that the groupby is done first so this is why this works. We must
preform an aggreation on a groupby so we return max. This is semi redundant but required as there will only
be one instance of each occupation in the group as we partioned eariler by the row number. So once
we've done this we've got our unique colums of Names per occupation with a single nulled filled in for
rows where the occupation did not have a row_number for.
NOTE: This is actually a slightly better version than ChatGBT lol because I PARITIONED AND Ordered. Whereas ChatGBT didn't
so it tried and failed to do so in the final SELECT. GG
*/

WITH RankOccupation AS (
    SELECT
        Name,
        Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS ROW_NUM
    FROM Occupations
), GroupedOccupations AS (
    SELECT
        MAX(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
        MAX(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
        MAX(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
        MAX(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor,
        ROW_NUM
    FROM RankOccupation
    GROUP BY ROW_NUM
)

SELECT Doctor, Professor, Singer, Actor FROM GroupedOccupations
