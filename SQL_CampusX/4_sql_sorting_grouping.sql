--  SORTING DATA
-- 1. Find top 5 samsung phones with biggest screen size.
SELECT model, screen_size
FROM campusx1.smartphones
WHERE brand_name = "samsung"
ORDER BY screen_size DESC LIMIT 5;

-- 2. Sort all the phone in descending order of number of total cameras. 
SELECT model, (num_front_cameras + num_rear_cameras) AS "Total_Cameras"
FROM campusx1.smartphones
ORDER BY Total_Cameras DESC;

-- 3. Sort data on the basis of ppi in decreasing order. 
SELECT model, 
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/ screen_size) AS 'PPI'
FROM campusx1.smartphones
ORDER BY PPI ASC;

-- 4. Find the Phone with 2nd largest battery. 
SELECT model, battery_capacity
FROM campusx1.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1; -- 1st 1 --> means 0-1 samma ko lagii naline, 1 dekhii yata 1 matra phone nikalerww dey vaneko ho ... 2nd 1 means kati wata phone nikalne. 
-- First number le offset vancha, 2nd number le number of rows vancha. 

-- 5. Find the name and rating of the worst rated apple phone. 
SELECT model, rating
FROM campusx1.smartphones
WHERE brand_name = "apple"
ORDER BY rating ASC LIMIT 1;

-- 6. sort phones alphabetically and then on the basis of rating in desc order. 
SELECT brand_name, price, rating
FROM campusx1.smartphones
ORDER BY brand_name ASC, rating DESC;

-- 7. sort phones alphabetically and then on the basis of price in asc order. 

-- GROUPING DATA. 
-- 1. Group smartphones by brand and get the count, average price, max rating, avg screen size and avg battery capacity 

SELECT brand_name, COUNT(*) AS "num_phones",
ROUND(AVG(price)) AS "avg price",
MAX(rating) AS "max_rating",
ROUND(AVG(screen_size), 2) AS "avg_screen_size",
ROUND(AVG(battery_capacity),2) AS 'avg_battery_capacity'
FROM campusx1.smartphones
GROUP BY brand_name
ORDER BY num_phones DESC LIMIT 15;
-- Group by Animation. Order of Code Execution: FJWGHSDO

-- 2. Group smartphones by whether they have an NFC and get the average price and rating. 
SELECT has_nfc,
AVG(price) AS 'price',
AVG(rating) AS 'rating'
FROM campusx1.smartphones
GROUP BY has_nfc;

-- 3. Group smartphones by the extended memory available and get the average price.

SELECT extended_memory_available,
AVG(price)
FROM campusx1.smartphones
GROUP BY extended_memory_available;

-- Grouping with multiple columns.
-- Like has_5g (yes, no), has_nfc(yes, no)
-- Total Groups: 4 groups like yes-yes, yes no, no-no, no-yes.

-- 4. Group smartphones by the brand and processor brand and get 
-- the count of models and the average primary camera resolution (rear). 
SELECT brand_name, 
processor_brand,
COUNT(*) AS "num phones",
ROUND(AVG(primary_camera_rear),2) AS "avg camera resolution"
FROM campusx1.smartphones
GROUP BY brand_name, processor_brand;

-- 5. Find top 5 most costly phone brands. 
SELECT brand_name, 
AVG(price) AS "avg_price"
FROM campusx1.smartphones
GROUP BY brand_name
ORDER BY avg_price DESC LIMIT 5;

-- 6. Which brand makes the smallest screen smartphones. 
SELECT brand_name, 
ROUND(AVG(screen_size),2) AS "avg_screen_size"
FROM campusx1.smartphones
GROUP BY brand_name
ORDER BY avg_screen_size ASC LIMIT 1;

-- 7. Avg price of 5g phones vs avg price of non 5g phones. 

-- 8. Group smartphones by the brand, and find the brand with 
-- highest number of models that have both NFC and IR blaster. 
SELECT brand_name, COUNT(*) AS "count"
FROM campusx1.smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'True'
GROUP BY brand_name
ORDER BY count DESC LIMIT 1;

-- 9. Find all samsung 5g enabled smartphones and find out the avg price 
-- for NFC and Non-NFC phones. 
SELECT has_nfc,
AVG(price) AS "avg_price"
FROM campusx1.smartphones
WHERE brand_name = 'samsung'
GROUP BY has_nfc;

-- HAVING CLAUSE.
-- 1. Find the avg rating of smartphones brands which have more than 20 phones. 
-- 2. 
