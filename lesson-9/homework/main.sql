------------------------------------------------------------
-- LESSON 9: JOINS (INNER JOINS)
-- Compatible with SQL Server
-- Includes EASY (1–10), MEDIUM (11–20), and HARD (21–30)
------------------------------------------------------------


--------------------------
--  EASY LEVEL TASKS
--------------------------

-- 1. List all combinations of product names and supplier names
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

-- 2. Get all combinations of departments and employees
SELECT D.DepartmentName, E.Name AS EmployeeName
FROM Departments D
CROSS JOIN Employees E;

-- 3. List only the combinations where the supplier actually supplies the product
SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 4. List customer names and their order IDs
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 5. List product names and categories
SELECT P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.CategoryID = C.CategoryID;

-- 6. Get product names and orders where product IDs match
SELECT P.ProductName, O.OrderID, O.Quantity
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;

-- 7. List employees and their department names
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. List customer names and their payment IDs
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, P.PaymentID
FROM Payments P
INNER JOIN Customers C ON P.CustomerID = C.CustomerID;

-- 9. List all orders that have matching payments
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;

-- 10. Show orders where product price is more than 100
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;



--------------------------
--  MEDIUM LEVEL TASKS
--------------------------

-- 11. List all employees who made orders (assuming EmployeeID in Orders)
SELECT DISTINCT E.EmployeeID, E.Name AS EmployeeName
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID;

-- 12. List all customers and the total number of their orders
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 13. Show product name, supplier name, and category name together
SELECT P.ProductName, S.SupplierName, C.CategoryName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
INNER JOIN Categories C ON P.CategoryID = C.CategoryID;

-- 14. List all orders along with product and customer names
SELECT O.OrderID, P.ProductName, CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 15. Find the total amount of each payment by joining Orders and Payments
SELECT P.PaymentID, SUM(P.Amount) AS TotalPaid
FROM Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
GROUP BY P.PaymentID;

-- 16. Find which employees belong to which departments and how many employees per department
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;

-- 17. List all products that have been ordered at least once
SELECT DISTINCT P.ProductName
FROM Products P
INNER JOIN Orders O ON P.ProductID = O.ProductID;

-- 18. Find total quantity ordered for each product
SELECT P.ProductName, SUM(O.Quantity) AS TotalOrdered
FROM Products P
INNER JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY P.ProductName;

-- 19. List customers and total payment amount they made
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, SUM(P.Amount) AS TotalPaid
FROM Customers C
INNER JOIN Payments P ON C.CustomerID = P.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 20. Show supplier names and total number of products supplied
SELECT S.SupplierName, COUNT(P.ProductID) AS TotalProducts
FROM Suppliers S
INNER JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierName;



--------------------------
-- HARD LEVEL TASKS
--------------------------

-- 21. Show customer names and total quantity of products they ordered
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, SUM(O.Quantity) AS TotalQuantity
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 22. List employee name, department name, and total orders handled
SELECT E.Name AS EmployeeName, D.DepartmentName, COUNT(O.OrderID) AS OrdersHandled
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.Name, D.DepartmentName;

-- 23. Show each supplier and total sales (sum of order quantities * product price)
SELECT S.SupplierName, SUM(O.Quantity * P.Price) AS TotalSales
FROM Suppliers S
INNER JOIN Products P ON S.SupplierID = P.SupplierID
INNER JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY S.SupplierName;

-- 24. List top 3 customers who spent the most
SELECT TOP 3 CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, SUM(P.Amount) AS TotalSpent
FROM Customers C
INNER JOIN Payments P ON C.CustomerID = P.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

-- 25. List all products and how many times each was ordered
SELECT P.ProductName, COUNT(O.OrderID) AS TimesOrdered
FROM Products P
INNER JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY P.ProductName
ORDER BY TimesOrdered DESC;

-- 26. Find employees who have made orders with total value > 5000
SELECT E.Name AS EmployeeName, SUM(O.Quantity * P.Price) AS TotalSales
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY E.Name
HAVING SUM(O.Quantity * P.Price) > 5000;

-- 27. List all categories with average product price
SELECT C.CategoryName, AVG(P.Price) AS AvgPrice
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName;

-- 28. Show which department’s employees generated the most sales
SELECT D.DepartmentName, SUM(O.Quantity * P.Price) AS TotalSales
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY D.DepartmentName
ORDER BY TotalSales DESC;

-- 29. Find each customer’s most expensive product ordered
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, MAX(P.Price) AS MaxProductPrice
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Products P ON O.ProductID = P.ProductID
GROUP BY C.FirstName, C.LastName;

-- 30. Show total revenue per category
SELECT C.CategoryName, SUM(O.Quantity * P.Price) AS TotalRevenue
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
INNER JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY C.CategoryName
ORDER BY TotalRevenue DESC;
