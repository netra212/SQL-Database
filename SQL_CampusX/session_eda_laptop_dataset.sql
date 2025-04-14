USE sub_query;

SELECT * FROM sub_query.laptopdata;

-- Breaking the ScreenResolution Column into Multiple Columns. 
SELECT ScreenResolution 
FROM sub_query.laptopdata;

-- Fetching only screen resolution column. 
SELECT ScreenResolution, 
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', 1) AS screen_height,
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', -1) AS screen_width
FROM sub_query.laptopdata;

-- Now, Creating a new column. 
ALTER TABLE laptopdata
ADD COLUMN resolution_width INTEGER AFTER ScreenResolution, 
ADD COLUMN resolution_height INTEGER AFTER resolution_width;

UPDATE laptopdata
SET resolution_width = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', 1);

UPDATE laptopdata
SET resolution_height = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', -1);

SELECT * FROM laptopdata;

ALTER TABLE laptopdata
ADD COLUMN touchscreen INTEGER AFTER resolution_height;

SELECT ScreenResolution LIKE '%Touch%' FROM laptopdata;

UPDATE laptopdata
SET touchscreen = ScreenResolution LIKE '%Touch%';

SELECT * FROM laptopdata;

ALTER TABLE laptopdata
DROP COLUMN ScreenResolution;

SELECT * FROM laptopdata;

-- Cpu_name


-- Memory --> Converted to three columns such as Type | primary storage | secondary storage
-- Type     | primary storage | secondary storage
--  HDD     |   1024          | 0
-- Hybrid   |   526           | 1
-- 
ALTER TABLE laptopdata
ADD COLUMN memory_type VARCHAR(255) AFTER Memory,
ADD COLUMN primary_storage INT AFTER memory_type,
ADD COLUMN secondary_storage INT AFTER primary_storage;

SELECT * FROM laptopdata;

SELECT Memory,
CASE
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
END AS 'memory_type'
FROM laptopdata;

UPDATE laptopdata
SET memory_type = CASE
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    ELSE NULL
END;

SELECT * FROM laptopdata;

SELECT Memory, 
REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', 1),'[0-9]+'),
CASE WHEN Memory LIKE '%+%' THEN  REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', -1), '[0-9]+') ELSE 0 END FROM laptopdata;

SELECT 
primary_storage, 
CASE
    WHEN primary_storage <= 2 THEN primary_storage*1024
    ELSE primary_storage END
FROM laptopdata;

SELECT
secondary_storage,
CASE WHEN secondary_storage <= 2 THEN secondary_storage*1024
    ELSE secondary_storage END
FROM laptopdata;





