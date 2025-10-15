-------------------------------------------------------------
-- LESSON 13: String & Mathematical Functions Practice
-------------------------------------------------------------

-- TABLE CREATION
CREATE TABLE Employees (
    EMPLOYEE_ID INT,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    EMAIL VARCHAR(255),
    PHONE_NUMBER VARCHAR(50),
    HIRE_DATE DATE,
    JOB_ID VARCHAR(50),
    SALARY FLOAT,
    COMMISSION_PCT FLOAT,
    MANAGER_ID INT,
    DEPARTMENT_ID INT
);

-- INSERT DATA
INSERT INTO Employees VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000.00, 0.00, 0, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1987-06-18', 'AD_VP', 17000.00, 0.00, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1987-06-19', 'AD_VP', 17000.00, 0.00, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1987-06-20', 'IT_PROG', 9000.00, 0.00, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1987-06-21', 'IT_PROG', 6000.00, 0.00, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1987-06-22', 'IT_PROG', 4800.00, 0.00, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1987-06-23', 'IT_PROG', 4800.00, 0.00, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1987-06-24', 'IT_PROG', 4200.00, 0.00, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1987-06-25', 'FI_MGR', 12000.00, 0.00, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1987-06-26', 'FI_ACCOUNT', 9000.00, 0.00, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '515.124.4269', '1987-06-27', 'FI_ACCOUNT', 8200.00, 0.00, 108, 100);

-------------------------------------------------------------
-- EASY TASKS
-------------------------------------------------------------

--  emp_id + first_name + last_name → '100-Steven King'
SELECT CAST(EMPLOYEE_ID AS VARCHAR) + '-' + FIRST_NAME + ' ' + LAST_NAME AS FullName
FROM Employees;

-- Replace '124' with '999' in phone_number
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');

--  Names starting with A, J, M → show first_name + its length
SELECT FIRST_NAME,
       LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;

--  Total salary for each manager
SELECT MANAGER_ID, SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;

--  Year + highest value from Max1, Max2, Max3
-- (Sample table and query)
CREATE TABLE TestMax (Year INT, Max1 INT, Max2 INT, Max3 INT);
INSERT INTO TestMax VALUES (2020, 20, 30, 10), (2021, 50, 40, 70);
SELECT Year, GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;

--  Odd numbered movies with description not boring
-- (Assume Cinema table)
 SELECT * FROM Cinema WHERE Id % 2 = 1 AND Description != 'boring';

--  Sort by Id, but Id=0 last (SingleOrder)
 SELECT * FROM SingleOrder ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

--  Select first non-null from columns
 SELECT COALESCE(Column1, Column2, Column3, NULL) AS FirstNonNull FROM Person;


-------------------------------------------------------------
-- MEDIUM TASKS
-------------------------------------------------------------

--  Split FullName into 3 parts
 SELECT PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
        PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
        PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
 FROM Students;

--  Orders delivered to CA → find those delivered to TX
 SELECT * FROM Orders WHERE CustomerID IN (
    SELECT CustomerID FROM Orders WHERE State = 'California'
 ) AND State = 'Texas';

--  Group concatenate values (DMLTable)
SELECT STRING_AGG(ColumnName, ', ') AS ConcatenatedValues FROM DMLTable;

--  Employees whose (first+last) name has ≥3 'a'
SELECT FIRST_NAME, LAST_NAME
FROM Employees
WHERE LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) <=
      LEN(FIRST_NAME + LAST_NAME) - 3;

--  Employees per dept + % worked >3 years
SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS PctOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;


-------------------------------------------------------------
-- DIFFICULT TASKS
-------------------------------------------------------------

-- 1️⃣Cumulative sum (current + previous rows)
-- SELECT StudentID, Value,
--        SUM(Value) OVER (ORDER BY StudentID ROWS UNBOUNDED PRECEDING) AS CumulativeValue
-- FROM Students;

-- 2️⃣ Students with same birthday
-- SELECT BirthDate, STRING_AGG(StudentName, ', ') AS Students
-- FROM Student
-- GROUP BY BirthDate
-- HAVING COUNT(*) > 1;

-- 3️⃣ Aggregate scores for each unique player pair
-- SELECT LEAST(PlayerA, PlayerB) AS Player1,
--        GREATEST(PlayerA, PlayerB) AS Player2,
--        SUM(Score) AS TotalScore
-- FROM PlayerScores
-- GROUP BY LEAST(PlayerA, PlayerB), GREATEST(PlayerA, PlayerB);

-- 4️⃣ Separate chars by type
DECLARE @txt VARCHAR(50) = 'tf56sd#%OqH';
SELECT 
    @txt AS Original,
    REPLACE(REPLACE(REPLACE(@txt, '#', ''), '%', ''), ' ', '') AS Cleaned,
    (SELECT STRING_AGG(value, '') FROM STRING_SPLIT(@txt, '') WHERE value LIKE '[A-Z]') AS UppercaseLetters,
    (SELECT STRING_AGG(value, '') FROM STRING_SPLIT(@txt, '') WHERE value LIKE '[a-z]') AS LowercaseLetters,
    (SELECT STRING_AGG(value, '') FROM STRING_SPLIT(@txt, '') WHERE value LIKE '[0-9]') AS Numbers,
    (SELECT STRING_AGG(value, '') FROM STRING_SPLIT(@txt, '') WHERE value NOT LIKE '[a-zA-Z0-9]') AS OtherChars;
