
/*
SELECT 
CONCAT(c.FirstName,' ',c.LastName)       AS     LastName	   ,
o.OrderID                                                      ,
o.OrderStatus                                                  ,
o.OrderDate                                                    ,
o.Sales
FROM Customers c
JOIN          Orders    o
ON            c.CustomerID = o.CustomerID

EXEC [DBO].[Fetch_Customer_Order_Details]
*/
CREATE OR ALTER PROCEDURE [DBO].[Fetch_Customer_Order_Details]
AS
   BEGIN
    /*-------------------------Declare the Variables----------------------*/
	DECLARE @FullName         NVARCHAR(30);
	DECLARE @OrderID          INT         ;
	DECLARE @OrderStatus      NVARCHAR(30);
	DECLARE @OrderDate        DATETIME    ;
	DECLARE @Sales            INT;

	/*-----------------------Declare the cursor--------------------------*/
	DECLARE fetch_customer_order_details CURSOR FOR
	SELECT
	CONCAT(c.FirstName,' ',c.LastName)       AS     FullName	   ,
    o.OrderID                                                      ,
    o.OrderStatus                                                  ,
    o.OrderDate                                                    ,
    o.Sales
    FROM Customers c
    JOIN          Orders    o
    ON            c.CustomerID = o.CustomerID;

	/*-------------------Open the cursor----------------------------------*/
	OPEN fetch_customer_order_details;

	/*-------------------Fetch the first row data from the cursor----------------*/
	FETCH NEXT FROM fetch_customer_order_details
	           INTO @FullName, @OrderID, @OrderStatus, @OrderDate, @Sales

	/*------------------Check if the fetch operation is successful-----------------*/
	WHILE(@@FETCH_STATUS = 0)
	   BEGIN
	      /*---------------Print the first customer details-------------------------*/
		  PRINT CONCAT('FullName:',@FullName               , ' '            ,
		               'OrderID:' ,@OrderID                , ' '            ,
					   'OrderStatus:',@OrderStatus         , ' '            ,
					   'OrderDate:', @OrderDate            , ' '            ,
					   'Sales:', @Sales)

		/*-----------Fetch the next customer order data from the cursor-------------------*/
		FETCH NEXT FROM fetch_customer_order_details
	           INTO @FullName, @OrderID, @OrderStatus, @OrderDate, @Sales

	   END;
      CLOSE fetch_customer_order_details;

	DEALLOCATE fetch_customer_order_details;

   END
