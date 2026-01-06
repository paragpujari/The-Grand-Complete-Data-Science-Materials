/*
Write a procedure to insert an order item details for that customer that exists in the customer table.

If we try to insert a customer in the orders table that does not exists in the customer table, then it will throw an error.

SELECT * FROM Orders  ORDER BY OrderID,ProductID;

EXEC dbo.Insert_Order_Details_Transaction_Error_Handling
     @OrderID                 =                    20                       ,
     @ProductID               =                    105                      ,
     @CustomerID              =                    5                        ,
     @SalesPersonID           =                    4                        ,
     @OrderDate               =                  '2026-01-01'               ,
     @ShipDate                =                  '2026-01-02'               ,
     @OrderStatus             =                  'Shipped'	                ,
     @ShipAddress             =                  'Delhi, India'             ,
     @BillAddress             =                  'Delhi, India'             ,
     @Quantity                =                  3                          ,
     @Sales                   =                  159  

*/
CREATE OR ALTER PROCEDURE [DBO].[Insert_Order_Details_Transaction_Error_Handling]
(
            @OrderID                   INT                                    ,
            @ProductID				   INT                                    ,
            @CustomerID				   INT                                    ,
            @SalesPersonID			   INT                                    ,
            @OrderDate                 DATETIME                               ,  
            @ShipDate				   DATETIME                               ,
            @OrderStatus               NVARCHAR(30)                           ,
            @ShipAddress			   NVARCHAR(30)                           ,
            @BillAddress			   NVARCHAR(30)                           ,
            @Quantity                  INT                                    ,
            @Sales					   INT 
)
AS
   BEGIN
        SET NOCOUNT ON;

		BEGIN TRANSACTION;

		     BEGIN TRY
			  /*---------------------Throw an error in the order table, if we try to insert a customer that does not exists in the customer table------------*/
			  IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
			     BEGIN
				     THROW 50004,'Customer ID does not exists in the customer table',1;
				 END

			/*----------------------Throw an error in the order table, if the same order no already exists in the order table---------------------------------*/
			IF EXISTS(SELECT * FROM Orders WHERE OrderID = @OrderID)
			    BEGIN
				  THROW 50005,'Order ID already exists in the order table',1;
				END

			/*---------------------Insert the order item details for that particular customer that already exists in the customer table------------------------*/
			INSERT INTO Orders(
			       OrderID                               ,
                   ProductID							 ,
                   CustomerID							 ,
                   SalesPersonID						 ,
                   OrderDate							 ,
                   ShipDate								 ,
                   OrderStatus							 ,
                   ShipAddress							 ,
                   BillAddress							 ,
                   Quantity								 ,
                   Sales								 ,
                   CreationTime
			)VALUES(
			       @OrderID                               ,
				   @ProductID    						  ,
				   @CustomerID   						  ,
				   @SalesPersonID						  ,
				   @OrderDate    						  ,
				   @ShipDate     						  ,
				   @OrderStatus  						  ,
				   @ShipAddress  						  ,
				   @BillAddress  						  ,
				   @Quantity     						  ,
				   @Sales        						  ,
				   GETDATE()
			);


		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	    THROW
		SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
		SELECT ERROR_NUMBER();
	END   CATCH;

END