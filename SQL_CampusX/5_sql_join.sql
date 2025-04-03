-- Cross Joins. 
SELECT * 
FROM sql_cx_live.users1 t1
CROSS JOIN sql_cx_live.groups t2;

-- INNER JOIN.
SELECT * 
FROM sql_cx_live.membership t1
INNER JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- LEFT JOIN.
SELECT * 
FROM sql_cx_live.membership t1 -- memberships table will be left table 
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- RIGHT JOIN.
SELECT * 
FROM sql_cx_live.membership t1  
RIGHT JOIN sql_cx_live.users1 t2 -- users1 table will be right table
ON t1.user_id = t2.user_id;

-- FULL OUTER JOIN -- does not work on mysqlworkbench.


-- UNION --> removes the duplicates rows. 
SELECT * FROM sql_cx_live.person1
UNION
SELECT * FROM sql_cx_live.person2;

-- UNION ALL --> does not removes the duplicate rows. 
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

-- INTERSECT  --> returns common rows only.
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

-- EXCEPT  --> A - B or B - A operations meaning either A ko all rows hunxa or B ko all rows hunxa.
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

-- FULL OUTER JOIN
SELECT * FROM sql_cx_live.membership t1 -- memberships table will be left table 
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM sql_cx_live.membership t1  
RIGHT JOIN sql_cx_live.users1 t2 -- users1 table will be right table
ON t1.user_id = t2.user_id;


-- SELF JOIN
