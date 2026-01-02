/*
1.  Scalar function to classify customer credit score
*/
--SELECT  dbo.fn_CreditCategory(843) AS CreditCategory FROM Customers;
CREATE OR ALTER FUNCTION [dbo].[fn_CreditCategory]
(
    @Score  INT
)
RETURNS NVARCHAR(30)
AS
  BEGIN
        RETURN(
		     CASE WHEN @Score >= 800                        THEN     'Excellent'
			      WHEN @Score >= 700 AND @Score <= 799      THEN     'Good'
				  WHEN @Score >= 600 AND @Score <= 699      THEN     'Average'
				                                            ELSE     'Not Good'
															END

		);
  END;