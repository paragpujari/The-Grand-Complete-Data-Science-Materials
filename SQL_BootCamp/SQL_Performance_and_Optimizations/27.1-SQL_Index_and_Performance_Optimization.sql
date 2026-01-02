USE DATASCIENCE;

/*
9.   Find customers who placed more than 2 orders9.  
*/

SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 2;


/* 10. Find latest order of the customer*/

SELECT CustomerID, MAX(OrderDate) AS LatestOrder
FROM Orders
GROUP BY CustomerID;

/* 11. Optimized INNER JOIN with indexed columns */

SELECT * FROM Customers a
INNER JOIN    Orders    b
ON            a.CustomerID = b.CustomerID
ORDER BY b.OrderDate;


/* 12.  Find customers with no orders  */

SELECT c.*
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


/* 13. Index for faster Join */

CREATE NONCLUSTERED INDEX NONCIX_Customers_CustID ON Customers(CustomerID);


/* 14. Find high-value customers (Sales > 500) */

SELECT * FROM Orders WHERE Sales > 500 ORDER BY OrderDate

/* 15. Optimize NULL checks  */

SELECT * FROM Orders WHERE ShipAddress IS NULL;

/* 16.  Create filtered index for Delivered orders */

CREATE NONCLUSTERED INDEX NONCIX_Orders_OrderStatus ON Orders(OrderStatus) WHERE OrderStatus = 'Delivered';

/* 17. Detect inefficient queries*/

SET STATISTICS IO ON;

SET STATISTICS TIME ON;