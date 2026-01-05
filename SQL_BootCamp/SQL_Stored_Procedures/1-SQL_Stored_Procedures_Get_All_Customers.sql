--EXEC [dbo].[Get_All_Customers];
CREATE OR ALTER PROCEDURE [dbo].[Get_All_Customers]
AS 
 BEGIN
      SELECT * FROM Customers;
 END