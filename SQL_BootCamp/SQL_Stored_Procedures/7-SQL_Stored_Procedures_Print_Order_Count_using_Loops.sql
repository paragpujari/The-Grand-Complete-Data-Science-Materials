--USE DATASCIENCE;
--Loop Through Customers and Print Total Orders for each customer

--EXEC [DBO].[Print_Orders_for_each_customer]
CREATE OR ALTER PROCEDURE [DBO].[Print_Orders_for_each_customer]
AS
 BEGIN
     
    SET NOCOUNT ON;

	BEGIN TRANSACTION;

	 BEGIN TRY
	 
	       DECLARE @MinCustomer INT;
	       DECLARE @MaxCustomer INT;
	       DECLARE @TotalOrders INT;
	       
	       SELECT @MinCustomer = MIN([CustomerID])  FROM Customers;
	       
	       --SELECT @MinCustomer AS MinCustomer;
	       
	       
	       SELECT @MaxCustomer = MAX([CustomerID])  FROM Customers;
	       
	       --SELECT @MaxCustomer AS MaxCustomer;
	       
	        WHILE(@MinCustomer <= @MaxCustomer)
	          BEGIN
	                 PRINT CONCAT('Customer ID is:', @MinCustomer)
	  	           
	  	           /*--------Print the total order count for each customer-----------------------*/
	  	           
	  	           SELECT @TotalOrders = COUNT(1) FROM Orders WHERE CustomerID = @MinCustomer;
	  	           
	  	           PRINT CONCAT('Total Orders for the customer ' , @MinCustomer, 'is:', @TotalOrders)
	  	           
	  	           
	             SET @MinCustomer = @MinCustomer + 1;
	          END
	   COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
	    ROLLBACK TRANSACTION;
		SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
		SELECT ERROR_NUMBER();
	END CATCH
 END