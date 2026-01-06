/*
SELECT * FROM Orders ORDER BY OrderID;

Write a new stored procedure to insert a new order into the Orders table using MERGE statement

EXEC dbo.sp_Merge_Update_Insert_Statement
     @OrderID                 =                    16                       ,
     @ProductID               =                    103                      ,
     @CustomerID              =                    5                        ,
     @SalesPersonID           =                    4                        ,
     @OrderDate               =                  '2026-01-04'               ,
     @ShipDate                =                  '2026-01-05'               ,
     @OrderStatus             =                  'Delivered'                ,
     @ShipAddress             =                  '250 Race Court'           ,
     @BillAddress             =                  '4311 Clay Rd'             ,
     @Quantity                =                  4                          ,
     @Sales                   =                  189  
*/

CREATE OR ALTER PROCEDURE [DBO].[sp_Merge_Update_Insert_Statement]
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

		      BEGIN   TRY

			  /*------------------To perform the insert operation using Merge-----------------------------------*/
			  MERGE INTO Orders AS T
			  USING 
			  (
			     SELECT @OrderID     AS     OrderID           ,
				        @ProductID   AS     ProductID
			  )AS S
			  ON    T.OrderID  = S.OrderID
			  AND   T.ProductID = S.ProductID

			  /*-----------------To perform the update operation if the order item already exists-------------------*/
			  WHEN MATCHED THEN
			       UPDATE SET
				   T.CustomerID		     =    @CustomerID			                ,
				   T.SalesPersonID		 =    @SalesPersonID						,
				   T.OrderDate      	 =    @OrderDate          					,
				   T.ShipDate			 =    @ShipDate								,
				   T.OrderStatus    	 =    @OrderStatus        					,
				   T.ShipAddress		 =    @ShipAddress							,
				   T.BillAddress		 =    @BillAddress							,
				   T.Quantity       	 =    @Quantity           					,
				   T.Sales				 =    @Sales								,
				   T.CreationTime        =    GETDATE()

			/*-----------------To perform the insert operation if that item does not exists---------------------------*/
			  WHEN NOT MATCHED THEN
			           INSERT(
					   OrderID                       ,
					   ProductID					 ,
					   CustomerID					 ,
					   SalesPersonID				 ,
					   OrderDate      				 ,
					   ShipDate						 ,
					   OrderStatus    				 ,
					   ShipAddress					 ,
					   BillAddress					 ,
					   Quantity       				 ,
					   Sales	                     ,
					   CreationTime
					   )VALUES(
					   @OrderID                      ,
					   @ProductID					 ,
					   @CustomerID					 ,
					   @SalesPersonID				 ,
					   @OrderDate      				 ,
					   @ShipDate					 ,
					   @OrderStatus    				 ,
					   @ShipAddress					 ,
					   @BillAddress					 ,
					   @Quantity       				 ,
					   @Sales	                     ,
					   GETDATE()
					   );


		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	    THROW;
	    SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
	END CATCH

   END