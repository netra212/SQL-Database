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
-- AVG(restaurant_rating) AS 'avg_rating'
-- FROM orders t1
-- JOIN restaurants t2
-- ON t1.r_id = t2.r_id
-- WHERE restaurant_rating IS NOT NUll
-- GROUP BY t1.r_id

