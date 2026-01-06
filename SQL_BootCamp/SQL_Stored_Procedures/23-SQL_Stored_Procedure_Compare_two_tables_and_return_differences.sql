/*
  Write a stored procedure that compares two tables and return differences

  SELECT * FROM Customers;

  SELECT * FROM Customers_Backup;

EXEC [DBO].[Compare_two_tables_and_return_differences]
*/

CREATE OR ALTER PROCEDURE [DBO].[Compare_two_tables_and_return_differences]
AS 
    BEGIN
	       BEGIN  TRANSACTION;

		         BEGIN  TRY

				 ---------------------Missing Records in the Customer_Backup--------------------------------------
				 SELECT 
				 a.CustomerID                              ,
                 a.FirstName							   ,
                 a.LastName								   ,
                 a.Country								   ,
                 a.Score								   ,
                 a.CreatedDate
				 FROM Customers a
                 LEFT JOIN     Customers_Backup b
				 ON            a.CustomerID = b.CustomerID
				 WHERE         b.CustomerID IS NULL;

				 -------------------Missing Records in the Customer Table------------------------------------------
				 SELECT 
				 a.CustomerID                              ,
                 a.FirstName							   ,
                 a.LastName								   ,
                 a.Country								   ,
                 a.Score								   ,
                 a.CreatedDate
				 FROM 
				 Customers_Backup a
				 LEFT JOIN    Customers b
				 ON           a.CustomerID = b.CustomerID
				 WHERE        b.CustomerID IS NULL;

				 ---------------Changed Records---------------------------------------------------------------------
				 SELECT 
				 'Data Mismatch'         AS        Difference_Type                          ,
				 a.CustomerID            AS        Customers_CustomerID                     ,
				 b.CustomerID            AS        Customers_Backup_CustomerID              ,  
                 a.FirstName			 AS 	   Customers_FirstName			            ,
				 b.FirstName             AS        Customers_Backup_FirstName               ,
                 a.LastName				 AS 	   Customers_LastName			            ,
				 b.LastName              AS        Customers_Backup_LastName                ,
                 a.Country				 AS 	   Customers_Country			            ,
				 b.Country               AS        Customers_Backup_Country                 ,
                 a.Score				 AS 	   Customers_Score			                ,
				 b.Score                 AS        Customers_Backup_Score                   ,
                 a.CreatedDate
				 FROM Customers a
				 JOIN Customers_Backup b
				 ON   a.CustomerID = b.CustomerID
				 WHERE a.FirstName <> b.FirstName
				 OR    a.LastName  <> b.LastName
				 OR    a.Country   <> b.Country
				 OR    a.Score     <> b.Score


		  COMMIT TRANSACTION;

		END TRY

	BEGIN CATCH
	   THROW;

	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
	END CATCH




	END


