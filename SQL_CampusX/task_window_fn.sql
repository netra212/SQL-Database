USE task_window_functions;

SELECT * FROM task_window_functions.insurance_data;

-- 1. What are the top 5 patients who claimed the highest insurance amounts?
SELECT PatientID, 
SUM(claim)
OVER(PARTITION BY PatientID) AS 'claim_amount'
FROM insurance_data









