/*
20.2  Create a stored procedure on Get total sales per customer
*/
--EXEC [dbo].[sp_Total_Sales_Customer]
CREATE OR ALTER PROCEDURE [dbo].[sp_Total_Sales_Customer]
AS
 BEGIN
         SELECT 
         a.CustomerID                                        ,
         SUM(b.[Sales])               AS   Total_Sales
         FROM Customersss a
         INNER JOIN    Ordersss    b
         ON            a.CustomerID = b.CustomerID
         GROUP BY a.CustomerID
 END