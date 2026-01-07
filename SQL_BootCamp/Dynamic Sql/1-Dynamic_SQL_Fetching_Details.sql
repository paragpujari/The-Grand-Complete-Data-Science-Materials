/*
   Create a stored procedure that fetches the customer details based on the country

   EXEC  [DBO].[Get_Customers_By_Country]'Germany'
*/

CREATE OR ALTER PROCEDURE [DBO].[Get_Customers_By_Country]
(
    @Country   NVARCHAR(30)
)
AS
  BEGIN
      BEGIN TRANSACTION;

	      BEGIN  TRY
		     /*---------------------Declare the SQL Variable----------------------*/
			 DECLARE @SQL  NVARCHAR(MAX);

			 /*--------------------Set the SQL Statement--------------------------*/
			 SET     @SQL = N'
			     SELECT CustomerID,FirstName,LastName, Country, Score  FROM Customers WHERE Country = @Countryparam
			 ';

			 /*-------------------Execute the SQL Statement-------------------------*/

			 EXEC  sp_executesql 
			 @SQL                                                 ,
			 N'@Countryparam          NVARCHAR(30)               ',
			 @Countryparam        =                     @Country

	  COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	   THROW;
	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
	END CATCH

  END