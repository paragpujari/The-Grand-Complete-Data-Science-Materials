USE DATASCIENCE;


/*
Transaction to transfer order from one customer to another
*/
BEGIN TRANSACTION;
 
 BEGIN TRY
   UPDATE Orders
   SET    OrderID = 4
   WHERE CustomerID = 3

COMMIT TRANSACTION;

END TRY

BEGIN CATCH
   SELECT ERROR_LINE();
   SELECT ERROR_MESSAGE();
   SELECT ERROR_NUMBER();
END  CATCH


/*
Transaction to delete customer only if no active orders
*/

BEGIN TRANSACTION;
   BEGIN TRY
     DELETE FROM Orders WHERE OrderID IS NULL AND ShipDate IS NULL AND OrderStatus IS NULL;
   COMMIT TRANSACTION;
END TRY

BEGIN CATCH
  SELECT ERROR_MESSAGE();
END CATCH
