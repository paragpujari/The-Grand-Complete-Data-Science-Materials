/*
Write a stored procedure to perform the merge operation to only update those orders if it exists
but inserts new orders if it does not exists.

SELECT * FROM Orders ORDER BY OrderID,ProductID;

MERGE UPSERT into Orders

EXEC dbo.Upsert_Order_Merge
     @OrderID = 13,
     @ProductID = 105,
     @CustomerID = 3,
     @SalesPersonID = 3,
     @OrderDate = '2026-01-03',
     @ShipDate = '2026-01-05',
     @OrderStatus = 'Delivered',
     @ShipAddress = 'Vine Lane',
     @BillAddress = '4310 Clay Road',
     @Quantity = 5,
     @Sales = 155;

*/
CREATE OR ALTER PROCEDURE [DBO].[Upsert_Order_Merge]
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
         BEGIN TRANSACTION;

		       BEGIN TRY

			     --------------Perform the Merge Operation to update the orders if it exists and insert new orders if it does not exists------------
				MERGE INTO Orders   AS    T
				USING
				(
				       SELECT     @OrderID             AS         OrderID      ,
					              @ProductID           AS         ProductID
				)AS S
				ON     T.OrderID        =       S.OrderID
				AND    T.ProductID      =       S.ProductID

				----------Update for those orders if it exists-------------------------------
				WHEN MATCHED THEN
				     UPDATE SET
					        T.CustomerID		      =      @CustomerID		                    ,
							T.SalesPersonID			  =      @SalesPersonID							,
							T.OrderDate      		  =      @OrderDate      						,
							T.ShipDate				  =      @ShipDate								,
							T.OrderStatus    		  =      @OrderStatus    						,
							T.ShipAddress			  =      @ShipAddress							,
							T.BillAddress			  =      @BillAddress							,
							T.Quantity       		  =      @Quantity       						,
							T.Sales					  =      @Sales									,
							T.CreationTime   		  =      GETDATE()   
					   
				-------------Insert for the new  orders if it does not exists-------------------------------------
				WHEN NOT MATCHED THEN 
				INSERT (
				    OrderID                                  ,
                    ProductID								 ,
                    CustomerID								 ,
                    SalesPersonID							 ,
                    OrderDate								 ,
                    ShipDate								 ,
                    OrderStatus								 ,
                    ShipAddress								 ,
                    BillAddress								 ,
                    Quantity								 ,
                    Sales									 ,
                    CreationTime
				)VALUES(
				    @OrderID                                 ,
				    @ProductID								 ,
				    @CustomerID								 ,
				    @SalesPersonID							 ,
				    @OrderDate          					 ,
				    @ShipDate								 ,
				    @OrderStatus        					 ,
				    @ShipAddress							 ,
				    @BillAddress							 ,
				    @Quantity           					 ,
				    @Sales									 ,
				    GETDATE()      
				);

		COMMIT TRANSACTION;

	 END TRY

	 BEGIN CATCH
	      THROW
	 END CATCH

   END