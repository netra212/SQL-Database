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
-- SELECT * FROM campusx1.smartphones
-- WHERE price > 50000

-- BETWEEN
-- Q1. Find all phones with price ranges of 10000 and 20000
-- SELECT * FROM campusx1.smartphones
-- WHERE price > 10000 AND price < 20000

-- SELECT * FROM campusx1.smartphones
-- WHERE price BETWEEN 10000 AND 20000

-- Q2. Find phones with rating > 80 & price < 25000
-- SELECT * FROM campusx1.smartphones
-- WHERE rating > 80 AND price < 25000

-- Q3. Find all samsung phones with ram > 8GB
-- SELECT * FROM campusx1.smartphones 
-- WHERE brand_name = 'samsung' AND ram_capacity > 8

-- Q4. Find all samsung phones with snapdragon processor
-- SELECT * FROM campusx1.smartphones
-- WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon'

-- QUERY Execution ORDER. 
-- FROM JOIN WHERE GROUP BY HAVING SELECT DISTINCT ORDER BY
-- Frank Johns Wicked Grave Haunts Several Dull Owis

-- Find brands who sell phones with price > 50000
-- SELECT DISTINCT(brand_name)
-- FROM campusx1.smartphones
-- WHERE price > 50000

-- IN and NOT IN, If where condition ma multiple values ayo vane IN and NOT IN use garne.
-- Fetch the brand name either the processor_brand is either snapdragon, exynos, bionic. 
-- SELECT *
-- FROM campusx1.smartphones
-- WHERE processor_brand IN ('snapdragon', 'exynos', 'bionic')

-- Fetch the brand name either the processor_brand NOT snapdragon, exynos, bionic. 
-- SELECT *
-- FROM campusx1.smartphones
-- WHERE processor_brand NOT IN ('snapdragon', 'exynos', 'bionic')

-- UPDATE 






