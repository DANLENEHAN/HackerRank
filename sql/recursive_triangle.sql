WITH RECURSIVE STARS AS (
    SELECT SUBSTR(REPEAT('* ', 20), 1, 39) AS S_PRINT, 20 AS START_NUM
    UNION ALL
    SELECT SUBSTR(REPEAT('* ', START_NUM - 1), 1, ((START_NUM - 1)*2)-1), START_NUM - 1
    FROM STARS
    WHERE START_NUM > 0
)

SELECT S_PRINT FROM STARS;


-- The Hackerank Sample answer was confusing I thought I had to have a space
-- above and below the result but the one above had one space at the bottom I believe
-- so I wrote the below answer. But it turns out no spaces were needed. See last answer
WITH RECURSIVE STAR AS (
    SELECT SUBSTR(REPEAT('* ', 20), 1, 39) AS S_PRINT, 20 AS START_NUM
    UNION ALL
    SELECT
        CASE WHEN START_NUM > 0 THEN
            SUBSTR(REPEAT('* ', START_NUM - 1), 1, ((START_NUM - 1)*2)-1)
        ELSE '' END AS S_PRINT,
        CASE WHEN START_NUM > 0 THEN START_NUM - 1 ELSE 22 END AS START_NUM
    FROM STAR
    WHERE START_NUM != 22
)

SELECT S_PRINT FROM STAR ORDER BY START_NUM;


WITH RECURSIVE STARS AS (
    SELECT SUBSTR(REPEAT('* ', 20), 1, 39) AS S_PRINT, 20 AS START_NUM
    UNION ALL
    SELECT SUBSTR(REPEAT('* ', START_NUM - 1), 1, ((START_NUM - 1)*2)-1), START_NUM - 1
    FROM STARS
    WHERE START_NUM > 1
)

SELECT S_PRINT FROM STARS ORDER BY START_NUM;