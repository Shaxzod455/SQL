------------------------------------------------------------
-- LESSON 10: JOINS (INNER, LEFT, RIGHT, FULL, SELF, CROSS)
-- Database: Sales & HR Schema
-- Compatible with SQL Server
------------------------------------------------------------


------------------------------------------------------------
--  EASY LEVEL TASKS
------------------------------------------------------------

-- 1. List all employee names and their department names (INNER JOIN)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 2. Show all employees and their departments, including those without departments (LEFT JOIN)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 3. Show all departments and the employees in them, even if no employee belongs (RIGHT JOIN)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 4. List all products and suppliers (INNER JOIN)
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 5. Show all products, including those that have no suppliers (LEFT JOIN)
SELECT P.ProductName, S.SupplierName
FROM Products P
LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 6. List all suppliers and the products they supply, even if they supply none (RIGHT JOIN)
SELECT P.ProductName, S.SupplierName
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 7. Show all customers and their payments (INNER JOIN)
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, P.PaymentID, P.Amount
FROM Customers C
INNER JOIN Payments P ON C.CustomerID = P.CustomerID;

-- 8. Show all customers and their payments, including customers without payments (LEFT JOIN)
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, P.PaymentID, P.Amount
FROM Customers C
LEFT JOIN Payments P ON C.CustomerID = P.CustomerID;

-- 9. Show all payments and their customers, including payments without valid customer info (RIGHT JOIN)
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, P.PaymentID, P.Amount
FROM Customers C
RIGHT JOIN Payments P ON C.CustomerID = P.CustomerID;



------------------------------------------------------------
-- MEDIUM LEVEL TASKS
------------------------------------------------------------

-- 10. List all products and categories (INNER JOIN)
SELECT P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.CategoryID = C.CategoryID;

-- 11. Show all products, even if no category assigned (LEFT JOIN)
SELECT P.ProductName, C.CategoryName
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID;

-- 12. Show all categories, even if no products belong (RIGHT JOIN)
SELECT P.ProductName, C.CategoryName
FROM Products P
RIGHT JOIN Categories C ON P.CategoryID = C.CategoryID;

-- 13. Combine LEFT and RIGHT join results to show all employees and all departments (FULL JOIN)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
FULL JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 14. Show all orders and related payments (INNER JOIN)
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;

-- 15. Show all orders, including those without payments (LEFT JOIN)
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID;

-- 16. Show all payments, even those not linked to orders (RIGHT JOIN)
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
RIGHT JOIN Payments P ON O.OrderID = P.OrderID;

-- 17. Show all orders, all payments (FULL JOIN)
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
FULL JOIN Payments P ON O.OrderID = P.OrderID;

-- 18. Find each employee and their manager (SELF JOIN)
SELECT E1.Name AS EmployeeName, E2.Name AS ManagerName
FROM Employees E1
LEFT JOIN Employees E2 ON E1.ManagerID = E2.EmployeeID;

-- 19. Show all products and orders, even if no orders exist (LEFT JOIN)
SELECT P.ProductName, O.OrderID, O.Quantity
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID;

-- 20. Show all departments and total employees per department (LEFT JOIN + GROUP BY)
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;



------------------------------------------------------------
-- HARD LEVEL TASKS
------------------------------------------------------------

-- 21. Show total sales (quantity * price) per supplier (INNER JOIN chain)
SELECT S.SupplierName, SUM(O.Quantity * P.Price) AS TotalSales
FROM Suppliers S
INNER JOIN Products P ON S.SupplierID = P.SupplierID
INNER JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY S.SupplierName;

-- 22. List all employees with department and total orders handled (LEFT JOIN)
SELECT E.Name AS EmployeeName, D.DepartmentName, COUNT(O.OrderID) AS OrdersHandled
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.Name, D.DepartmentName;

-- 23. List all customers with total payments (LEFT JOIN)
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, SUM(P.Amount) AS TotalPayments
FROM Customers C
LEFT JOIN Payments P ON C.CustomerID = P.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 24. Show each category with average product price (LEFT JOIN + GROUP BY)
SELECT C.CategoryName, AVG(P.Price) AS AvgPrice
FROM Categories C
LEFT JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName;

-- 25. Show employees and orders, even if no orders assigned (LEFT JOIN)
SELECT E.Name AS EmployeeName, O.OrderID, O.Quantity
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID;

-- 26. Cross join to show all possible combinations of customers and products
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, P.ProductName
FROM Customers C
CROSS JOIN Products P;

-- 27. Show total revenue per category including categories with no products (FULL JOIN)
SELECT C.CategoryName, SUM(O.Quantity * P.Price) AS TotalRevenue
FROM Categories C
FULL JOIN Products P ON C.CategoryID = P.CategoryID
FULL JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY C.CategoryName;

------------------------------------------------------------
-- END OF LESSON 10 (ALL JOIN TYPES)
------------------------------------------------------------
