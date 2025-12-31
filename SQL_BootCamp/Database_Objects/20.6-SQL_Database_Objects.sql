/*
   Return customer-wise total orders and sales.
*/
--- SELECT * FROM [dbo].[Customer_TotalOrders_Sales]();
CREATE OR ALTER FUNCTION [dbo].[Customer_TotalOrders_Sales]()
RETURNS @Summary TABLE
( 
        CustomerID       INT                ,
		OrderID          INT                ,
		Total_Sales      INT
)
AS
  BEGIN
    
	 INSERT INTO @Summary 
	 SELECT CustomerID, COUNT([OrderID]) AS Total_Orders,SUM([Sales]) AS Total_Sales
	 FROM Ordersss
	 GROUP BY CustomerID

	RETURN;

  END;