WITH HACKER_DAY_SUBS AS (
    SELECT 
        hacker_id,
        submission_date,
        DENSE_RANK() OVER(PARTITION BY hacker_id ORDER BY submission_date) as day_rank
    FROM Submissions
), CONSECUTIVE_HACKERS_PER_DAY AS (
    SELECT * FROM HACKER_DAY_SUBS
    WHERE DATEADD(DAY, - (day_rank - 1), submission_date) = '2016-03-01'
), UNIQUE_HACKERS_PER_DAY AS (
    SELECT submission_date, COUNT(DISTINCT(hacker_id)) AS count_subs
    FROM CONSECUTIVE_HACKERS_PER_DAY
    GROUP BY submission_date
), MAX_SUBBED_HACKERS_PER_DAY AS (
    SELECT submission_date, hacker_id, COUNT(submission_id) as max_subs FROM Submissions
    GROUP BY submission_date, hacker_id
), MAX_SUBBED_HACKER_PER_DAY AS (
    SELECT submission_date, hacker_id, max_subs,
    RANK() OVER(PARTITION BY submission_date ORDER BY max_subs DESC, hacker_id) as hacker_rank
    FROM MAX_SUBBED_HACKERS_PER_DAY
)

SELECT
    UNIQUE_HACKERS_PER_DAY.submission_date,
    UNIQUE_HACKERS_PER_DAY.count_subs,
    MAX_SUBBED_HACKER_PER_DAY.hacker_id,
    Hackers.name
    FROM UNIQUE_HACKERS_PER_DAY
        INNER JOIN MAX_SUBBED_HACKER_PER_DAY
            ON UNIQUE_HACKERS_PER_DAY.submission_date = MAX_SUBBED_HACKER_PER_DAY.submission_date AND MAX_SUBBED_HACKER_PER_DAY.hacker_rank = 1
        INNER JOIN Hackers ON Hackers.hacker_id = MAX_SUBBED_HACKER_PER_DAY.hacker_id
    ORDER BY UNIQUE_HACKERS_PER_DAY.submission_date;


/*
This one took a while for two reasons. The first is because the description was of course ambigous as fuck just look at the
discussions. Which is where I went to figure out that they were looking for the hackers with the most submissions on each given
day reguardless of whether they'd submitted on all pior days or not. The second part was my use of DENSE_RANK above instead of RANK.
RANK will assign the same RANK to rows with identical values which is fine but it skips the next rank and assigns it next rank plus
one so for example if someone submitted twice on day one they'd both get a rank of 1 which is correct but if they then submitted on
day two the rank it would get is three. DENSE_RANK has the same behaviour of setting identical ranks to rows with identical values but it
doesn't skip rows which is what we want here.

*/