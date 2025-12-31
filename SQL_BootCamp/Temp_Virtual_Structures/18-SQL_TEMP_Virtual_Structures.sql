USE DATASCIENCE;

/*
   1. Create a local temporary table that stores customers from India with Score ≥ 800
*/

DROP TABLE IF EXISTS #local_temp;
SELECT * INTO #local_temp FROM Customers WHERE Country = 'India' AND Score >= 800;
SELECT * FROM #local_temp ORDER BY CreatedDate;

/*
2. Using a local temp table, calculate total sales per customer
*/
DROP TABLE IF EXISTS #temps;
SELECT CustomerID, SUM([Sales]) AS Total_Sales
INTO #temps
FROM Orders
GROUP BY CustomerID
SELECT * FROM #temps;

/*
3. Join a local temp table with the Customers table
*/
;with cte1 as(
SELECT * FROM #temps
),cte2 as(
SELECT * FROM Customers
)
SELECT 
a.CustomerID                                                      ,
b.FirstName                                                       ,
b.LastName                                                        ,
CONCAT(b.FirstName, ' ',b.LastName) AS FullName                   ,
a.Total_Sales
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY b.CreatedDate;


/*
4. Create a global temporary table that stores USA customers
*/
DROP TABLE IF EXISTS ##global_temp;
SELECT * INTO ##global_temp FROM Customers WHERE Country = 'USA'
SELECT * FROM ##global_temp ORDER BY CreatedDate;


/*
5. Use a global temp table to find USA customers who placed orders
*/
DROP TABLE IF EXISTS ##globaltemps;
;with cte1 as(
SELECT * FROM Customers WHERE Country = 'USA'
),cte2 as(
SELECT * FROM Orders
)
SELECT 
a.CustomerID                                                    ,
a.FirstName                                                     ,
a.LastName                                                      ,
b.OrderID                                                       ,
CONCAT(a.FirstName,' ',a.LastName)  AS Full_Name
INTO ##globaltemps
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY b.OrderDate;

SELECT * FROM ##globaltemps;


/*
6. Declare a table variable to store recent orders (after 2025-02-01)
*/


DECLARE @@TableVariable TABLE(
        OrderID        FLOAT          ,
		CustomerID     FLOAT          ,
		Sales          FLOAT          ,
		OrderDate      DATETIME
)
INSERT INTO  @@TableVariable
SELECT OrderID   , CustomerID ,Sales  , OrderDate 
FROM Orders
WHERE CONVERT(DATE,[OrderDate]) >= '2025-01-01'

SELECT * FROM @@TableVariable ORDER BY OrderDate;


/*
7. Find total sales per customer using a table variable
*/

DECLARE @@Table_Sales_Customer TABLE(
        CustomerID     INT          ,
		Total_Sales    INT
)
INSERT  INTO @@Table_Sales_Customer
SELECT CustomerID, SUM([Sales]) AS Total_Sales
FROM   Orders
GROUP BY CustomerID

SELECT * FROM @@Table_Sales_Customer;


/*
8. Create a view to show customer order details
*/

--DROP VIEW IF EXISTS vw_customer_order;

CREATE VIEW vw_customer_order 
AS
SELECT 
a.CustomerID                                                    ,
a.FirstName                                                     ,
a.LastName                                                      ,
b.OrderID                                                       ,
CONCAT(a.FirstName,' ',a.LastName)  AS Full_Name                ,
b.OrderStatus                                                   ,
b.OrderDate
FROM Customers a
JOIN Orders    b
ON   a.CustomerID = b.CustomerID

SELECT * FROM vw_customer_order ORDER BY OrderDate;

/*
9. Fetch all orders for germany customers using the view
*/

CREATE VIEW vw_orders_customers AS
SELECT 
a.CustomerID                                                    ,
a.FirstName                                                     ,
a.LastName                                                      ,
b.OrderID                                                       ,
a.Country                                                       ,
CONCAT(a.FirstName,' ',a.LastName)  AS Full_Name                ,
b.OrderStatus                                                   ,
b.OrderDate
FROM Customers a
JOIN Orders    b
ON   a.CustomerID = b.CustomerID
WHERE a.Country = 'Germany'


SELECT * FROM vw_orders_customers ORDER BY OrderDate;

/*
10. Fetch all orders for USA customers using the view
*/

CREATE VIEW vw_orders_customers_usa AS
SELECT 
a.CustomerID                                                    ,
a.FirstName                                                     ,
a.LastName                                                      ,
b.OrderID                                                       ,
a.Country                                                       ,
CONCAT(a.FirstName,' ',a.LastName)  AS Full_Name                ,
b.OrderStatus                                                   ,
b.OrderDate
FROM Customers a
JOIN Orders    b
ON   a.CustomerID = b.CustomerID
WHERE a.Country = 'USA'


SELECT * FROM vw_orders_customers_usa ORDER BY OrderDate;

/*
11. Create a view that shows total sales per customer
*/

CREATE VIEW vw_sales_customer AS
SELECT CustomerID, SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID

SELECT * FROM vw_sales_customer;


/*
12. Find customers with Sales > 100
*/

CREATE view vw_customers_sales AS
SELECT 
a.CustomerID                                                ,
a.FirstName                                                 ,
a.LastName                                                  ,
CONCAT(a.FirstName,' ',a.LastName)  AS Full_Name            ,
b.Sales
FROM Customers a
JOIN Orders    b
ON   a.CustomerID = b.CustomerID
WHERE b.Sales > 100;

select * from vw_customers_sales;


/*
13. Create an indexed view to store total sales per customer
*/
CREATE VIEW dbo.vw_IndexedCustomerSaless
WITH SCHEMABINDING
AS
SELECT CustomerID,
       COUNT_BIG(*) AS OrderCount,
       SUM(Sales) AS TotalSales
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- Step 2: Create clustered index
CREATE UNIQUE CLUSTERED INDEX IX_CustomerSaless
ON dbo.vw_IndexedCustomerSales (CustomerID);
