/*
Write a SP that takes a @Country parameter and returns customers from that country.
If @Country is NULL or empty, return all customers.
*/
--EXEC [DBO].[Get_Customers_by_Country_data] NULL
CREATE OR ALTER PROCEDURE [DBO].[Get_Customers_by_Country_data]
(
    @Country NVARCHAR(30)
)
AS
  BEGIN
        IF(@Country IS NULL)
		  BEGIN
		      SELECT * FROM Customers;
		  END
		ELSE
		 BEGIN
		     SELECT * FROM Customers WHERE Country = @Country;
		 END

  END
