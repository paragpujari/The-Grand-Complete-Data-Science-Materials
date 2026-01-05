/*
Write a stored procedure that calculates the total sales for a particular customer

SELECT * FROM Orders ORDER BY CustomerID;

SELECT * FROM #total_Sales_Customer
*/
--EXEC [DBO].[Calculate_Total_Sales_Order_Customer] 28
CREATE OR ALTER PROCEDURE [DBO].[Calculate_Total_Sales_Order_Customer]
(
     @CustomerID    INT
)
AS
  BEGIN

   SET NOCOUNT ON;

     BEGIN TRANSACTION;

	    BEGIN TRY
              
	      /*---------------If the customer does not exists in the table, then throw the error--------------------------*/
		  IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
		    BEGIN
			     PRINT CONCAT('Customer',' ',@CustomerID,' ','does not exists in the table');
			END
	         
		 /*-----------Calculate the total sales for that particular customer-------------------------------------------*/
		 DROP TABLE IF EXISTS #Total_Sales_Customer_Order;

		 CREATE TABLE #Total_Sales_Customer_Order(
		           CustomerID            INT                  ,
				   Total_Sales           INT
		 )
		 SELECT 
		 CustomerID                                           ,
		 SUM([Sales])      AS  Total_Sales
		 FROM [DATASCIENCE].[DBO].[Orders]
		 WHERE CustomerID = @CustomerID
		 GROUP BY CustomerID;



		COMMIT TRANSACTION;

	 END TRY

	 BEGIN CATCH
	   ROLLBACK TRANSACTION;

	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
	   SELECT ERROR_NUMBER();
	 END CATCH
  END