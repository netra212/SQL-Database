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

-- Memory



