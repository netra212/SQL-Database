-- CREATE TABLE users(
-- 	user_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
--     name VARCHAR(255) NOT NULL, 
--     email VARCHAR(255) NOT NULL UNIQUE, 
--     password VARCHAR(255) NOT NULL
-- )


-- INSERT INTO campusx1.users (user_id, name, email, password) VALUES (NULL, "netra", "netra@gmail.com", "1234")
-- INSERT INTO campusx1.users (user_id, name, email, password) VALUES (NULL, "ankit", "ankit@gmail.com", "123467") 

-- INSERTING MULTIPLE VALUES.  --
-- INSERT INTO campusx1.users VALUES
-- (NULL, 'rishabh', 'rishabh@gmail.com', '12345'),
-- (NULL, 'roshan', 'roshan1@gmail.com' , '12367'),
-- (NULL, 'rahul', 'rahul1@gmail.com', '3456')

---  QUERY ---
-- SELECT ALL
-- SELECT * FROM campusx1.smartphones WHERE 1 -- 1 MEANS NOT APPLYING ANY CONDITION, we need all the rows and all the columns. 

-- SELECT THREE COLUMNS
-- SELECT model, price, rating FROM campusx1.smartphones 

-- Alias or Renaming of cols.
-- SELECT os AS 'Operating System', model, battery_capacity as 'maH' FROM campusx1.smartphones;


-- Building Mathematical formula with SQL... In this case, Calculating PPI or Pixel Per inch.... Check formula on google. 
-- SELECT model, 
-- SQRT(resolution_width * resolution_width + resolution_height * resolution_height)/screen_size as 'PPI' 
-- FROM campusx1.smartphones

-- Creating CONSTANTS Columns. 
-- SELECT model, 'smartphone' AS 'type' FROM campusx1.smartphones 

-- DISTINCT --> to fetch unique values from columnbs,. 
-- SELECT DISTINCT(brand_name) as 'ALL brands' FROM campusx1.smartphones 
-- SELECT DISTINCT(processor_brand) as 'all processor' FROM campusx1.smartphones 

-- UNIQUE COMBINATION.
-- SELECT DISTINCT brand_name, processor_brand
-- FROM campusx1.smartphones 

-- Filter rows based on WHERE clause. 
-- Q1. Find all samsung phones. 
-- SELECT * FROM campusx1.smartphones 
-- WHERE brand_name = 'apple'

-- Q2. Find all phones with price > 50000
SELECT * FROM campusx1.smartphones
WHERE price > 50000


