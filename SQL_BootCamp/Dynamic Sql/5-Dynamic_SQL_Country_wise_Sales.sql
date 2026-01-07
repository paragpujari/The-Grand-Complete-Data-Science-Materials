/*
  Write a stored procedure to find out the sum of sales based on the country

  EXEC [DBO].[Get_Sales_Sum_Country] 'USA'

                SELECT a.Country ,  SUM(b.Sales)   AS   Total_Sales
				FROM        Customers a
				INNER JOIN  Orders b
				ON   a.CustomerID = b.CustomerID
				GROUP BY a.Country
*/

CREATE OR ALTER PROCEDURE [DBO].[Get_Sales_Sum_Country]
(
    @Country     NVARCHAR(30)
)
AS
   BEGIN
       SET NOCOUNT ON;

	   BEGIN TRANSACTION;
	      
		  /*------------------Declare the SQL Variable--------------------------------*/
		  DECLARE @SQL  NVARCHAR(MAX);

		  /*-----------------Set the SQL  Statement-----------------------------------*/
		  SET     @SQL = N'
		        SELECT a.Country ,  SUM(b.Sales)   AS   Total_Sales
				FROM        Customers a
				INNER JOIN  Orders b
				ON   a.CustomerID = b.CustomerID
				WHERE  a.Country = @Countryparam
				GROUP BY a.Country
		  ';

		  /*-------------Execute the SQL Statement------------------------------------*/
		  EXEC sp_executesql
		  @SQL                                                             ,
		  N'@Countryparam                         NVARCHAR(30)            ',
		  @Countryparam       =           @Country

		     BEGIN TRY

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	  THROW;
	  SELECT ERROR_LINE();
	  SELECT ERROR_MESSAGE();
	END CATCH

   END