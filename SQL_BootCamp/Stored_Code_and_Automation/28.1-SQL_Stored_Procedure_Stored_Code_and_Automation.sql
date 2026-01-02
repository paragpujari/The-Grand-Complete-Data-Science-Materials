/*

1.  Create a stored procedure to fetch all orders of a given customer

*/
--EXEC [dbo].[Fetch_Order_Details] 1;
CREATE OR ALTER PROCEDURE [dbo].[Fetch_Order_Details]
(
   @CustomerID  INT
)
AS
  BEGIN
   BEGIN TRANSACTION;

    BEGIN TRY
          SELECT 
	      a.CustomerID                                                ,
	      a.FirstName                                                 ,
	      a.LastName                                                  ,
	      CONCAT(a.FirstName, ' ', a.LastName) AS FullName            ,
	      b.OrderID                                                   ,       
          b.ProductID												  ,
          b.SalesPersonID											  ,
          b.OrderDate												  ,
          b.ShipDate												  ,
          b.OrderStatus												  ,
          b.ShipAddress												  ,
          b.BillAddress												  ,
          b.Quantity												  ,
          b.Sales													  ,
          b.CreationTime
	      FROM Customers a
	      JOIN Orders    b
	      ON   a.CustomerID = b.CustomerID
	      WHERE  a.CustomerID = @CustomerID;

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	     SELECT ERROR_LINE();
		 SELECT ERROR_MESSAGE();
		 SELECT ERROR_NUMBER();
	END CATCH

  END