USE task_window_functions;

SELECT * FROM task_window_functions.insurance_data;

-- 1. What are the top 5 patients who claimed the highest insurance amounts?
SELECT *, 
DENSE_RANK() OVER(ORDER BY claim DESC)
FROM insurance_data LIMIT 5;

-- 2. What is the average insurance claimed by patients based on the 
-- number of children they have?

SELECT children, avg_claim, row_num FROM (
	SELECT *,
	AVG(claim) OVER(PARTITION BY children) AS avg_claim,
	ROW_NUMBER() OVER(PARTITION BY children) AS row_num
	FROM insurance_data
) t
WHERE t.row_num = 1;

-- 3. What is the highest and lowest claimed amount by patients in each region?

SELECT * FROM (
	SELECT region,
	MAX(claim) OVER(PARTITION BY region) AS max_claim_region, 
	MIN(claim) OVER(PARTITION BY region) AS min_claim_region,
    ROW_NUMBER() OVER(PARTITION BY region) AS row_num
	FROM insurance_data
) t
WHERE t.row_num = 1;

-- 4. What is the percentage of smokers in each age group?
SELECT * FROM insurance_data;
-- DOUBT QUESTION.

-- 5. What is the difference between the claimed amount of each patient 
-- and the first claimed amount of that patient ?
SELECT *,
claim - FIRST_VALUE(claim) OVER() AS difference_amount
FROM insurance_data;

-- 6. For each patient, calculate the difference between their claimed
-- amount and the average claimed amount of patients with the same number of children.
SELECT 
claim - AVG(claim) OVER(PARTITION BY children)
FROM insurance_data;

-- 7. Show the patient with the highest BMI in each region and their respective rank.
SELECT * FROM (
	SELECT *,
	RANK() OVER(PARTITION BY region ORDER BY bmi DESC) AS 'own_group_rank',
	RANK() OVER(ORDER BY bmi DESC) AS 'overall_rank'
	FROM insurance_data
) t
WHERE t.own_group_rank = 1;

-- 8. Calculate the difference between the claimed amount of each patient and the 
-- claimed amount of the patient who has the highest BMI in their region.

SELECT *,
claim - FIRST_VALUE(claim) OVER(PARTITION BY region ORDER BY bmi DESC) AS 'highest_bmi'
FROM insurance_data


