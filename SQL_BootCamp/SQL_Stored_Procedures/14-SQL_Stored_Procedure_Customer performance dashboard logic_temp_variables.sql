/*
Create Customer performance dashboard logic

EXEC [DBO].[Customer_Performance_KPI_Dashboard_temp_variables]1
*/
CREATE OR ALTER PROCEDURE [DBO].[Customer_Performance_KPI_Dashboard_temp_variables]
(
       @CustomerID    INT
)
AS
  BEGIN
       /*-------------------If the customer does not exists in the table, then throw an error--------------------------------*/
	   IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
	      BEGIN
		      THROW 50005,'Customer ID does not exists in the table',1;
		  END

       /*--------------Perform the KPI Dashboard for the Customer that exists------------------------------------------------*/

	   -----------------get the full name of the customer------------------------
	   DECLARE @Name                 VARCHAR(30)           ;
	   DECLARE @Total                INT                   ;
	   DECLARE @Total_Sales          INT                   ;
	   DECLARE @Avg_Sales            FLOAT                 ;


	   SELECT  @Name = CONCAT(FirstName, ' ', LastName)
	   FROM [DATASCIENCE].[DBO].[Customers]
	   WHERE CustomerID = @CustomerID;

	   --SELECT @Name AS Name;

	   ---------------get the order details of that customer-------------------------
	   SELECT @Total = COUNT(1) FROM [DATASCIENCE].[DBO].[Orders]
	   WHERE        CustomerID = @CustomerID;

	  -- SELECT @Total AS Total;

	   SELECT @Total_Sales = SUM([Sales]) FROM [DATASCIENCE].[DBO].[Orders]
	   WHERE         CustomerID = @CustomerID;

	  -- SELECT @Total_Sales AS Total_Sales;

	   SELECT @Avg_Sales = AVG([Sales]) FROM [DATASCIENCE].[DBO].[Orders]
	   WHERE         CustomerID = @CustomerID;

	  -- SELECT @Avg_Sales AS Avg_Sales;


	   SELECT @Name              AS           Name            ,
	          @Total             AS           Total           ,
			  @Total_Sales       AS           Total_Sales     ,
			  @Avg_Sales         AS            Avg_Sales;




  END