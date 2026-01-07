/*
Write a stored procedure to fetch only the Indian Customer details

EXEC [DBO].[Get_Customers_By_Country_Dynamic] 'India'
*/
CREATE OR ALTER PROCEDURE [DBO].[Get_Customers_By_Country_Dynamic]
(
     @Country     NVARCHAR(30)
)
  AS
     BEGIN
	   SET NOCOUNT ON;

	    DECLARE  @Sql   NVARCHAR(MAX);

		SET      @Sql = N'
		SELECT * FROM Customers WHERE Country = @countryparam
		'

		EXEC sp_executesql 
		@Sql                                           ,
		N'@countryparam            NVARCHAR(30)'       ,
		@countryparam     =     @Country;
		
	 END;


