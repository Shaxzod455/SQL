--  Minimum price of a product
SELECT MIN(Price) AS MinPrice
FROM Products;

--  Maximum salary
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

--  Count of customers
SELECT COUNT(*) AS CustomerCount
FROM Customers;

--  Unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

--  Total sales for product ID = 7
SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;

-- Average age of employees
SELECT AVG(Age) AS AvgAge
FROM Employees;

--  Number of employees per department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

--  Min and Max price grouped by category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

--  Total sales per customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

--  Departments having more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

-------------------------------------------------------------
--  Mid-Level Tasks
-------------------------------------------------------------

-- Total & average sales per product category
SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

--  Count employees from Department HR
SELECT COUNT(*) AS HREmployeeCount
FROM Employees
WHERE DepartmentName = 'HR';

-- Highest & lowest salary by department
SELECT DepartmentName,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

--  Average salary per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

--  AVG salary and COUNT employees per department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

--  Product categories with average price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

--  Total sales per year
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

--  Customers who placed at least 3 orders
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

--  Departments with average salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

-------------------------------------------------------------
--  Hard-Level Tasks
-------------------------------------------------------------

--  Avg price per category > 150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

--  Total sales per customer > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

--  Total & average salary per department with avg > 65000
SELECT DepartmentName,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

--  Total order amount for orders weighing > 50 (TSQL2012)
USE TSQL2012;
SELECT CustomerID,
       SUM(Freight) AS TotalFreightOver50,
       MIN(Freight) AS LeastFreight
FROM Sales.Orders
WHERE Freight > 50
GROUP BY CustomerID;

--  Total sales & count of unique products sold per month/year (≥ 2 products)
SELECT YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY OrderYear, OrderMonth;

--  MIN & MAX order quantity per year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
-------------------------------------------------------------
-- ✅ End of Script
-------------------------------------------------------------
