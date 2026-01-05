--Calculate Total Sales per Customer using Cursor
/*
SELECT CustomerID, SUM([Sales]) AS Total_Sales 
FROM Orders 
GROUP BY CustomerID
*/
--EXEC [DBO].[Calculate_Total_Sales_per_Customer]
CREATE OR ALTER PROCEDURE [DBO].[Calculate_Total_Sales_per_Customer]
AS
 BEGIN
    /*----------------Declare the Variables--------------------------*/
	DECLARE @CustomerID  INT;
	DECLARE @TotalSales  INT;

	/*---------------Declare the cursors----------------------------*/
	DECLARE Calculate_Total_Sales_per_Customer CURSOR
	FOR     SELECT CustomerID, SUM([Sales]) AS Total_Sales FROM Orders GROUP BY CustomerID

	/*--------------Open the cursor--------------------------------*/
	OPEN Calculate_Total_Sales_per_Customer;

	/*---------------Fetch the data of the first row from the cursor---------------------*/
	FETCH NEXT FROM Calculate_Total_Sales_per_Customer
	INTO            @CustomerID,           @TotalSales

	/*----------------Check if the fetch operation is successful-------------------------*/
	WHILE(@@FETCH_STATUS = 0)
	   BEGIN
	     PRINT CONCAT('Customer ID:',@CustomerID, ' ','Total Sales:',@TotalSales)

		 /*-------------------Fech the next row data from the cursor------------------------*/
		 FETCH NEXT FROM Calculate_Total_Sales_per_Customer
		 INTO            @CustomerID,          @TotalSales
	   END;
	
	CLOSE Calculate_Total_Sales_per_Customer;

  DEALLOCATE Calculate_Total_Sales_per_Customer;
 END