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

-- EDA 
-- Univariate
-- Bivarite 
-- Numerical Numerical. 
-- Categorical Categorical. 
-- Categorical Numerical. 

-- 1. Head -> tail -> sample. 
    -- HEAD
    SELECT * FROM laptopdata
    ORDER BY `index` LIMIT 5;
    
    -- TAIL
    SELECT * FROM laptopdata
    ORDER BY `index` DESC LIMIT 5;
    
    -- RANDOM
     SELECT * FROM laptopdata
     ORDER BY rand() LIMIT 5;
        
-- 2. For numerical cols. 
    -- 8 number summary [count, min, max, std, q1, q2, q3]
   #  SELECT COUNT(Price), 
#     MAX(Price), 
#     MIN(Price), 
#     AVG(Price), 
#     STD(Price), 
#     PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY PRICE) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Q1',
#     PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY PRICE) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Median',
#     PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY PRICE) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Q3'
#     FROM laptopdata 
#     ORDER BY `index` LIMIT 1;

    -- Missing values. 
  #   SELECT COUNT(Price)
#     FROM laptopdata
#     WHERE PRICE IS NULL 

    -- Outliers. 
    # SELECT * FROM (SELECT *, 
#     PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY PRICE) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Q1',
#     PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY PRICE) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Q3'
#     FROM laptopdata) t
#     WHERE t.Price < t.Q1 - (1.5 * (t.Q3 - t.Q1)) OR 
#     t.Price > t.Q1 + (1.5 * (t.Q3 - t.Q1));

    -- Horizontal/Vertical histograms. 
    SELECT t.buckets, REPEAT('*', COUNT(*)/5) FROM (SELECT Price, 
    CASE 
        WHEN Price BETWEEN 0 AND 25000 THEN '0-25K'
        WHEN Price BETWEEN 25001 AND 50000 THEN '25K-50K'
        WHEN Price BETWEEN 50001 AND 75000 THEN '50K-75k'
        WHEN Price BETWEEN 75001 AND 100000 THEN '75K-100K'
        ELSE '>100K'
    END AS 'buckets'
    FROM laptopdata) t
    GROUP BY t.buckets;
    
-- 3. For categorical cols. 
    -- value counts --> pie chart. 
    -- missing values. 
    
    SELECT Company, COUNT(Company)
    FROM laptopdata;
    
-- 4. numerical values. 
    -- side by side 8 number analysis. 
    
    -- scatterplot. 
    
    -- correlation.

-- 5. categorical-categorical
    -- contingency table -> stacked bar chart. 
    
-- 6. numerical-categorical
    -- compare distribution across categories. 
    SELECT Company, 
    MIN(Price),MAX(Price), 
    AVG(Price), STD(Price)
    FROM laptopdata
    GROUP BY Company;
    
-- 7. missing value treatment. 

    SELECT * FROM laptopdata
    WHERE Price IS NULL;
    
    -- replace missing value with the mean of the price 
    UPDATE laptopdata
    SET Price = (SELECT AVG(Price)
    FROM laptopdata)
    WHERE Price IS NULL;
    
    -- replacing the mean price of the corresponding company.
    UPDATE laptopdata l1
    SET Price = (SELECT AVG(Price)
    FROM laptopdata l2 WHERE l2.company = l1.company)
    WHERE Price IS NULL;
    
    -- replacing with the company + processor. (Cpu core i5)
    UPDATE laptopdata l1
    SET Price = (SELECT AVG(Price)
    FROM laptopdata l2 WHERE l2.company = l1.company AND l2.Cpu_name = l1.Cpu_name)
    WHERE Price IS NULL;
    
-- 8. feature engineering.
    -- ppi
    ALTER TABLE laptopdata
    ADD COLUMN ppi INTEGER;

    SELECT ROUND(SQRT(resolution_width*resolution_height + resolution_width*resolution_height)/ Inches)
    FROM laptopdata;
    
    UPDATE laptopdata
    SET ppi = ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/ Inches);
    
    SELECT * FROM laptopdata
    ORDER BY ppi ASC;
    
    -- screen size bracket. 
    ALTER TABLE laptopdata
    ADD COLUMN screen_size VARCHAR(255) AFTER Inches;
    
    SELECT *, 
    CASE
        WHEN NTILE(3) OVER(ORDER BY Inches) = 1 THEN "small"
        WHEN NTILE(3) OVER(ORDER BY Inches) = 2 THEN "medium"
        ELSE "large"
    END AS 'Type'
    FROM laptopdata;
    
    UPDATE laptopdata
    SET screen_size = 
    CASE
        WHEN Inches < 14.0 THEN "small"
        WHEN Inches >= 14.0 AND Inches < 17.0 THEN "medium"
        ELSE "large"
    END;
    
    SELECT * FROM laptopdata;
    
    SELECT screen_size, AVG(Price)
    FROM laptopdata
    GROUP BY screen_size;
    
-- 10. one hot encoding.
    SELECT gpu_brand,
    CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END AS 'intel',
    CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END AS 'amd',
    CASE WHEN gpu_brand = 'nvidia' THEN 1 ELSE 0 END AS 'nvidia',
    CASE WHEN gpu_brand = 'arm' THEN 1 ELSE 0 END AS 'arm'
    FROM laptopdata;