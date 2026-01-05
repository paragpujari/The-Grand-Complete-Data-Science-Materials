/*
Write a procedure in such a way that we need to insert the records of the orders for a particular customer

(a.) If the customer is not there in the table, throw an error

(b.) It the order already exists in the table, then throw the error

(c.) It the sales value is 0 or negative, then throw the error

else insert the records of the order for that customer.

SELECT * FROM Orders ORDER BY OrderID;

EXEC [DBO].[Insert_Order_Details_for_Customer_IFCATCH]24,18,0

*/

CREATE OR ALTER PROCEDURE [DBO].[Insert_Order_Details_for_Customer_IFCATCH]
(
      @CustomerID            INT            ,
	  @OrderID               INT            ,
	  @Sales                 INT
)
AS
  BEGIN
     SET NOCOUNT ON;

	 BEGIN TRANSACTION;

	   BEGIN TRY
	   /*-----------------If the customer does not exists in the table------------------------------------*/
	   IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
	      BEGIN
		      THROW 50003,'Customer ID is not there in the table',1;
		  END
	  /*----------------If the order already exists in the table------------------------------------------*/
	  IF EXISTS(SELECT 1 FROM Orders WHERE OrderID = @OrderID)
	     BEGIN
		   THROW 50004,'Order ID already exists in the table',1;
		 END

	  /*---------------If the sales value is zero or negative--------------------------------------------*/
	  IF @Sales <= 0
	    BEGIN
		   THROW 50005,'Sales Value is zero or negative',1;
		END

	/*-------------------Insert the order details for that customer--------------------------------------------*/
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
			            @OrderID                            ,
						'105'                               ,
						@CustomerID                         ,
						'3'                                 ,
						GETDATE()                           ,
						GETDATE()                           ,
						'Shipped'                           ,
						'2947 Vine Lane'                    ,
						'4311 Clay Rd'                      ,
						3                                   ,
						@Sales                              ,
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