/*
  Write a Stored Procedure to perform Dynamic SQL for fetching the customer records for score >= 800

  SELECT * FROM Customers WHERE score >= 800

  EXEC [DBO].[Fetch_Customer_Records_Score] 'score' , '>=' ,'800'
*/

CREATE OR ALTER PROCEDURE [DBO].[Fetch_Customer_Records_Score]
(
      @Column            SYSNAME              ,
	  @Operator          NVARCHAR(30)         ,
	  @Score             NVARCHAR(30)
)
AS
   BEGIN
               SET  NOCOUNT ON;

			     BEGIN TRANSACTION;

				     BEGIN TRY

					 /*----------------Declare the SQL Query----------------------------*/
					 DECLARE @SQL NVARCHAR(MAX);

					 /*----------------Set the Dynamic SQL  Statement-------------------*/
					 SET     @SQL = N'
					 SELECT * FROM Customers WHERE
					 '+ QUOTENAME(@Column) + @Operator + N' @Scoreparam';
					 
					 /*--------------Execute the Dynmic SQL Statement-------------------*/
					EXEC sp_executesql
					@SQL                                                    ,
					N'@Scoreparam                       NVARCHAR(30)'       ,
					@Scoreparam           =             @Score




				COMMIT TRANSACTION;

			END TRY

			BEGIN CATCH
			    THROW;
				SELECT ERROR_LINE();
				SELECT ERROR_MESSAGE();
			END CATCH
	           
	       

	
   END