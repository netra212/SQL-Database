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
) t


-- Running Average or Moving Average. 
-- calculates the average value of a dataset over a moving window of consecutive data points. 
-- We decide the window = 5
-- Calculating the average between current & up to 5. Running Average depends on the near by 
-- values. Current trends ko lagiii... Running Average nikalxau. 



