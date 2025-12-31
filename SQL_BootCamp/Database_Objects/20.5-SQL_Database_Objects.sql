/*
 Create a scalar function to classify Continent for the given country

 SELECT * FROM Customersss ORDER BY Score;
*/
--EXEC  [dbo].[Get_Continent_for_country] 'Germany';
CREATE OR ALTER FUNCTION [dbo].[Get_Continent_for_country]
(
   @Country  NVARCHAR(30)
)
  RETURNS  NVARCHAR(30)
AS

BEGIN
  
  DECLARE @Continent  NVARCHAR(30);

  SET     @Continent = (
         CASE 
		     WHEN   @Country = 'Germany'    THEN  'Europe'
			 WHEN   @Country = 'USA'        THEN  'North America'
			 WHEN   @Country = 'India'      THEN  'Asia'
			                                ELSE  'Invalid'
											END
  )
  RETURN(@Continent);
END