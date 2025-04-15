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

SELECT * FROM uber_rides;







