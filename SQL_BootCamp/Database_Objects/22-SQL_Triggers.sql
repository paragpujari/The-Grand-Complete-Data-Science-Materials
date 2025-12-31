
CREATE OR ALTER TRIGGER trg_DefaultOrderStatus
ON Orders
AFTER INSERT
AS
BEGIN
    UPDATE o
    SET OrderStatus = 'Pending'
    FROM Orders o
    JOIN inserted i ON o.OrderID = i.OrderID
    WHERE i.OrderStatus IS NULL;
END;
