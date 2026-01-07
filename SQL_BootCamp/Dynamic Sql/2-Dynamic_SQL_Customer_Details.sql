/*
  Write a stored procedure that fetches the details of the Indian Customers whose score is above 800

  SELECT * FROM Customers where Country = 'India' AND Score >= 800 ORDER BY Score;

  EXEC [DBO].[Fetch_Customers_Details]
         @Country        =    'India'         ,
		 @Score          =     800

*/

CREATE OR ALTER PROCEDURE [DBO].[Fetch_Customers_Details]
(
    @Country       NVARCHAR(30)                ,
	@Score         INT
)
AS
  BEGIN
        BEGIN  TRANSACTION;

		      BEGIN TRY

			  /*----------------------Declare the SQL Variable-------------------------------*/
			  DECLARE @SQL   NVARCHAR(MAX);

			  /*----------------------Set the SQL Statement----------------------------------*/
			  SET     @SQL = N'
			  SELECT CustomerID, FirstName, LastName, Country, Score FROM Customers
			   WHERE Country = @Countryparam AND Score >= @Scoreparam
			   ORDER BY Score
			  ';

			  /*---------------------Execute the Dynamic SQL Statement----------------------*/
			  EXEC sp_executesql 
			  @SQL,
			  N'@Countryparam          NVARCHAR(30),
			    @Scoreparam            INT',
			  @Countryparam    =       @Country,
			  @Scoreparam      =       @Score


		COMMIT TRANSACTION;
	 END TRY

	 BEGIN CATCH
	    THROW;
	  SELECT ERROR_LINE();
	  SELECT ERROR_MESSAGE();
	 END CATCH

  END


