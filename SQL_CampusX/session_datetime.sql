-- SQL DataTypes. 
-- 1. Numerical. 
-- 2. Text. 
-- 3. Temporal. 
-- 4. MISC. 

-- 1. DATE - Format: 2024/03/11
-- 2. TIME - 
-- 3. DATETIME
-- 4. TIMESTAMP
-- 5. YEAR

-- Creating and Populating Temporal Tables. 
-- Uber -> user_id, cab_id, start_time, end_time
USE campusx1;

CREATE TABLE uber_rides(
    ride_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
    user_id INTEGER, 
    cab_id INTEGER, 
    start_time DATETIME, 
    end_time DATETIME
);

INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
(1, 1, '2023-03-09 08:00:00', '2023-03-09 09:00:00');

INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
(2, 2, '2023-03-10 03:00:00', '2023-03-10 04:00:00');

INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
(6, 31, '2023-03-11 19:00:00', '2023-03-11 12:30:00');

INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
(22, 32, '2023-03-11 22:00:00', '2023-03-11 22:30:00');

INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
(22, 32, '2023-03-11 22:00:00', NOW());

SELECT * FROM uber_rides;

SELECT CURRENT_DATE();
SELECT CURRENT_TIME();
SELECT NOW(); -- Tells DATE & TIME Both. 

-- Extraction Functions. 
-- 1. DATE() & TIME()
    SELECT *, 
    DATE(start_time),
    TIME(end_time),
    YEAR(start_time),
    MONTH(start_time),
    MONTHNAME(start_time),
    DAYOFWEEK(start_time),
    QUARTER(start_time),
    HOUR(start_time),
    MINUTE(start_time),
    SECOND(start_time),
    DAYOFYEAR(start_time), 
    WEEKOFYEAR(start_time),
    LAST_DAY(start_time) -- Extract the last month and from that month, it extract the last day. 
    -- Suppose, last month is march then last day of march month is 31st will be display as output. 
    FROM uber_rides;

-- DATE_FORMAT()

SELECT start_time, 
DATE_FORMAT(start_time, '%d %b %y'),
end_time, 
DATE_FORMAT(end_time, '%l:%i %p')
FROM uber_rides;

-- Type Conversion
-- 1. Implicit Type Conversion.
-- 2. Explicity Type Conversion - STR_TO_DATE()
SELECT '2023-03-11' > '2023-03-09';

SELECT STR_TO_DATE('9 Mar 2023', '%e %b %y');

-- DATETIME Arithmetic. 
-- 1. DATEDIFF() -- DIFFERENCE BETWEEN TWO DATE.
SELECT DATEDIFF(CURRENT_DATE(), '2022-11-07');

SELECT TIMEDIFF(CURRENT_TIME(), '22:00:00');
SELECT TIMEDIFF(start_time, end_time);

-- DATE_ADD()
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 MONTH);

-- 
CREATE TABLE posts(
    post_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER,
    content TEXT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO posts(user_id, content) VALUES (1, "hello world");

SELECT * FROM posts;


