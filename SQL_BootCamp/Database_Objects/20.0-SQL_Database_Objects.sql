USE DATASCIENCE;
/*
1. Create a clustered index on Customers table to improve search by CustomerID
*/
CREATE CLUSTERED INDEX CIX_Customers_CustomerID ON Customersss(CustomerID);
/*
2. Create a non-clustered index on Country column to optimize filtering by country
*/
CREATE NONCLUSTERED INDEX CIX_Customersss_Country ON Customersss(Country);
/*
3. Create a composite index on Orders(CustomerID, OrderDate)
*/
CREATE NONCLUSTERED INDEX NONCIX_Orders_CustomerID_OrderDate ON Ordersss(CustomerID, OrderDate);
/*
4. Create a covering index to avoid key lookup when querying OrderDate, Sales
*/
CREATE NONCLUSTERED INDEX NONCIX_Orders_OrderDate ON Ordersss(OrderDate) INCLUDE (Sales,Quantity);

