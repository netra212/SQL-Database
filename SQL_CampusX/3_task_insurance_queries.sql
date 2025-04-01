
-- Q1. Show records of 'male' patient from 'southwest' region.
-- SELECT *
-- FROM campusx1.insurance_data
-- WHERE gender = 'male' AND region = 'southwest'

-- Q2. Show all records having bmi in range 30 to 45 both inclusive. 
-- SELECT * 
-- FROM campusx1.insurance_data
-- WHERE bmi BETWEEN 30 AND 45

-- Q3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make Column names as MinBP and MaxBP respectively. 
-- SELECT MIN(bloodpressure) AS 'MinBP', 
-- MAX(bloodpressure) AS 'MaxBP'
-- FROM campusx1.insurance_data
-- WHERE diabetic = "YES" AND smoker = 'Yes'

-- Q4. Find number of unique patients who are not from southwest region. 
-- SELECT COUNT(DISTINCT(PatientID)) AS "Unique Patients"
-- FROM campusx1.insurance_data
-- WHERE region <> 'southwest';

-- Q5. Total claim amount from male smoker.
-- SELECT SUM(claim)
-- FROM campusx1.insurance_data
-- WHERE gender = 'male';

-- Q6. Select all records of south region.
-- SELECT *
-- FROM campusx1.insurance_data
-- WHERE region LIKE '%south%'

-- Q7. No of patient having normal blood pressure. Normal range[90-120]
-- SELECT COUNT(*) AS "Num of Patients"
-- FROM campusx1.insurance_data
-- WHERE bloodpressure BETWEEN 90 AND 120;

-- Q8. No of patient below 17 years of age having normal blood pressure as per below formula -
	-- BP normal range = 80 + (age in years × 2) to 100 + (age in years × 2)
    -- Note: Formula taken just for practice, don't take in real sense.
-- SELECT COUNT(*) AS "Num of Patients below age 17"
-- FROM campusx1.insurance_data
-- WHERE age < 17 
-- AND (bloodpressure BETWEEN 80 + (age * 2) AND 100 + (age  * 2));
    
-- Q9. What is the average claim amount for non-smoking female patients who are diabetic?
-- SELECT AVG(claim) AS "Average claim amt of non-smoking female"
-- FROM campusx1.insurance_data
-- WHERE gender = "female" AND smoker = "No" AND diabetic = "Yes";

-- Q10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
-- UPDATE campusx1.insurance_data
-- SET PatientID = 50000
-- WHERE PatientID = 1234

-- Q11. Write a SQL query to delete all records for patients who are smokers and have no children.
-- DELETE PatientID
-- FROM campusx1.insurance_data
-- WHERE smoker = "YES" AND children = 0
