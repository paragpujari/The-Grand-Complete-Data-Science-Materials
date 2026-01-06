/*
   Write a stored procedure to sync dimension table from source → target

   EXEC [DBO].[Sync_Dimension_Tables_from_source_till_target]
*/
CREATE OR ALTER PROCEDURE [DBO].[Sync_Dimension_Tables_from_source_till_target]
AS
 BEGIN
    SET NOCOUNT ON;

	  BEGIN TRANSACTION;

	     BEGIN TRY

		    MERGE Dim_Customers AS TARGET
			USING Customers     AS Source
			ON    TARGET.CustomerID = SOURCE.CustomerID

		--------present in the source and in the target-----------------------------
		WHEN MATCHED AND
		(
		         TARGET.FirstName       <>  SOURCE.FirstName
			OR   TARGET.LastName		<>  SOURCE.LastName
			OR   TARGET.Country			<>  SOURCE.Country	
			OR   TARGET.Score    		<>  SOURCE.Score    
		)
		THEN UPDATE SET
                 TARGET.FirstName       =   SOURCE.FirstName                                              ,
                 TARGET.LastName		=   SOURCE.LastName					                              ,
                 TARGET.Country			=   SOURCE.Country					                              ,
                 TARGET.Score			=   SOURCE.Score					                              ,
                 TARGET.CreatedDate		=   SOURCE.CreatedDate				                              ,
                 TARGET.IsActive		=   1								                              ,
                 TARGET.LastUpdated		=   GETDATE()						                              
																			                              
																			                              
		   ----------Not present in the target---------------------
		   WHEN  NOT MATCHED BY TARGET
		   THEN   INSERT(
		          CustomerID                                                                              ,
                  FirstName													                              ,
                  LastName													                              ,
                  Country													                              ,
                  Score														                              ,
                  CreatedDate												                              ,
                  IsActive													                              ,
                  LastUpdated												                              
		   )VALUES
		   (
		          SOURCE.CustomerID                                                                       ,
				  SOURCE.FirstName													                      ,
				  SOURCE.LastName													                      ,
				  SOURCE.Country													                      ,
				  SOURCE.Score														                      ,
				  SOURCE.CreatedDate												                      ,
				  1                                                                                       ,
				  GETDATE()
		   );



	COMMIT TRANSACTION;

   END TRY

   BEGIN CATCH
     THROW;
	 SELECT ERROR_LINE();
	 SELECT ERROR_MESSAGE();
   END CATCH
 END

/*
SELECT * FROM Customers;

SELECT * FROM Dim_Customers;
*/