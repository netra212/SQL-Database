USE campusx1;

SELECT * FROM (
	SELECT BattingTeam, batter, 
	SUM(batsman_run) AS 'total_run',
	DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
	FROM ipl_data
	GROUP BY BattingTeam, batter
) t
WHERE t.rank_within_team < 6
ORDER BY t.BattingTeam, t.rank_within_team;

-- Cumulative SUM. 
-- calculates the sum of a set of values up to a given point in time, 
-- includes all previsous values in the calculation.
-- Find total run made by V.kohli at 50th match, 100th match, and 200th match.
 
SELECT * FROM (
	SELECT
	CONCAT("Match- ", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
	SUM(batsman_run) AS 'runs_scored',
	SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_runs'
	FROM ipl_data
	WHERE batter = 'V Kohli'
	GROUP BY ID
) t
WHERE 
match_no = 'Match- 50' OR 
match_no = 'Match- 100' OR
match_no = 'Match- 200';

-- Cumulative Average. 
SELECT * FROM (
	SELECT
	CONCAT("Match- ", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
	SUM(batsman_run) AS 'runs_scored',
	SUM(SUM(batsman_run)) OVER w AS 'career_runs',
    AVG(SUM(batsman_run)) OVER w
	FROM ipl_data
	WHERE batter = 'V Kohli'
	GROUP BY ID
    WINDOW w AS (
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
) t;


-- Running Average or Moving Average. 
-- calculates the average value of a dataset over a moving window of consecutive data points. 
-- We decide the window = 5
-- Calculating the average between current & up to 5. Running Average depends on the near by 
-- values. Current trends ko lagiii... Running Average nikalxau. 

SELECT * FROM (
	SELECT
	CONCAT("Match- ", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
	SUM(batsman_run) AS 'runs_scored',
	SUM(SUM(batsman_run)) OVER w AS 'career_runs',
    AVG(SUM(batsman_run)) OVER w AS 'career_avg',
    AVG(SUM(batsman_run)) OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS 'rolling_avg'
	FROM ipl_data
	WHERE batter = 'V Kohli'
	GROUP BY ID
    WINDOW w AS (
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
) t;

-- Percent of Total. 
-- Like 36% of total_sales. 
use sql_cx_live;

SELECT *,
(total_value/SUM(total_value) OVER())*100 AS 'percent_of_total'
FROM (
	SELECT f_id, SUM(amount) AS 'total_values'
	FROM orders t1
	JOIN order_details t2
	ON t1.order_id = t2.order_id
) t
JOIN food t3
ON t.f_id = t3.f_id
ORDER BY (total_value/SUM(total_value) OVER())*100 DESC;












