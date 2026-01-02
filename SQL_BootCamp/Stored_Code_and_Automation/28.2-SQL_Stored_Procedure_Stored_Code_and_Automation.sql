/*
2.  Stored procedure to insert a new order with validation

SELECT * FROM Orders
*/
--EXEC [dbo].[Insert_Order_Sales] 1,1,10,768;
CREATE OR ALTER PROCEDURE [dbo].[Insert_Order_Sales]
(
    @ProductID            INT,
    @CustomerID           INT,
    @Quantity             INT,
    @Sales                DECIMAL(10,2)
)
AS 
  BEGIN

    BEGIN TRANSACTION;
	   BEGIN TRY
                  IF(@Quantity < 0)
	               BEGIN
	                  RAISERROR('Quantity must be greater than zero',16,1)
	               END
	              ELSE
	               BEGIN
	                  INSERT INTO Orders (
	            	                 ProductID                 , 
	            					 CustomerID                ,
	            					 Quantity                  ,
	            					 Sales                     ,
	            					 OrderDate                 ,
	            					 CreationTime
	            	             )
	            				 SELECT
	            				 @ProductID                    ,
	            				 @CustomerID				   ,
	            				 @Quantity  				   ,
	            				 @Sales     				   ,
	            				 GETDATE()                     ,
	            				 GETDATE()
	            				
	               END
		COMMIT TRANSACTION;

	 END TRY

	 BEGIN CATCH
	      SELECT ERROR_LINE();
		  SELECT ERROR_MESSAGE();
		  SELECT ERROR_NUMBER();
	 END   CATCH
  END
  