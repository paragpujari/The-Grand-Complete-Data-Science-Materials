/*
    Get all orders for a given customer.
*/
---EXEC [dbo].[sp_Orders_Customer] 1
CREATE OR ALTER PROCEDURE [dbo].[sp_Orders_Customer]
(
   @CustomerID  INT
)
AS
  BEGIN
        SELECT * FROM Ordersss WHERE CustomerID = @CustomerID;
  END