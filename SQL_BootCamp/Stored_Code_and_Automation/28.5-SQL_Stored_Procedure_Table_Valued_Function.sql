/*
Table-valued function to return customers by country
*/
--SELECT * FROM dbo.Get_Customer_Details_by_Country('India');
CREATE OR ALTER FUNCTION [dbo].[Get_Customer_Details_by_Country]
(
    @Country  NVARCHAR(30)
)
RETURNS TABLE
   AS
      RETURN
	  (
	    SELECT * FROM Customers WHERE Country = @Country
	  )
	  ;