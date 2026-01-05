/*
Return customer count by country USING IF ELSE VALIDATION

SELECT Country, COUNT(1) AS Total_Count  FROM Customers GROUP BY Country

EXEC [DBO].[Get_Customer_Count_By_Country_IFELSE_VALIDATION] 'USA'
*/
CREATE OR ALTER PROCEDURE [DBO].[Get_Customer_Count_By_Country_IFELSE_VALIDATION]
(
    @Country                NVARCHAR(30)   
)
AS
  BEGIN
       DECLARE @CustomerCount          INT;
       --------------No data is present in the table----------------------------------
	   IF NOT EXISTS(SELECT 1 FROM Customers)
	     BEGIN
		      SELECT @CustomerCount = 0;
			  PRINT('No data exists in the table');
		 END
	   ELSE
	     BEGIN
		      SELECT @CustomerCount = COUNT(1) FROM Customers WHERE Country = @Country;
			  PRINT CONCAT('Customer Count for the country is:', @CustomerCount);
		 END
  END