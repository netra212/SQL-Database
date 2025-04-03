--  1. Select a particular database. 
-- USE zomato

-- 2. Count the number of rows. 
-- SELECT COUNT(*) FROM users;

-- 3. Return Random records. 
-- replicated sample function in pandas. 
-- SELECT * FROM users
-- ORDER BY rand() LIMIT 5;

-- 4. Find null values Or To find the null values. 
-- SELECT * FROM orders WHERE restaurant_rating IS NOT NULL;

-- To replace null value with 0. 
-- UPDATE orders
-- SET restaurant_rating = 0
-- WHERE restaurant_rating IS NULL

-- 5. Find the numbers of orders placed by each customer. 
-- SELECT t2.name, 
-- COUNT(*) AS '#orders' 
-- FROM orders t1
-- JOIN users t2
-- ON t1.user_id = t2.user_id
-- GROUP BY t2.user_id;

-- 6. Find resturants with most number of menu items. 
-- SELECT r_name,
-- COUNT(*) AS 'menu_items'
-- FROM zomato.restaurants t1
-- JOIN zomato.menu t2
-- ON t1.r_id = t2.r_id
-- GROUP BY t2.r_id

-- 7. find number of votes and avg rating for all the restaurants. 
-- SELECT r_name, 
-- COUNT(*) AS 'num_votes', 
-- ROUND(AVG(restaurant_rating)) AS 'avg_rating'
-- FROM orders t1
-- JOIN restaurants t2
-- ON t1.r_id = t2.r_id
-- WHERE restaurant_rating IS NOT NUll
-- GROUP BY t1.r_id

-- 8. Find the food that is being sold at most number of restaurants. 
-- SELECT t2.f_name, 
-- COUNT(*)
-- FROM menu t1
-- JOIN food t2
-- ON t1.f_id = t2.f_id
-- GROUP BY t1.f_id
-- ORDER BY COUNT(*) DESC LIMIT 1;

-- 9. Find restaurants with max revenue in a given month. 
-- SELECT MONTHNAME(DATE(date)), date FROM orders
-- SELECT r_name, SUM(amount) AS 'revenue'
-- FROM orders t1
-- JOIN restaurants t2
-- ON t1.r_id = t2.r_id
-- WHERE MONTHNAME(DATE(date)) = 'May'
-- GROUP BY t1.r_id
-- ORDER BY revenue DESC LIMIT 1

-- month by month revenue for a particular restaurant = kfc
SELECT MONTHNAME(DATE(date)), SUM(amount) AS 'revenue'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE r_name = 'kfc'
GROUP BY MONTHNAME(DATE(date));

-- 10. Find restaurants with sales > x. 
SELECT r_name, SUM(amount) AS 'revenue'
FROM orders t1
JOIN restaurants t2 
ON t1.r_id = t2.r_id
GROUP BY t1.r_id
HAVING revenue > 1500;

-- 11. Find Customers who have never ordered. 
SELECT user_id, name FROM users
EXCEPT 
SELECT t1.user_id, name FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id

-- 12. Show order details of a particular customer in a given date range. 

-- 13. Customer favorite food. 
-- 14. Find most costly restaurants (Avg price/dish).
-- 15. Find delivery partner compensation using the formula (#deliveries * 100 + 1000 * avg_rating)
-- 16. Find revenue per month for a restaurant. 
-- 17. Find correlation between deliver_time and total rating.







