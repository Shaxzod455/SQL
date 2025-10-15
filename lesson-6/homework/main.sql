------------------------------------------------------
-- PUZZLE 1: Finding Distinct Values based on two cols
------------------------------------------------------

-- Usul 1: DISTINCT + LEAST/GREATEST (SQL Serverda MIN/MAX ishlatamiz)
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

-- Usul 2: GROUP BY
SELECT MIN(col1) AS col1, MAX(col2) AS col2
FROM InputTbl
GROUP BY CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
         CASE WHEN col1 < col2 THEN col2 ELSE col1 END;


------------------------------------------------------
-- PUZZLE 2: Removing Rows with All Zeroes
------------------------------------------------------

SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);


------------------------------------------------------
-- PUZZLE 3: Find those with odd ids
------------------------------------------------------

SELECT *
FROM section1
WHERE id % 2 = 1;


------------------------------------------------------
-- PUZZLE 4: Person with the smallest id
------------------------------------------------------

SELECT TOP 1 *
FROM section1
ORDER BY id ASC;


------------------------------------------------------
-- PUZZLE 5: Person with the highest id
------------------------------------------------------

SELECT TOP 1 *
FROM section1
ORDER BY id DESC;


------------------------------------------------------
-- PUZZLE 6: People whose name starts with b
------------------------------------------------------

SELECT *
FROM section1
WHERE name LIKE 'B%';


------------------------------------------------------
-- PUZZLE 7: Code contains literal underscore "_"
------------------------------------------------------

-- SQL Serverda ESCAPE qo‘llash kerak
SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
