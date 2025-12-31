--USE DATASCIENCE;

/*
 Create a scalar function to classify customer score

 SELECT * FROM Customersss ORDER BY Score;
*/
----[dbo].[Get_Category_for_Score] 350


CREATE OR ALTER FUNCTION [dbo].[Get_Category_for_Score]
(
  @Score  INT
)
RETURNS VARCHAR(30)
AS
  BEGIN
   
   DECLARE @Category  VARCHAR(30);

   SET     @Category = 
       CASE 
	       WHEN @Score >= 800                   THEN   'High'
		   WHEN @Score >= 600  AND @Score < 800 THEN   'Medium'
		   WHEN @Score >= 350  AND @Score < 600 THEN   'Low'
		                                        ELSE   'Invalid'
												END;


	RETURN (@Category);

  END;

