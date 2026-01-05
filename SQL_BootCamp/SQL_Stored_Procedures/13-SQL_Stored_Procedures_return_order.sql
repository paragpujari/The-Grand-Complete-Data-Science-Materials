/*
Write a stored procedure that returns the orders for the respective customers

EXEC [DBO].[Return_Orders_for_the_customer] 35
*/

CREATE  OR ALTER PROCEDURE [DBO].[Return_Orders_for_the_customer]
( 
    @CustomerID   INT
)
AS
  BEGIN
     /*---------------If the customer does not exists in the table----------------------------*/
	 IF NOT EXISTS(SELECT * FROM Customers WHERE CustomerID = @CustomerID)
	   BEGIN
	      THROW 50005,'Customer ID does not exists in the table',1;
	   END

	/*--------------Return the Sales details for the customer that exists-----------------------------*/
	DROP TABLE IF EXISTS #CustomerOrders;

	CREATE TABLE #CustomerOrders
    (
        CustomerID                    INT             ,
		OrderID                       INT             ,
        OrderDate                     DATETIME        ,
        OrderStatus                   NVARCHAR(30)    ,
        Sales                         INT
    )
	INSERT INTO #CustomerOrders
	SELECT 
	CustomerID                                        ,
	OrderID                                           , 
	OrderDate  										  ,
	OrderStatus										  ,
	Sales      
	FROM [DATASCIENCE].[DBO].[Orders]
	WHERE CustomerID = @CustomerID

	SELECT * FROM #CustomerOrders ORDER BY OrderDate;

  END


