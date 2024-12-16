WITH SYM_PAIRS_WITH_FAKES AS (
    SELECT
    f1.X as x1, f1.Y as y1,
    f2.X as x2, f2.Y as y2,
    ROW_NUMBER() OVER (PARTITION BY f1.X, f1.Y, f2.X, f2.Y) AS ROW_NUM
FROM Functions f1
    INNER JOIN Functions f2
        ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
), SYM_PAIRS AS (
    SELECT SYM_PAIRS_WITH_FAKES.x1, SYM_PAIRS_WITH_FAKES.y1 FROM SYM_PAIRS_WITH_FAKES
        WHERE (
            SYM_PAIRS_WITH_FAKES.x1 != SYM_PAIRS_WITH_FAKES.y1 AND
            SYM_PAIRS_WITH_FAKES.y1 != SYM_PAIRS_WITH_FAKES.y2
        ) OR (
            SYM_PAIRS_WITH_FAKES.ROW_NUM = 2
        )
)

SELECT * FROM SYM_PAIRS;