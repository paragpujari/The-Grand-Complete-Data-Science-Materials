/*
 Write a stored procedure that sorts all the details of the customer in the ascending order.

 EXEC [DBO].[Sort_Customer_Details]
      @SortColumn =   'CustomerID'        ,
	  @SortOrder  =   'ASC'
*/

CREATE OR ALTER PROCEDURE [DBO].[Sort_Customer_Details]
(
        @SortColumn      NVARCHAR(30)    ,
		@SortOrder       NVARCHAR(30)
)
AS
  BEGIN
      SET NOCOUNT ON;

	     BEGIN TRANSACTION;

		      BEGIN  TRY

			  /*---------------Declare the SQL Variable---------------------*/
			  DECLARE @SQL  NVARCHAR(MAX);

			  /*-------------Set the SQL Statement---------------------------*/
			  SET     @SQL = N'
			  SELECT CustomerID, FirstName, LastName, Country, Score FROM Customers
			  ORDER BY'+QUOTENAME(@SortColumn)+ N' '+CASE WHEN @SortOrder = 'DESC' THEN 'DESC' ELSE 'ASC' END;

			  /*------------Exec the SQL Statement--------------------------*/
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