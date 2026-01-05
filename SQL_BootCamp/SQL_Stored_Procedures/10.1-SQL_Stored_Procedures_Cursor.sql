--EXEC [DBO].[Cursor_Print_Customers]
CREATE OR ALTER PROCEDURE [DBO].[Cursor_Print_Customers]
AS
 BEGIN
    SET NOCOUNT ON;

	/*-------------Declare the variables-----------------------------*/
	DECLARE @CustomerID  INT;
	DECLARE @FirstName   NVARCHAR(30);
	DECLARE @LastName    NVARCHAR(30);

	/*------------Declare the Cursor for pointing to each and every data row by row in the table for processing-----------------------*/
	DECLARE cursor_data_customers CURSOR FOR
	SELECT  CustomerID, FirstName, LastName FROM Customers

	/*------------Open the cursor---------------------------------------------*/
	OPEN cursor_data_customers;

	/*-------------Fetch the data of the first row from the cursors-------------------------------*/
	FETCH NEXT FROM cursor_data_customers
	INTO            @CustomerID, @FirstName, @LastName

	/*----------------If the fetch operation is successful--------------------------------------------*/
	WHILE(@@FETCH_STATUS = 0)
	 BEGIN
	   /*----------------Print the customer details---------------------------------------------------*/
	   PRINT CONCAT('Customer ID:', @CustomerID, ' ', 'FirstName:', @FirstName,' ','LastName:',@LastName)

	   /*----------------Fetch the next data from the  cursors---------------------------------------*/
	   FETCH NEXT FROM cursor_data_customers
	   INTO            @CustomerID, @FirstName, @LastName;
	 END;

	 CLOSE cursor_data_customers;
	 DEALLOCATE cursor_data_customers;
 END