/*-------Print only Indian customers whose score is above 800 using cursors---------------------*/
--EXEC [DBO].[Fetch_Indian_Customers_score]

CREATE OR ALTER PROCEDURE [DBO].[Fetch_Indian_Customers_score]
AS
  BEGIN
       SET NOCOUNT ON;

	   BEGIN TRANSACTION;

	      BEGIN TRY
		    /*----------------------Declare the variables---------------------------------*/
			DECLARE @CustomerID   INT;
			DECLARE @FirstName    NVARCHAR(30);
			DECLARE @LastName     NVARCHAR(30);
			DECLARE @FullName     NVARCHAR(30);
			DECLARE @Country      NVARCHAR(30);
			DECLARE @Score        INT;


			/*-------------------Declare the cursor for row by row data processing------------------------*/
			DECLARE fetch_indian_customers_score  CURSOR  FOR
			SELECT  CustomerID, FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName, Country, Score FROM Customers
			WHERE   Country = 'India' AND Score > 800

			/*------------------Open the cursor-----------------------------------------------------------*/
			OPEN  fetch_indian_customers_score;

			/*-----------------Fetch the first row data from the cursor------------------------------------------*/
			FETCH NEXT FROM fetch_indian_customers_score
			           INTO @CustomerID, @FirstName, @LastName, @FullName, @Country, @Score

			/*--------------If the fetch operation is successful-------------------------------------------------*/
			WHILE(@@FETCH_STATUS = 0)
			   BEGIN
			        PRINT CONCAT('CustomerID:', @CustomerID,' ','FirstName:',@FirstName, ' ','LastName:',@LastName,' ','FullName:',@FullName,' ','Country:',@Country,' ','Score:',@Score)

					/*-------------Fetch the next row data from the cursor-------------------------------------------*/
					FETCH NEXT FROM fetch_indian_customers_score
					           INTO @CustomerID, @FirstName, @LastName, @FullName, @Country, @Score
			   END;

			   CLOSE fetch_indian_customers_score;
			DEALLOCATE fetch_indian_customers_score;

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
	   ROLLBACK TRANSACTION;
	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
	   SELECT ERROR_NUMBER();
	END CATCH

  END