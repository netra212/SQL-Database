-- Find out top 10 countries' which have maximum A and D values.
SELECT t1.country,
MAX(t1.A) AS "A_max",
MAX(t2.D) AS "D_max"
FROM task_sql_joins.country_ab t1
JOIN task_sql_joins.country_cd t2
ON t1.region = t2.region
GROUP BY t1.country
ORDER BY A_max DESC LIMIT 10;

-- Find out highest CL value for 2020 for every region. 
-- Also sort the result in descending order. Also display the CL values in descending order.
SELECT Region,
MAX(CL) as 'max_cl'
FROM task_sql_joins.country_cl t1
JOIN task_sql_joins.country_ab t2
ON t1.country = t2.country
WHERE t1.Edition = 2020
GROUP BY Region
ORDER BY max_cl DESC;

-- Q-3 Find top-5 most sold products.
-- SELECT * 
-- FROM task_sql_joins.sales1 t1
-- JOIN products t2
-- ON t1.ProductID = t2.ProductID
-- GROUP BY t1.ProductID
-- ORDER BY total_quantity DESC LIMIT 5;

-- Q-4: Find sales man who sold most no of products.
-- Joins sales with employee. 
SELECT t1.SalesPersonID,
COUNT(t1.Quantity) AS 'total_sales'
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY total_sales DESC LIMIT 5;

-- Q-5: Sales man name who has most no of unique customer.
SELECT t1.SalesPersonID, 
COUNT(DISTINCT CustomerID) AS 'unique_customers'
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY unique_customers DESC LIMIT 5;

-- Q-6: Sales man who has generated most revenue. Show top 5.
SELECT t1.SalesPersonID, t3.FirstName, t3.LastName,
ROUND(SUM(t1.Quantity * t2.Price)) AS 'total_revenue'
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.products t2
ON t2.ProductID = t2.ProductID
JOIN task_sql_joins.employees t3
ON t1.SalesPersonID = t3.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY total_revenue DESC LIMIT 5;

-- Q-7: List all customers who have made more than 10 purchases.
SELECT t1.CustomerID, t2.FirstName, t2.LastName, 
COUNT(*) 
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.customer t2
ON t1.CustomerID = t2.CustomerID
GROUP BY t1.CustomerID
HAVING COUNT(*) > 10;

-- Q-8 : List all salespeople who have made sales to more than 5 customers.
SELECT t1.SalesPersonID, FirstName, LastName,
COUNT(DISTINCT CustomerID) AS 'unique_customers'
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
HAVING unique_customers > 5;

-- Q-9: List all pairs of customers who have made purchases with the same salesperson.
SELECT CONCAT(B.FirstName,' ',B.LastName) AS 'first_customer_name', 
CONCAT(C.FirstName,' ',C.LastName) AS 'second_customer_name'
FROM (SELECT t1.CustomerID AS 'first_customer',
t2.CustomerID AS 'second_customer',
t1.SalesPersonID 
FROM task_sql_joins.sales1 t1
JOIN task_sql_joins.sales1 t2
ON t1.SalesPersonID = t2.SalesPersonID
AND t1.CustomerID != t2.CustomerID) A
JOIN task_sql_joins.customer B
ON A.first_customer = B.CustomerID
JOIN task_sql_joins.customer C 
ON A.second_customer = C.CustomerID





