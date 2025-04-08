create database campus;

use campus;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    emp_department VARCHAR(50),
    emp_salary DECIMAL(10, 2),
    emp_duration_in_days INT
);

INSERT INTO Employees (emp_id, emp_name, emp_department, emp_salary, emp_duration_in_days)
VALUES
(1, 'John Doe', 'IT', 60000, 365),
(2, 'Jane Smith', 'HR', 50000, 730),
(3, 'Bob Brown', 'Sales', 55000, 180),
(4, 'Alice White', 'IT', 70000, 540),
(5, 'Charlie Black', 'HR', 45000, 120),
(6, 'David Green', 'Marketing', 48000, 300),
(7, 'Eva Blue', 'Sales', 52000, 250),
(8, 'Frank Gray', 'IT', 62000, 400),
(9, 'Grace Yellow', 'Finance', 58000, 600),
(10, 'Henry Pink', 'Marketing', 47000, 365),
(11, 'Isla Purple', 'HR', 46000, 220),
(12, 'Jack Red', 'Sales', 51000, 540),
(13, 'Karen Orange', 'Finance', 61000, 730),
(14, 'Liam Cyan', 'IT', 64000, 365),
(15, 'Mia Violet', 'Marketing', 49000, 180),
(16, 'Noah Indigo', 'Sales', 53000, 450),
(17, 'Olivia Silver', 'HR', 47000, 500),
(18, 'Paul Bronze', 'IT', 69000, 600),
(19, 'Quincy Gold', 'Finance', 66000, 720),
(20, 'Rachel Platinum', 'Marketing', 46000, 365);

SELECT * FROM employees;


-- CTE - Stands for Common Table Expression, That we generally use when we are using a same 
-- sub-query for multiple times. 
-- Reasons of using:
	-- To enhance readability, reduce complexity, enhance performance. 
-- Query with 'WITH CLAUSE'
-- Query SUB-FOLDING.

-- Q1. Find the employees whose salary in the range +-2000 of average salary where deparment 
-- is sales and emp_duration > 200. 
-- step 1: we need to find the average salary on the basis of given condition.

SELECT 
AVG(emp_salary) AS 'avg_salary'
FROM employees
WHERE emp_department = 'abc' AND emp_duration_in_days > 200;

-- step 2: from the table, find the employees who lies in the range of the given range.
select * from 
employees  where 
emp_salary >(
			 select avg(emp_salary) 
             from employees 
             where emp_department = "it" 
             and 
                   emp_duration_in_days>200)-2000
and
emp_salary <(
			 select avg(emp_salary)  
             from employees 
             where emp_department = "it" 
             and 
                   emp_duration_in_days>200)+2000;

-- ISSUE 
     -- DECREASES REDABILITY.
     -- COMPLEXITY INCREASES.
     -- DECREASES PERFORMANCE.
     

-- Solve above problem using the common table expression. 
-- We write CTE with 'WITH CLAUSE'
-- CTE LIFE is only till the execution + formation {together} of the query. 
with t as
(
  select avg(emp_salary)  as avg_salary from employees where emp_department= 'it' and emp_duration_in_days>200
) 
select * from employees
where
emp_salary >(select avg_salary  from t ) - 2000
and  emp_salary<(select avg_salary from t )+2000

-- SELECT THE DEPARTMENT FROM EMPLOYEES TABLE WHOSE AVERAGE SALARY IS MORE THAN AVERAGE SALARY ACROSS ALL DEPARTMENTS. 

