# String Data Types. 
# CHAR:
# VARCHAR:
# TEXT:
# MEDIMUMTEXT:
# LONGTEXT:   

SELECT * FROM sub_query.movies;

SELECT name
FROM sub_query.movies
WHERE name LIKE '____';
-- Each UnderScore represent one characters means i need that movies whose character len is 5. 

-- Movies starts with A.
SELECT name
FROM sub_query.movies
WHERE name LIKE 'A____';

-- Gives me the Name of the movies where movies name ends with `an`. 
SELECT name FROM movies
WHERE name LIKE '%an';

-- STRING FUNCTIONS --
-- UPPER and LOWER
SELECT name, UPPER(name), LOWER(name)
FROM sub_query.movies;

-- CONCAT & concat_ws
-- If we want movie_name plus director name then we can use the CONCAT operator. 
SELECT CONCAT(name, ' Directed by --> ', director) 
FROM sub_query.movies;

-- concat_ws
SELECT CONCAT_WS('@',name,director,star) 
FROM sub_query.movies;

-- Fetch the name start with 1 characters up to 5
SELECT name, SUBSTR(name, 1,5) 
FROM sub_query.movies;

-- start from 5 to 10 from the name column. 
SELECT name, SUBSTR(name, 5,10) 
FROM sub_query.movies;

-- Last 5 characters. 
SELECT name, SUBSTR(name, -5) 
FROM sub_query.movies;

-- last 5 characters 
SELECT name, SUBSTR(name, -5, 5) 
FROM sub_query.movies;

-- Replacing man with the women. 
SELECT REPLACE(name, "man", "woman")
FROM sub_query.movies;

-- Checking Palindrome. 
SELECT name 
FROM sub_query.movies
WHERE name = REVERSE(name);

-- LENGTH & CHAR_LENGTH of the movies. 
SELECT name, LENGTH(name), char_length(name)
FROM sub_query.movies;

-- INSERT
SELECT INSERT("hello world", 7, 0, "india");
-- str: The original string to insert into.
-- pos: The position at which to insert the new substring. The first position is 1.
-- len: The number of characters to replace.
-- newstr: The new substring to insert.

-- LEFT & RIGHT. 
-- Left batww 3 ta characters & right batww 3 ta charactersm nikalerww dine. 
SELECT name, LEFT(name, 3), RIGHT(name, 3)
FROM sub_query.movies;

-- Removing leading and trailing spaces.
SELECT TRIM("    nitish   ");

--
SELECT TRIM(BOTH "." FROM ".........netra.......");
SELECT TRIM(LEADING "." FROM ".........netra.......");
SELECT LENGTH(LTRIM("   nitish  "));
SELECT RTRIM("  nitish  ");

SELECT SUBSTRING_INDEX("www.campusx.in", ".", 1); -- First batww dot ka xa teha dekhii split garxa. 
SELECT SUBSTRING_INDEX("www.campusx.in", ".", -1); -- Last batww dot ka xa teha dekhi split garxa. 

-- STRCMP
SELECT STRCMP("Delhi", "Mumbai");

-- LOCATE
SELECT LOCATE("w", "hello world");

-- Padding at Left and Right.
SELECT LPAD('8888888888', '13', '+44');
SELECT RPAD('8888888888', '13', '+44');

-- EDA On Laptop Datasets.
-- 1. Create backup
CREATE TABLE laptops_backups LIKE laptopdata;

INSERT INTO laptops_backups
SELECT * FROM laptopdata;

-- 2. Check number of rows

-- 3. Check memory consumption for reference.
-- 256 kb.
SELECT DATA_LENGTH/1024 FROM information_schema.TABLES
WHERE TABLE_SCHEMA = "sub_query"
AND TABLE_NAME = "laptopdata"; 

-- 4. Drop non important cols
ALTER TABLE laptopdata
DROP COLUMN `Unnamed: 0`;

-- Checking. 
SELECT * FROM laptopdata;

-- 5. Drop null values.
-- QUERY FORMAT IS CORRECT BUT SINCE NO INDEX IS PRESENT IN THE DATA SO. 
DELETE FROM laptopdata 
WHERE `index` IN (SELECT `index` FROM laptopdata
WHERE Company IS NULL AND 
TypeName IS NULL AND 
Inches IS NULL AND 
ScreenResolution IS NULL AND 
Cpu IS NULL AND 
Ram IS NULL AND
Memory IS NULL AND 
Gpu IS NULL AND
OpSys IS NULL AND 
Weight IS NULL AND 
Price IS NULL);

-- 6. Drop duplicates
-- Fetching the id of the first occurance.
DELETE FROM zomato.duplicates 
WHERE id NOT IN (SELECT MIN(id)  
FROM zomato.duplicates
GROUP BY name, gender, age);

--
-- For categorical DISTINCT is very good functions. 
SELECT DISTINCT Company FROM laptopdata;
SELECT DISTINCT TypeName FROM laptopdata;
ALTER TABLE laptopdata MODIFY COLUMN Inches DECIMAL(10, 1);
# SELECT * FROM laptopdata;
SELECT DISTINCT ScreenResolution FROM laptopdata; -- Too much hetic column.
SELECT DISTINCT Cpu FROM laptopdata; -- Too much hetic column.
SELECT DISTINCT Ram FROM laptopdata;

UPDATE laptopdata l1
SET Ram = (SELECT REPLACE(Ram, 'GB', '') 
            FROM laptopdata l2 
            WHERE l2.index = l1.index);

SELECT * FROM laptopdata;

# Modifying Ram Column to Integer.
ALTER TABLE laptopdata MODIFY COLUMN Ram INTEGER;

# 
SELECT DISTINCT Memory FROM laptopdata;
SELECT GPU FROM laptopdata;

-- Upating the Weight Column. 
UPDATE laptopdata l1
SET Weight = (SELECT REPLACE(Weight, 'kg', '') 
              FROM laptopdata l2 WHERE l2.index = l1.index);

-- PRICE COL. 
UPDATE laptopdata l1
SET Price = (SELECT REPLACE(Price, 'kg', '') 
              FROM laptopdata l2 WHERE l2.index = l1.index);

ALTER TABLE laptopdata MODIFY COLUMN Price INTEGER;

SELECT 
OpSys FROM laptopdata;

-- mac
-- windows
-- linux
-- no os
-- Android chrome (others)

SELECT OpSys,
CASE
    WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE 'windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys = 'No OS' THEN 'N/A'
    ELSE 'other'
END AS 'os_brand'
FROM laptopdata;

UPDATE laptopdata
SET OpSys = 
CASE
    WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE 'windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys = 'No OS' THEN 'N/A'
    ELSE 'other'
END;
SELECT * FROM laptopdata;


-- Making two new column.
ALTER TABLE laptopdata
ADD COLUMN gpu_brand VARCHAR(255) AFTER Gpu, 
ADD COLUMN gpu_name VARCHAR(255) AFTER gpu_brand;

SELECT * FROM laptopdata;

UPDATE laptopdata l1
SET gpu_brand = (SELECT Gpu, SUBSTRING_INDEX(Gpu, ' ', 1) 
FROM laptopdata l2 WHERE l2.index = l1.index);

SELECT * FROM laptopdata;

UPDATE laptopdata l1
SET gpu_name = (SELECT REPLACE(Gpu, gpu_brand, '') 
                FROM laptopdata l2 
                WHERE l2.index = l1.index);


-- Dropping the GPU Column name. 
ALTER TABLE laptopdata DROP COLUMN Gpu;
SELECT * FROM laptopdata;

-- -------------------
ALTER TABLE laptopdata
ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu, 
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand, 
ADD COLUMN cpu_speed DECIMAL(10, 1) AFTER cpu_name;

SELECT * FROM laptopdata;

UPDATE laptopdata l1
SET cpu_brand = (SELECT SUBSTRING_INDEX(Cpu, ' ', 1)
FROM laptopdata l2 WHERE l2.index = l1.index);

SELECT * FROM laptopdata;

-- 
UPDATE laptopdata l1
SET cpu_brand = (SELECT 
                CAST(REPLACE(SUBSTRING_INDEX(Cpu, ' ', -1), 'GHz', '') 
                AS DECIMAL(10, 2))
                WHERE l2.index = l1.index);

SELECT * FROM laptopdata;
