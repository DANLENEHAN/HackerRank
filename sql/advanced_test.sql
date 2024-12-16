-- Question 1
WITH temp_aggd AS (
    SELECT
        record_date,
        CASE WHEN data_type = 'max' THEN data_value END AS max_t,
        CASE WHEN data_type = 'min' THEN data_value END AS min_t,
        CASE WHEN data_type = 'avg' THEN data_value END AS avg_t
    FROM temperature_records
)

SELECT
    MONTH(record_date) as month,
    MAX(max_t) as max,
    MIN(min_t) as min,
    ROUND(AVG(avg_t)) as avg
FROM temp_aggd
GROUP BY MONTH(record_date);

-- Question 2
WITH emp_hours_worked AS (
    SELECT
    emp_id,
    timestamp,
    LEAD(timestamp) OVER (PARTITION BY emp_id, DATE(timestamp) ORDER BY emp_id, timestamp) as next_ts,
    FLOOR(((
        (
            HOUR(LEAD(timestamp) OVER (PARTITION BY emp_id, DATE(timestamp) ORDER BY emp_id, timestamp)) * 60
        ) +
        MINUTE(LEAD(timestamp) OVER (PARTITION BY emp_id, DATE(timestamp) ORDER BY emp_id, timestamp))
    ) - ((HOUR(timestamp) * 60) + MINUTE(timestamp))) / 60) as hours_worked
    FROM attendance
    WHERE DAYNAME(timestamp) IN ('Saturday', 'Sunday')
    ORDER BY emp_id, timestamp
)


SELECT
    emp_id,
    SUM(hours_worked)
FROM emp_hours_worked
GROUP BY emp_id
ORDER BY SUM(hours_worked) DESC
