/*
   Write a stored procedure to sync dimension table from source → target for orders

   EXEC [DBO].[Sync_Dimension_Tables_from_source_till_target_orders]


   SELECT * FROM  Orders;

   SELECT * from  Dim_Orders;
*/
CREATE OR ALTER PROCEDURE [DBO].[Sync_Dimension_Tables_from_source_till_target_orders]
AS
   BEGIN
       SET NOCOUNT ON;

	     BEGIN TRANSACTION;
		    
			   BEGIN   TRY

			   MERGE Dim_Orders AS TARGET
			   USING Orders     AS SOURCE
			   ON    TARGET.OrderID  = SOURCE.OrderID

			   ------------Records present in both the table-------------------------------
			   WHEN MATCHED AND
			   (
			                TARGET.ProductID            <>     SOURCE.ProductID      
                  OR        TARGET.CustomerID			<>     SOURCE.CustomerID		
                  OR        TARGET.SalesPersonID		<>     SOURCE.SalesPersonID	
                  OR        TARGET.OrderDate			<>     SOURCE.OrderDate		
                  OR        TARGET.ShipDate			    <>     SOURCE.ShipDate		
			   )
			   THEN UPDATE SET
                            TARGET.ProductID            =      SOURCE.ProductID                                   ,
                            TARGET.CustomerID			=      SOURCE.CustomerID						          ,
                            TARGET.SalesPersonID		=      SOURCE.SalesPersonID						          ,
                            TARGET.OrderDate			=      SOURCE.OrderDate							          ,
                            TARGET.ShipDate				=      SOURCE.ShipDate							          ,
                            TARGET.OrderStatus			=      SOURCE.OrderStatus						          ,
                            TARGET.ShipAddress			=      SOURCE.ShipAddress						          ,
                            TARGET.BillAddress			=      SOURCE.BillAddress						          ,
                            TARGET.Quantity				=      SOURCE.Quantity							          ,
                            TARGET.Sales				=      1										          ,
                            TARGET.CreationTime			=      GETDATE()

			   ---------Records not present in the target table-----------------------------
			   WHEN  NOT MATCHED BY TARGET
			                 THEN  INSERT(
							    OrderID                                                                           ,  
                                ProductID																          ,
                                CustomerID																          ,
                                SalesPersonID															          ,
                                OrderDate																          ,
                                ShipDate																          ,
                                OrderStatus																          ,
                                ShipAddress																          ,
                                BillAddress																          ,
                                Quantity																          ,
                                Sales																	          ,
                                CreationTime															          ,
                                IsActive																          ,
                                LastUpdated
							 )VALUES(
							    SOURCE.OrderID                                                                    ,  
                                SOURCE.ProductID																  ,
                                SOURCE.CustomerID																  ,
                                SOURCE.SalesPersonID															  ,
                                SOURCE.OrderDate																  ,
                                SOURCE.ShipDate																      ,
                                SOURCE.OrderStatus																  ,
                                SOURCE.ShipAddress																  ,
                                SOURCE.BillAddress																  ,
                                SOURCE.Quantity																      ,
                                SOURCE.Sales																	  ,
                                SOURCE.CreationTime                                                               ,
								1                                                                                 ,
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



