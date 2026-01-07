/*
   Write a stored procedure to fetch the USA Customers whose score > 750

EXEC   [DBO].[Fetch_Customers_Score_Data]'USA',750
*/

CREATE OR ALTER PROCEDURE [DBO].[Fecth_Customer_Details]
(
            @Country       NVARCHAR(30)             ,
			@Score         INT
)
AS
   BEGIN
           SET   NOCOUNT ON;

		   BEGIN TRANSACTION;

		       BEGIN  TRY

			   DECLARE @SQL  NVARCHAR(MAX);

			   /*------------------Define the sql statement  -------------------------------------*/

			   SET     @SQL = N'
			    SELECT  
				CustomerID                                                     ,
                FirstName													   ,
                LastName													   ,
				CONCAT(FirstName," ",LastName)      AS    FullName			   ,
                Country														   ,
                Score
				FROM Customers WHERE Country = @Countryparam   AND Score >= @Scoreparam
			   ';

			   /*----------------Execute the sql statement-----------------------------------------*/

			   EXEC sp_executesql 
			   @SQL                                                              ,
			   N'@Countryparam                                    NVARCHAR(30)   ,
			     @Scoreparam                                      INT'           ,
				 @Countryparam            =               @Country               ,
				 @Scoreparam              =               @Score 

		COMMIT TRANSACTION;

		END TRY


		BEGIN CATCH
		 THROW;
		SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
		END CATCH

   END
