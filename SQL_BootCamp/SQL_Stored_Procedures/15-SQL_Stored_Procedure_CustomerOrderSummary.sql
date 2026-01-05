/*

DECLARE @TotalOrders INT;
DECLARE @AvgSales    DECIMAL(18,2);
DECLARE @ReturnCode INT;

EXEC @ReturnCode = dbo.Fetch_Customer_Order_Summary
     @CustomerID  = 1                     ,
	 @TotalOrders = @TotalOrders OUTPUT   ,
	 @AvgSales    = @AvgSales    OUTPUT   ;

SELECT @ReturnCode  AS ReturnCode,
       @TotalOrders AS TotalOrders,
	   @AvgSales    AS TotalOrders;

*/

CREATE OR ALTER PROCEDURE dbo.Fetch_Customer_Order_Summary
(
    @CustomerID    INT,
    @TotalOrders   INT     OUTPUT,
	@AvgSales     FLOAT    OUTPUT
)
AS
BEGIN
    -- Validate Customer
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        THROW 50004, 'Customer ID does not exist in the table', 1;
    END

    -- Calculate metrics
    SELECT @TotalOrders = COUNT(1) FROM Orders WHERE CustomerID = @CustomerID;

	SELECT @AvgSales   = AVG([Sales])    FROM Orders WHERE CustomerID = @CustomerID;

    RETURN 0; -- success
END;
