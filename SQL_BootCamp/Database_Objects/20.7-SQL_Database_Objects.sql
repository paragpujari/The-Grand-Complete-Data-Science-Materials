--SELECT * FROM [dbo].[Fetch_Customer_Details]();
CREATE OR ALTER FUNCTION [dbo].[Fetch_Customer_Details]()
 RETURNS @Summary TABLE
 (
      CustomerID       INT               ,
	  FirstName        NVARCHAR(30)      ,
	  LastName         NVARCHAR(30)      ,
	  Country          NVARCHAR(30)      ,
	  Score            INT               ,
	  Getdate          DATETIME
 )
AS
  BEGIN
     INSERT INTO @Summary 
	 SELECT 
	 CustomerID                                                 ,
     FirstName													,
     LastName													,
     Country													,
     Score														,
     CreatedDate
	 FROM Customersss WHERE Country = 'Germany';

	 RETURN;
  END;
