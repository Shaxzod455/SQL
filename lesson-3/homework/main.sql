-- 1. BULK INSERT izohi:
-- BULK INSERT ma'lumotlarni tashqi fayldan (txt, csv, va boshqalar) tezda SQL Server jadvaliga import qilish uchun ishlatiladi.

-- 2. SQL Serverga import qilinadigan fayl formatlari:
-- CSV, TXT, XML, JSON (boshqa formatlar ham qo‘llab-quvvatlanadi).

-- 3. Products jadvali yaratish
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
GO

-- 4. 3 ta yozuv qo‘shish
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'Laptop', 1200.50),
(2, 'Phone', 800.00),
(3, 'Tablet', 500.00);
GO

-- 5. NULL va NOT NULL farqi:
-- NULL  → qiymat yo‘qligini bildiradi (bo‘sh).
-- NOT NULL → ustunda qiymat bo‘lishi majburiy.

-- 6. UNIQUE constraint qo‘shish (ProductName ustuniga)
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
GO

-- 7. SQL izoh (comment) yozish
-- Quyidagi query barcha Products ma’lumotlarini ko‘rsatadi
SELECT * FROM Products;
GO

-- 8. CategoryID ustunini qo‘shish
ALTER TABLE Products
ADD CategoryID INT;
GO

-- 9. Categories jadvali yaratish
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
GO

-- 10. IDENTITY izohi:
-- IDENTITY ustuni SQL Serverda avtomatik ravishda o‘sib boruvchi raqam hosil qiladi (masalan, 1,2,3...)


/* ================================
   🟠 MEDIUM LEVEL TASKS (10)
   ================================ */

-- 1. BULK INSERT (misol, Products.txt fayldan)
-- Eslatma: Fayl yo‘li haqiqiy joylashuvga qarab o‘zgartiriladi
/*
BULK INSERT Products
FROM 'C:\Data\Products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
*/

-- 2. FOREIGN KEY qo‘shish
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
GO

-- 3. PRIMARY KEY vs UNIQUE KEY izohi:
-- PRIMARY KEY → yagona va NULL bo‘lishi mumkin emas.
-- UNIQUE KEY  → takrorlanmas qiymat, ammo 1 ta NULL qabul qiladi.

-- 4. CHECK constraint (Price > 0)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);
GO

-- 5. Stock ustuni qo‘shish
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
GO

-- 6. ISNULL funksiyasi (NULL ni 0 ga almashtirish)
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
GO

-- 7. FOREIGN KEY izohi:
-- FOREIGN KEY jadval orasidagi bog‘liqlikni ta’minlaydi.
-- Bu constraint referential integrity (bog‘langan ma’lumotlarning to‘g‘riligini) saqlaydi.


/* ================================
   🔴 HARD LEVEL TASKS (10)
   ================================ */

-- 1. Customers jadvali (Age >= 18 bo‘lishi shart)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);
GO

-- 2. IDENTITY column bilan jadval (100 dan boshlanadi, +10)
CREATE TABLE TestIdentity (
    ID INT IDENTITY(100,10) PRIMARY KEY,
    Name VARCHAR(50)
);
GO

-- 3. Composite PRIMARY KEY (OrderDetails)
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
GO

-- 4. COALESCE va ISNULL izohi:
-- ISNULL(expr, value) → faqat bitta alternativ qiymat beradi.
-- COALESCE(expr1, expr2, expr3, ...) → birinchi NULL bo‘lmagan qiymatni qaytaradi.

-- 5. Employees jadvali (PRIMARY KEY + UNIQUE KEY)
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);
GO

-- 6. FOREIGN KEY ON DELETE CASCADE va ON UPDATE CASCADE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO
