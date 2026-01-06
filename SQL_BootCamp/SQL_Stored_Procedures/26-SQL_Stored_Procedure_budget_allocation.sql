/*
     Write a stored procedure to allocate budgets to departments based on rules

	 1.  Sum of sales according to salespersonid

	 2.  total sum of sales

	 3.  sales percentage contribution

	 4.  Allocated Budget

	 EXEC [DBO].[Allocate_Budget_Deprtment] @TotalBudget = 100000
*/

CREATE OR ALTER PROCEDURE [DBO].[Allocate_Budget_Deprtment]
(
   @TotalBudget   DECIMAL(18,2)
)
 AS 
BEGIN
	   SET NOCOUNT ON;

	   BEGIN TRANSACTION;

	       BEGIN  TRY

		       ;with cte1 as(
			      SELECT * FROM Orders
			   )
			   ,cte2 as(
			     SELECT SalesPersonID, SUM([Sales])  AS Total_Sales
				 FROM cte1
				 GROUP BY SalesPersonID
			  ),cte3 as(
			    SELECT SUM([Total_Sales]) AS Company_Sales
				FROM cte2
			  ),cte4 as(
			  SELECT * FROM cte2 a
			  CROSS JOIN    cte3 b
			  )
			  SELECT 
			  SalesPersonID                                                                                                ,
			  Total_Sales                                                                                                  ,
			  Company_Sales                                                                                                ,
			  CONVERT(NUMERIC(18,5),(Total_Sales * 100.0))/NULLIF(Company_Sales,0)   AS Sales_Percentage_Contribution      ,
			  CONVERT(NUMERIC(18,5),(Total_Sales * @TotalBudget))/NULLIF(Company_Sales,0)  AS  Budget_Allocation
			  FROM cte4
			  ORDER BY 5;
			   
		  

	COMMIT TRANSACTION;

   END TRY

   BEGIN CATCH
       THROW;
	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
   END CATCH
END