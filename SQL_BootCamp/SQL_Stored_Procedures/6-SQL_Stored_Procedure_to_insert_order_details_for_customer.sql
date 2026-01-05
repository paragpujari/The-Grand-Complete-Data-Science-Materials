/*
SELECT * FROM Customers;

SELECT * FROM Orders ORDER BY OrderID;

---------Insert the order details for the particular customer-------------------
1. Check if the customer exists or not. If not then throw an error

2. If none of the above matches then insert the order details for the particular order details
--EXEC [DBO].[Insert_Order_Details_for_Customer]6,13
*/
CREATE OR ALTER PROCEDURE [DBO].[Insert_Order_Details_for_Customer]
(
  @CustomerID   INT,
  @OrderID      INT
)
AS
  BEGIN
      SET NOCOUNT ON;

	  BEGIN TRANSACTION;

	     BEGIN TRY
		    /*-----------If the particular customer does not exists in the table-------------*/
			IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
			 BEGIN
			    THROW 50003, 'Customer ID does not exists in the customer table',1;
			 END

			 /*-----------If the particular order  exists in the table-------------*/
			IF EXISTS(SELECT 1 FROM Orders WHERE OrderID = @OrderID)
			 BEGIN
			    THROW 50004, 'Order ID exists in the order table',1;
			 END
			/*----------If the particular customer already exists then insert its  entries in the order table------------*/
			INSERT INTO Orders(
			            OrderID                             ,
                        ProductID							,
                        CustomerID							,
                        SalesPersonID						,
                        OrderDate							,
                        ShipDate							,
                        OrderStatus							,
                        ShipAddress							,
                        BillAddress							,
                        Quantity							,
                        Sales								,
                        CreationTime
			)VALUES(
			            '14'                                ,
						'104'                               ,
						@CustomerID                         ,
						'4'                                 ,
						GETDATE()                           ,
						GETDATE()                           ,
						'Shipped'                           ,
						'Vine Lane'                         ,
						'4310 Clay Road'                    ,
						'4'                                 ,
						'90'                                ,
						GETDATE()

			);

		 COMMIT TRANSACTION;
		END TRY

	BEGIN CATCH
	    ROLLBACK TRANSACTION;
		SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
		SELECT ERROR_NUMBER();
	END CATCH
  END

