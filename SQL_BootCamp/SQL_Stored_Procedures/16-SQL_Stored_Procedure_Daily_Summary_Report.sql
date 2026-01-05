/*
Write a procedure that creates a daily summary report for the customers w.r.to the orders data

SELECT * FROM Customer_Daily_Summary
*/
--EXEC [DBO].[Prepare_Daily_Summary_Report_Customers]
CREATE OR ALTER PROCEDURE [DBO].[Prepare_Daily_Summary_Report_Customers]
AS
  BEGIN
   SET NOCOUNT ON;

        BEGIN TRANSACTION;

		   BEGIN TRY

               DECLARE @MaxDate DATE;
               SELECT  @MaxDate = CAST(GETDATE() AS DATE);
               SELECT  @MaxDate AS MaxDate;
               DECLARE @DeleteDate  DATE;
               SELECT  @DeleteDate = DATEADD(DAY,-50, @MaxDate);
               SELECT  @DeleteDate AS DeleteDate;
               /*------------------Delete all the data from the model---------------------------------------*/
               DELETE FROM Customer_Daily_Summary  WHERE OrderDate >= @DeleteDate AND OrderDate <= @MaxDate;
               
               /*------------------Insert all the data from the table of Customers and Orders------------------*/
               INSERT INTO Customer_Daily_Summary(
                           OrderDate                             ,
                           CustomerID							 ,
                           TotalOrders							 ,
                           TotalSales							 ,
                           AvgSales								 
               )
               SELECT 
			   CAST(b.OrderDate  AS   DATE)                      ,
			   a.CustomerID                                      ,
			   COUNT(1)           AS     TotalOrders             ,
			   SUM([Sales])       AS     TotalSales              ,
			   AVG([Sales])       AS     AvgSales
			   FROM        Customers a
			   INNER JOIN  Orders    b
			   ON          a.CustomerID = b.CustomerID
			   WHERE       CAST(b.OrderDate AS DATE) >= @DeleteDate AND CAST(b.OrderDate AS DATE) <= @MaxDate
			   GROUP BY  
			   CAST(b.OrderDate  AS   DATE)            ,
			   a.CustomerID

			COMMIT TRANSACTION;

		END TRY

		BEGIN CATCH
		    ROLLBACK TRANSACTION;
			SELECT ERROR_LINE();
			SELECT ERROR_MESSAGE();
			SELECT ERROR_NUMBER();
		END CATCH

  END