/*
3.  Stored procedure to calculate total sales per customer
*/
--EXEC [dbo].[Calculate_Sales_per_Customer]
CREATE OR ALTER PROCEDURE[dbo].[Calculate_Sales_per_Customer]
AS
 BEGIN
     BEGIN TRANSACTION;
	   BEGIN TRY

	    SELECT a.CustomerID , SUM(b.Sales)    AS   Total_Sales
		FROM Customers a
		INNER JOIN    Orders    b
		ON            a.CustomerID = b.CustomerID
		GROUP BY a.CustomerID

	    COMMIT TRANSACTION;
	 END TRY

	BEGIN CATCH
	    SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
		SELECT ERROR_NUMBER();
	END CATCH
 END