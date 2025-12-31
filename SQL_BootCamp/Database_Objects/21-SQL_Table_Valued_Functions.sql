/*
Create a Table-Valued Function to get orders for a customer  ---fn_OrdersByCustomer
*/
--SELECT * FROM [dbo].[fn_OrdersByCustomer](1);
CREATE OR ALTER FUNCTION [dbo].[fn_OrdersByCustomer](@CustomerID INT)
RETURNS TABLE
AS
  RETURN
  (
     SELECT * FROM Orders WHERE CustomerID = @CustomerID
  );

--SELECT * FROM [dbo].[fn_customer_sumsales](1)
CREATE OR ALTER FUNCTION [dbo].[fn_customer_sumsales](@CustomerID INT)
RETURNS TABLE
AS
 RETURN
 (
   SELECT CustomerID, SUM([Sales]) AS Total_Sales
   FROM [Orders]
   WHERE CustomerID = @CustomerID
   GROUP BY CustomerID
 );