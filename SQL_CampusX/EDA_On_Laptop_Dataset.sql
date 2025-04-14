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

-- 