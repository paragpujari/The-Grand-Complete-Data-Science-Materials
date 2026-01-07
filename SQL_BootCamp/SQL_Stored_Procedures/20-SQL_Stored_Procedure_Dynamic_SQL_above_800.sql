/*
Write a stored procedure to fetch all the customers above 800

EXEC [DBO].[Fetch_Customers_above_score_800] 800
*/

CREATE OR ALTER PROCEDURE [DBO].[Fetch_Customers_above_score_800]
(
    @score INT
)
AS
  BEGIN
     SET NOCOUNT ON;

	 DECLARE @SQL    NVARCHAR(MAX);

	 SET     @SQL = N'SELECT * FROM Customers WHERE Score > @scoredata'

	 EXEC    sp_executesql 
	 @SQL                                       ,
	 N'@scoredata         INT'                  ,
	 @scoredata    =    @score;

  END;