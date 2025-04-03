-- Cross Joins. 
SELECT * 
FROM sql_cx_live.users1 t1
CROSS JOIN sql_cx_live.groups t2;

-- INNER JOIN.
SELECT * 
FROM sql_cx_live.membership t1
INNER JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- LEFT JOIN.
SELECT * 
FROM sql_cx_live.membership t1 -- memberships table will be left table 
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- RIGHT JOIN.
SELECT * 
FROM sql_cx_live.membership t1  
RIGHT JOIN sql_cx_live.users1 t2 -- users1 table will be right table
ON t1.user_id = t2.user_id;

-- FULL OUTER JOIN -- does not work on mysqlworkbench.


-- UNION --> removes the duplicates rows. 
SELECT * FROM sql_cx_live.person1
UNION
SELECT * FROM sql_cx_live.person2;

-- UNION ALL --> does not removes the duplicate rows. 
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

-- INTERSECT  --> returns common rows only.
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

-- EXCEPT  --> A - B or B - A operations meaning either A ko all rows hunxa or B ko all rows hunxa.
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

-- FULL OUTER JOIN
SELECT * FROM sql_cx_live.membership t1 -- memberships table will be left table 
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM sql_cx_live.membership t1  
RIGHT JOIN sql_cx_live.users1 t2 -- users1 table will be right table
ON t1.user_id = t2.user_id;

-- SELF JOIN
SELECT * FROM sql_cx_live.users t1
JOIN sql_cx_live.users t2
ON t1.emergency_contact = t2.user_id;

-- Joining on more than one cols. 
SELECT * FROM sql_cx_live.students t1
JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

SELECT * FROM sql_cx_live.students t1
LEFT JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

SELECT * FROM sql_cx_live.students t1
RIGHT JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

-- Joining more than 2 tables. 
-- 1. Find order name and corresponding category name. 
SELECT * 
FROM sql_cx_live.order_details t1
JOIN sql_cx_live.orders t2
ON t1.order_id = t2.order_id
JOIN sql_cx_live.users t3
ON t2.user_id = t3.user_id;

-- Filtering Columns after joining more than 2 columns. 
SELECT t1.order_id, t1.amount, t1.profit, t3.name
FROM sql_cx_live.order_details t1
JOIN sql_cx_live.orders t2
ON t1.order_id = t2.order_id
JOIN sql_cx_live.users t3
ON t2.user_id = t3.user_id;


-- Find order_id, name and city by joining users and orders. 
SELECT t1.order_id, t2.name, t2.city
FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id;

-- Find order_id, product category by joining order_details and category.
select t1.order_id, t2.category
from sql_cx_live.order_details t1
JOIN sql_cx_live.category t2
ON t1.category_id = t2.category_id;

-- Filtering Rows. 
-- 1. Find all the orders placed in pune. 
SELECT * 
FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune' AND t2.name = 'Sarita';

-- 2. Find all orders under Chairs Category.
-- JOIN order_details and category.

-- PRACTICE QUESTIONS.
-- 1. Find all profitable orders. 
SELECT t1.order_id,
SUM(t2.profit) AS "profit"
FROM sql_cx_live.orders t1
JOIN sql_cx_live.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id 
HAVING profit > 0;

-- 2. Find the customers who has placed max number of orders. 
-- join users and orders. 
SELECT name,
COUNT(*) AS 'num_orders' 
FROM sql_cx_live.orders t1
JOIN sql_cx_live.users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY num_orders DESC LIMIT 1;

-- 3. Which is the most profitable category.
-- Join order details and category.
SELECT t2.vertical, 
SUM(profit) AS 'profit' 
FROM sql_cx_live.order_details t1
JOIN sql_cx_live.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical -- since order_Id is repeating so
ORDER BY SUM(profit) DESC LIMIT 1;

-- 4. Which is the most profitable state. 
SELECT state, 
SUM(profit) AS 'profit' 
FROM sql_cx_live.orders t1
JOIN sql_cx_live.order_details t2
ON t1.order_id = t2.order_id
JOIN sql_cx_live.users t3
ON t1.user_id = t3.user_id
GROUP BY state
ORDER BY profit DESC LIMIT 1;

-- 5. Find all categories with profit higher than 5000.
SELECT t2.vertical, 
SUM(profit) AS 'profit' 
FROM sql_cx_live.order_details t1
JOIN sql_cx_live.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
HAVING profit > 3000