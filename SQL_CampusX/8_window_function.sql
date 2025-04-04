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
-- 1. Find top 2 most paying customers of each month.
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

-- 2. Create roll no.from branch and marks. 





