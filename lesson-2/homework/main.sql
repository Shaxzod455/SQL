/* ================================
   BASIC LEVEL TASKS (10)
   ================================ */

-- 1. Create Employees table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

-- 2. Insert three records (different methods)
-- Single row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali', 6000.00);

-- Single row insert without column list
INSERT INTO Employees
VALUES (2, 'Dilshod', 5500.00);

-- Multi-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(3, 'Madina', 4800.00),
(4, 'Javlon', 5200.00);
GO

-- 3. Update salary
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;
GO

-- 4. Delete a record where EmpID=2
DELETE FROM Employees
WHERE EmpID = 2;
GO

-- 5. Difference (definition)
-- DELETE   → Removes rows, can use WHERE, can be rolled back.
-- TRUNCATE → Removes all rows, faster, cannot use WHERE, keeps structure.
-- DROP     → Deletes the entire table structure and data.

-- 6. Modify Name column length
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
GO

-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);
GO

-- 8. Change Salary data type to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
GO

-- 9. Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
GO

-- 10. Remove all records but keep Employees structure
TRUNCATE TABLE Employees;
GO


/* ================================
   INTERMEDIATE LEVEL TASKS (6)
   ================================ */

-- 1. Insert records into Departments using INSERT INTO SELECT
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'Finance'
UNION ALL
SELECT 3, 'IT'
UNION ALL
SELECT 4, 'Marketing'
UNION ALL
SELECT 5, 'Management';
GO

-- 2. Update Department of employees where Salary > 5000
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
GO

-- 3. Remove all employees but keep structure
TRUNCATE TABLE Employees;
GO

-- 4. Drop Department column
ALTER TABLE Employees
DROP COLUMN Department;
GO

-- 5. Rename Employees table to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';
GO

-- 6. Remove Departments table
DROP TABLE Departments;
GO


/* ================================
   ADVANCED LEVEL TASKS (9)
   ================================ */

-- 1. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Brand VARCHAR(50)
);
GO

-- 2. Add CHECK constraint on Price
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);
GO

-- 3. Add StockQuantity with default 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;
GO

-- 4. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
GO

-- 5. Insert 5 records
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Brand)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'HP'),
(2, 'Phone', 'Electronics', 800.00, 'Samsung'),
(3, 'Chair', 'Furniture', 150.00, 'IKEA'),
(4, 'Table', 'Furniture', 300.00, 'IKEA'),
(5, 'Shoes', 'Clothing', 90.00, 'Nike');
GO

-- 6. Create backup table using SELECT INTO
SELECT * INTO Products_Backup
FROM Products;
GO

-- 7. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';
GO

-- 8. Change Price datatype to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
GO

-- 9. Add IDENTITY column ProductCode starting from 1000, increment by 5
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
GO
