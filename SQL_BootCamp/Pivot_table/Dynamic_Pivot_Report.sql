/*
   Write a stored procedure to generate pivoted report dynamically   
   
                  SELECT * FROM(
	                         SELECT  a.Country, b.Sales     AS  Sales
			                 FROM Customers a
			                 INNER JOIN    Orders    b
			                 ON            a.CustomerID = b.CustomerID
					)AS Source
					PIVOT(
					SUM([Sales])
					FOR Country IN ([Germany],[India],[USA])
					)AS p;

					EXEC [DBO].[Generate_Pivot_Report]
*/

CREATE OR ALTER PROCEDURE [DBO].[Generate_Pivot_Report]
AS
  BEGIN
      SET NOCOUNT ON;

	    BEGIN TRANSACTION;
		 
		    BEGIN  TRY

			/*--------------------Declare the Dynamic SQL Variable----------------------------*/
			DECLARE @SQL  NVARCHAR(MAX);

			DECLARE @Country NVARCHAR(MAX);

			SELECT  @Country = STRING_AGG(QUOTENAME([Country]),',') 
			FROM(SELECT DISTINCT Country FROM Customers)a;

			/*-----------------------Set the Dynamic SQL Statement---------------------------*/

			SET     @SQL = N'
			     SELECT * FROM(
			       SELECT 
				   a.Country                 ,
				   b.Sales     AS   Sales
				   FROM Customers a
				   JOIN          Orders    b
				   ON            a.CustomerID = b.CustomerID
				)AS Source
				PIVOT(
				    SUM([Sales])
					FOR Country IN ('+@Country+')
				)AS p;
			';

			/*-----------------------Execute the  Dynamic SQL Statement---------------------------*/
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