/*           
SELECT STRING_AGG(QUOTENAME(Countries),',') FROM(
SELECT DISTINCT Country AS Countries FROM Customers
)a;

               SELECT * FROM(
			    SELECT 
				a.Country               ,
				b.Sales    AS Sales
				FROM Customers a
				JOIN          Orders    b
				ON            a.CustomerID = b.CustomerID
			)AS Source
			PIVOT(
			    SUM([Sales])
				FOR Country IN ([Germany],[USA],[India])
			)a
			ORDER BY 1
			;

			EXEC [DBO].[Get_Sales_Pivot_By_Country]
       */

--EXEC [DBO].[Get_Sales_Pivot_By_Country]
CREATE OR ALTER PROCEDURE [DBO].[Get_Sales_Pivot_By_Country]
AS
  BEGIN
       SET NOCOUNT ON;

	   BEGIN TRANSACTION;

	      BEGIN  TRY
		    
			-----------------------Declare the SQL Variables------------------------------------------
		     DECLARE @SQL     NVARCHAR(MAX);
			 DECLARE @Country NVARCHAR(MAX);

			 SELECT     @Country =  STRING_AGG(QUOTENAME([Total_Countries]),',')
			 FROM(SELECT  DISTINCT  Country AS Total_Countries FROM Customers)a;

			------------------Set the SQL Statements---------------------------------------------------

			SET @SQL = N'
			  SELECT * FROM(
			    SELECT 
				a.Country               ,
				b.Sales    AS Sales
				FROM Customers a
				JOIN          Orders    b
				ON            a.CustomerID = b.CustomerID
			)AS Source
			PIVOT(
			    SUM([Sales])
				FOR Country IN ([Germany],[USA],[India])
			)a
			ORDER BY 1
			;
			';

			----------------------Execute the SQL Statements-----------------------------------------------
			EXEC sp_executesql 
			@SQL

	   COMMIT TRANSACTION;

	 END TRY


	 BEGIN CATCH
	    THROW;
	  SELECT ERROR_LINE();
	  SELECT ERROR_MESSAGE();
	 END CATCH
  END