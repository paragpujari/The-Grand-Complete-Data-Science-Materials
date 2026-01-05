/*
Perform an incremental load on the data model to update the records from the staging table from 2026 year

SELECT MAX(OrderDate) AS Staging FROM Orders;

SELECT MAX(OrderDate) AS Model FROM FactOrders;

--EXEC [DBO].[Perform_Incremental_Load_Orders_Data]
*/

CREATE OR ALTER PROCEDURE [DBO].[Perform_Incremental_Load_Orders_Data]
AS
 BEGIN
    SET NOCOUNT ON;

	   BEGIN TRANSACTION;

	      BEGIN TRY

		  /*-----------Get the maximum date from the data model-------------------------*/
		  DECLARE @MaxDate  DATETIME;

		  SELECT  @MaxDate = MAX([OrderDate])  FROM FactOrders WITH (NOLOCK);

		  SELECT  @MaxDate AS MaxDate;

		  /*---------------Get the previous date from the maximum date of the data model-------------------*/

		  DECLARE @DeleteDate DATETIME;

		  SELECT  @DeleteDate = DATEADD(DAY,-1,@MaxDate);

		  SELECT  @DeleteDate AS DeleteDate;

		  /*-------------Delete the data from the data model w.r.to the delete date--------------------------*/

		  DELETE FROM FactOrders WHERE OrderDate >= @DeleteDate;

		  /*------------Insert the data from the staging w.r.to the delete date---------------------------------*/
		  INSERT INTO FactOrders(
		         OrderID                      ,
                 ProductID					  ,
                 CustomerID					  ,
                 SalesPersonID				  ,
                 OrderDate					  ,
                 ShipDate					  ,
                 OrderStatus				  ,
                 ShipAddress				  ,
                 BillAddress				  ,
                 Quantity					  ,
                 Sales						  ,
                 CreationTime
		  )
		  SELECT 
		         OrderID                      ,
                 ProductID					  ,
                 CustomerID					  ,
                 SalesPersonID				  ,
                 OrderDate					  ,
                 ShipDate					  ,
                 OrderStatus				  ,
                 ShipAddress				  ,
                 BillAddress				  ,
                 Quantity					  ,
                 Sales						  ,
                 CreationTime
		  FROM [DATASCIENCE].[DBO].[Orders]
		  WHERE OrderDate >= @DeleteDate


		COMMIT TRANSACTION;
	 END TRY

	 BEGIN CATCH
	     ROLLBACK TRANSACTION;

		 SELECT ERROR_LINE();
		 SELECT ERROR_MESSAGE();
		 SELECT ERROR_NUMBER();
	 END CATCH
 END
