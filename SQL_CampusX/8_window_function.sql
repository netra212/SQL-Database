use sub_query;
CREATE TABLE marks(
	name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name, branch, marks) VALUES
('Nitish', 'EEE', 82),
('Rishabh', 'EEE', 91),
('Anukant', 'EEE', 69),
('Rupesh', 'EEE', 55),
('Shubham', 'CSE', 78),
('Ved', 'CSE', 43),
('Deepak', 'CSE', 98),
('santosh', 'CSE', 54);

INSERT INTO marks (name, branch, marks) VALUES
('Netra', 'EEE', 82),
('Yagya', 'CSE', 98);

SELECT genre, 
AVG(votes) OVER() AS 'overall_avg',
MIN(votes) OVER(), 
MAX(votes) OVER(),
MIN(votes) OVER(PARTITION BY genre),
MAX(votes) OVER(PARTITION BY genre)
FROM sub_query.movies;

-- Aggregate function
-- 
SELECT *, 
AVG(marks) OVER(PARTITION BY branch) AS 'branch_avg'
FROM marks;

-- RANK/DENSE_RANK/ROW_NUMBER
-- RANK - Gives the rank on partition or Window.
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC )
FROM marks;

-- DENSE_RANK
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

-- ROW_NUMBER -- Giving row number. 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch) 
FROM marks;

-- 1. Find top 2 most paying customers of each month.
use zomato;
SELECT * FROM (
		SELECT user_id, MONTHNAME(date) AS 'month', 
		SUM(amount) AS 'total_amount',
		RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS 'month_rank'
		FROM orders
		GROUP BY MONTHNAME(date), user_id
		ORDER BY MONTHNAME(date)
) t
WHERE t.month_rank < 3
ORDER BY month DESC, month_rank ASC;

-- 2. Create roll no.from branch and marks.

-- FIRST_VALUE/LAST_VALUE/NTH_VALUE
use sub_query;

-- FIRST_VALUE
SELECT *, 
FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;

-- LAST_VALUE
-- Concepts of Frames also included. 
SELECT *, 
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

-- NTH_VALUE
SELECT *, 
NTH_VALUE(name, 2) OVER(PARTITION BY branch ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

-- Question.
-- 1. Find the branch toppers. 
SELECT name, branch FROM (
	SELECT *,
	LAST_VALUE(name) OVER w AS 'topper_name',
	LAST_VALUE(marks) OVER w AS 'topper_marks'
	FROM marks
) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks
WINDOW w AS (
	PARTITION BY branch ORDER BY marks DESC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);

-- LEAD & LAG
-- Used to create an lagging column. 
SELECT *, 
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks;

-- Find the Month on Month revenue growth of zomato.
USE zomato;

SELECT MONTHNAME(date), SUM(amount),
((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTH(date))) / LAG(SUM(amount)) OVER(ORDER BY MONTH(date)))*100
FROM orders
GROUP BY MONTHNAME(date)
ORDER BY MONTH(date) ASC



-- 2. FRAME clause.



