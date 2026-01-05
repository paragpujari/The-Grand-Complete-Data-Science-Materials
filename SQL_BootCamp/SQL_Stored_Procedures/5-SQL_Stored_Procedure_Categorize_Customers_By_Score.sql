/*
Categorize customers by score
SELECT * FROM Customers;

*/
--EXEC [DBO].[Categorize_Score_by_Customer] 14
CREATE OR ALTER PROCEDURE [DBO].[Categorize_Score_by_Customer]
(
    @CustomerID    INT
)
AS
   BEGIN
             /*-------------No data exists in the table-----------*/
			 IF NOT EXISTS(SELECT 1 FROM Customers)
			    BEGIN
				   THROW 50003, 'No Customers data eists in the table',1;
				END
			ELSE
			   BEGIN
			     /*--------------get the score for every customer-----------------*/
				 DECLARE @Score INT;
				 SELECT  @Score = Score FROM Customers WHERE CustomerID = @CustomerID;
				 --SELECT  @Score AS Score;

				 /*--------------Categorize Customer for every score-------------------*/
				 IF(@Score >= 800)
				   BEGIN
				      PRINT('Gold')
				   END
				ELSE IF(@Score >= 700 AND @Score < 800)
				  BEGIN
				      PRINT('Platinum')
				  END
				ELSE
				      PRINT('Silver')
			   END

   END