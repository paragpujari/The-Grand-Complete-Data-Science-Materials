/*
Write a stored procedure that handles Complex Joins & Transformations 
*/
-- EXEC [DBO].[Handles_Complex_Joins_and_Transformations] 'Germany'
CREATE OR ALTER PROCEDURE [DBO].[Handles_Complex_Joins_and_Transformations]
(
     @Country    NVARCHAR(30)
)
AS
  BEGIN
     SET NOCOUNT ON;
	 
	 BEGIN TRANSACTION;

	     BEGIN  TRY
		 
		 ;with cte1 as(
		 SELECT 
		 a.CustomerID                                                                                                ,
		 a.FirstName                                                                                                 ,
		 a.LastName                                                                                                  ,
		 CONCAT(a.FirstName, ' ', a.LastName)     AS   FullName                                                      ,
		 a.Country                                                                                                   ,
		 a.Score                                                                                                     ,
		 CASE WHEN a.Score >= 700  THEN 'Gold'
		      WHEN a.Score >= 500 AND a.Score < 700  THEN 'Platinum'
			                                         ELSE  'Silver'  END AS Score_Category                           ,
		 b.OrderID                                                                                                   ,
		 b.OrderDate                                                                                                 ,
		 CASE WHEN   b.OrderStatus = 'Delivered'    THEN   1   ELSE   0   END AS Delivered_Orders                    ,
		 CASE WHEN   b.OrderStatus = 'Shipped'      THEN   1   ELSE   0   END AS Shipped_Orders                      ,
		 b.OrderStatus                                                                                               ,
		 b.Quantity                                                                                                  ,
		 b.Sales
		 FROM
		 Customers   a
		 JOIN Orders b
		 ON   a.CustomerID = b.CustomerID
		 WHERE a.Country = @Country
		 )
		 SELECT 
		 CustomerID                                                                                             ,
		 FullName                                                                                               ,
		 Country                                                                                                ,
		 Score_Category                                                                                         ,
		 MAX([OrderDate])                               AS    Latest_Order										,
		 SUM([Score])                                   AS    Total_Score                                       ,
		 AVG([Score])                                   AS    Average_Score                                     ,
		 COUNT([OrderID])                               AS    Total_Orders                                      ,
		 SUM([Delivered_Orders])                        AS    Delivered_Orders                                  ,
		 SUM([Shipped_Orders])                          AS    Shipped_Orders                                    ,
		 SUM([Sales])                                   AS    Total_Sales                                       ,
		 AVG([Sales])                                   AS    Average_Sales                                     ,
		 SUM([Sales])/COUNT([OrderID])                  AS    Average_Order_Value
		 FROM cte1
		 GROUP BY
		 CustomerID                                                                                             ,
		 FullName                                                                                               ,
		 Country                                                                                                ,
		 Score_Category;


		 COMMIT TRANSACTION;

		END TRY

	BEGIN CATCH
	    THROW;
	SELECT ERROR_LINE();
	SELECT ERROR_MESSAGE();
	END CATCH
  END