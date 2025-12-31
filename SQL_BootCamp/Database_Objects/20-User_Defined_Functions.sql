/*

Create a scalar function to classify a customer based on Score

Rule

Score ≥ 800 → Platinum

Score 700–799 → Gold

Score 500–699 → Silver

Else → Bronze

SELECT CustomerID, FirstName, Score,
       dbo.fn_CustomerCategory(Score) AS Category
FROM Customers;

*/

CREATE OR ALTER FUNCTION [dbo].[fn_customercategory](@Score INT)
RETURNS VARCHAR(30)
AS
  BEGIN
     RETURN(
	     CASE
		       WHEN @Score >= 800                     THEN  'Platinum'
			   WHEN @Score >= 700 AND @Score <= 799   THEN  'Gold'
			   WHEN @Score >= 500 AND @Score <= 699   THEN  'Silver'
			                                          ELSE  'Bronze'
													  END
	 )
  END;