USE DATASCIENCE;
/*
1. Show total sales for each OrderStatus as columns
*/

SELECT * FROM(
SELECT OrderStatus,Sales FROM Orders
)AS Source
PIVOT(
SUM([Sales])
FOR OrderStatus IN ([Delivered],[Shipped])
)AS pvt;

/*
2. Country-wise total sales using Customers table
*/

SELECT * FROM(
SELECT a.Country, b.Sales
FROM Customers a
JOIN          Orders    b
ON            a.CustomerID = b.CustomerID
)AS Source
PIVOT(
SUM([Sales])
FOR Country IN ([USA],[Germany])
)AS pvt;


/*
3. Pivot number of orders per month
*/

SELECT * FROM(
SELECT MONTH([OrderDate]) AS Total_Months, OrderID
FROM Orders
)AS Source
PIVOT(
COUNT([OrderID])
FOR Total_Months IN ([1],[2],[3],[12])
)AS pvt;

/*
4. unpivot sales data
*/


SELECT OrderStatus,[Sales] FROM(
SELECT OrderStatus,Sales FROM Orders
)AS Source
PIVOT(
SUM([Sales])
FOR OrderStatus IN ([Delivered],[Shipped])
)AS pvt
UNPIVOT(
[Sales]
FOR 
OrderStatus IN ([Delivered],[Shipped])
)AS unpvt;


/*
5. Pivot customer count by Country
*/

SELECT * FROM(
SELECT Country, CustomerID FROM Customers
)AS Source
PIVOT(
COUNT([CustomerID])
FOR Country IN 
([Germany],[USA],[India])
)AS pvt;


/*
6. Pivot total sales per ProductID
*/

SELECT * FROM(
SELECT ProductID,Sales FROM Orders
)AS Source
PIVOT(
SUM([Sales])
FOR ProductID IN ([101],[102],[104],[105])
)AS pvt;

/*
7. Replace NULL ShipAddress with BillAddress
*/

SELECT *,COALESCE([ShipAddress],[BillAddress],'Address Missing') AS Addresses FROM Orders;

/*
8.  Replace NULL Quantity with 1
*/

SELECT *,ISNULL(Quantity,1) AS Total_Quantity FROM Orders;

/*
9.  Find orders with both addresses missing
*/

;with cte as(
SELECT * FROM Orders WHERE ShipAddress IS NULL AND BillAddress IS NULL
)
SELECT OrderID FROM cte;

/*
10. Replace NULL Sales with Quantity × 10
*/

SELECT *,ISNULL(Sales,(Quantity * 10.0)) AS Total_Quantities FROM Orders;

/*
11. Count NULL values in ShipAddress
*/
;with cte1 as(
SELECT * FROM Orders WHERE ShipAddress IS NULL
)
SELECT COUNT(1) AS Total_values FROM cte1;

/*
12. Default OrderStatus if NULL
*/

SELECT *,COALESCE([OrderStatus],'default status') AS Neworderstatus
FROM Orders;


/*
13. Create full name of customers
*/

SELECT FirstName, LastName, CONCAT(FirstName,' ',LastName) AS Full_Name FROM Customers
ORDER BY CreatedDate;


/*
14. Convert customer names to uppercase
*/

SELECT *,UPPER(CONCAT(FirstName,' ',LastName)) as FullName FROM Customers;


/*
15. Find customers whose last name starts with ‘B’
*/

SELECT * FROM Customers WHERE LastName LIKE 'B%';


/*
16. Replace dots in addresses
*/

SELECT *,REPLACE(ShipAddress,'.',',') AS ShipAddresses FROM Orders;


/*
17. Length of customer names
*/

SELECT CustomerID, FirstName, LEN(FirstName) AS Firstnamelength
FROM Customers;


/*
18. Extract year from OrderDate
*/
SELECT *,YEAR([OrderDate]) as total_years FROM Orders
ORDER BY OrderDate;


/*
19. Find orders placed in February
*/

;with cte1 as(
SELECT *,MONTH([OrderDate]) as Total_months FROM Orders
)
SELECT * FROM cte1
WHERE Total_months = 2;

/*
20. Calculate delivery duration
*/

;with cte1 as(
SELECT *,DATEDIFF(DAY,OrderDate,ShipDate) as Total_Days FROM Orders
)
SELECT * FROM cte1;

/*
21.  Orders placed in last 30 days
*/

;with cte1 as(
SELECT *,GETDATE() AS PresentDate FROM Orders
),cte2 as(
SELECT *,DATEDIFF(DAY, OrderDate,PresentDate) AS Total_Days FROM cte1
)
SELECT * FROM cte2 where Total_Days <= 30 order by OrderDate;

/*
22. Format OrderDate
*/

;with cte1 as(
SELECT *,CONVERT(DATETIME,OrderDate) as Formatted_OrderDate FROM Orders
)
SELECT * FROM cte1;

/*
23.  Orders placed on weekends
*/

;with cte1 as(
SELECT *,DATENAME(WEEKDAY,[OrderDate]) AS weeks FROM Orders
)
SELECT * FROM cte1
WHERE weeks IN ('Saturday','Sunday');


/*
24.  Month-wise total sales
*/

;with cte1 as(
SELECT *,DATENAME(MONTH,[OrderDate]) as months FROM Orders
)
SELECT months, SUM([Sales]) AS Total_Sales
FROM cte1
GROUP BY months; 