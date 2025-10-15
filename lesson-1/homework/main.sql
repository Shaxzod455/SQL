-- 1.
CREATE DATABASE SchoolDB;
GO

-- 2.
USE SchoolDB;
GO

-- 3.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
GO

-- 4.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Dilshod', 22),
(3, 'Madina', 19);
GO

-- 5.
SELECT * FROM Students;
GO

-- 6.
UPDATE Students SET Age = 21 WHERE StudentID = 1;
GO

-- 7.
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(50)
);
GO

-- 8.
GRANT SELECT ON Students TO User1;
GO

-- 9.
BEGIN TRAN;
DELETE FROM Students WHERE Age < 18;
ROLLBACK; -- 
COMMIT;   -- 
GO
