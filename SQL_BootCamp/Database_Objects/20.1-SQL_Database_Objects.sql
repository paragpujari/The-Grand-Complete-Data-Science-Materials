/*
5. Create a stored procedure to fetch customers by country and minimum score
*/
--EXEC [dbo].[sp_Customers_Details] 'Germany',350
CREATE OR ALTER PROCEDURE [dbo].[sp_Customers_Details]
(
  @Country   NVARCHAR(30)           ,
  @MinScore  INT
)
AS
  BEGIN
     SELECT * FROM Customersss WHERE Country = @Country AND Score >= @MinScore ORDER BY Score;
  END
