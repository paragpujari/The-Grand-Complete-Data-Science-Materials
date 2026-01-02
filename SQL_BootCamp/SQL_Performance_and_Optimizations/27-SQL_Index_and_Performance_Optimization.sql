USE DATASCIENCE;

/*
1.  Create an index to speed up searches on CustomerID in Orders
*/

CREATE CLUSTERED INDEX CIX_Orders_CustomerID ON Orders(CustomerID);

/*
2.  Create a composite index for OrderDate and CustomerID
*/

CREATE NONCLUSTERED INDEX NONCIX_Orders_OrderDate_CustomerID ON  Orders(CustomerID,OrderDate);

/*
3.  Identify missing index for frequent country-based filtering
*/

CREATE NONCLUSTERED INDEX NONCIX_Customers_Country ON Customers(Country);


/*
4. Query customers from India with optimized index
*/

SELECT * FROM Customers WHERE Country = 'India';

/*
5. View execution plan of a query
*/

SET STATISTICS PROFILE ON;

SELECT * FROM Customers WHERE CustomerID = 2;

/*
6.  estimated execution plan
*/

--SET SHOWPLAN_ALL ON;

SELECT * FROM Orders WHERE OrderDate >= '2025-02-01'

/*
7.  Find total sales per customer (optimized)

*/

SELECT CustomerID, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY CustomerID;


/*
8. Add index to speed aggregation
*/

CREATE NONCLUSTERED INDEX NONCIX_ORDERS_CUSTID_SALES ON Orders(CustomerID, Sales);


