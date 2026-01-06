/*
  Write a stored procedure to perform the Slowly Changing Dimensions on a Customers Table

  SELECT * FROM Customers;

  SELECT * FROM DimCustomers1;

  EXEC [DBO].[Perform_SCD]
*/

CREATE OR ALTER PROCEDURE [DBO].[Perform_SCD]
AS
  BEGIN
     SET NOCOUNT ON;

	    DECLARE @CurrentDate  DATETIME;

		SELECT  @CurrentDate = GETDATE();

	--	SELECT  @CurrentDate AS CurrentDate;


	    BEGIN TRANSACTION;
		  
		      BEGIN TRY

			/*--------------Update the existing record by making the active record as inactive------------------*/

		      UPDATE a
			  SET    a.EffectiveTo = @CurrentDate          ,
			         a.IsCurrent   = 0
			  FROM DimCustomers1  a
			  JOIN          Customers      b
			  ON            a.CustomerID = b.CustomerID
			  WHERE         a.IsCurrent  = 1
			  AND       
			  (
			                   a.FirstName       <>    b.FirstName
                      OR       a.LastName		 <>    b.LastName	
                      OR       a.Country		 <>    b.Country	
                      OR       a.Score		     <>    b.Score	
			  )

			/*------------Insert the new records in the dimension table--------------------------------*/
			INSERT INTO DimCustomers1(
                       CustomerID                     ,
                       FirstName					  ,
                       LastName						  ,
                       Country						  ,
                       Score						  ,
                       EffectiveFrom				  ,
                       EffectiveTo					  ,
                       IsCurrent
			)
			SELECT 
			a.CustomerID                              ,   
            a.FirstName					              ,
            a.LastName					              ,
            a.Country					              ,
            a.Score						              ,
            @CurrentDate                              ,
			'9999-12-31'                              ,
			1
			FROM Customers a
			LEFT JOIN     DimCustomers1 b
			ON            a.CustomerID  = b.CustomerID
			WHERE         b.CustomerID IS NULL
			OR
			(
			                a.FirstName     <>   b.FirstName   
                     OR     a.LastName	    <>   b.LastName	
                     OR     a.Country		<>   b.Country		
                     OR     a.Score		    <>   b.Score		
			)

		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	   THROW;
	   SELECT ERROR_LINE();
	   SELECT ERROR_MESSAGE();
	END   CATCH

  END


