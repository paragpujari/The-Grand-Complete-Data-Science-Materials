---EXEC [DBO].[Get_Customers_By_Country]'Germany'
CREATE OR ALTER PROCEDURE [DBO].[Get_Customers_By_Country]
(
    @Country  NVARCHAR(30)
)
 AS 
   BEGIN
         SELECT * FROM Customers WHERE Country = @Country;

   END