
/*
Trigger to prevent inserting orders with Quantity = 0
*/
CREATE OR ALTER TRIGGER dbo.Insert_Trigger_Order_Details
ON dbo.Orders
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Quantity <= 0)
    BEGIN
        RAISERROR('Quantity cannot be zero',16,1);
        ROLLBACK TRANSACTION;
    END
END;



/*
Trigger to update customer score after a successful order
*/

CREATE OR ALTER TRIGGER dbo.update_customer_score
ON dbo.Customers
AFTER INSERT
AS
 BEGIN
   UPDATE a 
   SET   a.Score = a.Score + 5
   FROM  Customers a
   JOIN  inserted  i
   ON    a.CustomerID = i.CustomerID
   WHERE i.Score > 100;

 END;

/*
Audit trigger to log deleted orders
*/
CREATE OR ALTER TRIGGER dbo.OrderAudit
ON dbo.Orders
AFTER DELETE
AS
BEGIN
    INSERT INTO OrderAudit (OrderID)
    SELECT OrderID FROM deleted;
END;
