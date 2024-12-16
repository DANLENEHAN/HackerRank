/*
	The idea here is to do a recursive inner join. For every end_date
	we want to recursively find the start date that matches it. Join to
	it maintain the original start date the whole time and overwrite our
	current end_date with the new end_date that we've just got from doing
	out join. The reason this makes sense is because the tasks start_date
	is always one day less than the tasks end_date. So for each given end_date
	we can find a start_date who's end_date is consecutive by joining on the start_date

	E.g.
						|T1 (SD) | T1 (ED)|
	default select - 	|	01	 |	02	  |
	Join One -			|		 |	03	  |
	Join Two -			|		 |	04	  |

	Every time we join or end_date to a start_date we get a new end_date
*/


WITH RECURSIVE GET_DATES_END AS (
    SELECT Start_Date, End_Date FROM Projects
    
    UNION ALL
    
    SELECT
        T1.Start_date, T2.End_Date
    FROM Projects T1
        INNER JOIN GET_DATES_END T2
            ON T1.End_Date = T2.Start_Date
), GET_PROJECT_END_DATES AS (
    SELECT MIN(Start_Date) AS Start_Date, End_Date FROM GET_DATES_END
        GROUP BY GET_DATES_END.End_Date
), GET_PROJECT_START_DATES AS (
    SELECT Start_Date, MAX(End_Date) as End_Date FROM GET_PROJECT_END_DATES
        GROUP BY GET_PROJECT_END_DATES.Start_Date
)

SELECT * FROM GET_PROJECT_START_DATES
ORDER BY End_Date - Start_Date, Start_date;
