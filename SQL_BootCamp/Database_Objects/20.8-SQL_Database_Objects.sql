/*

Prevent inserting orders with Quantity ≤ 0

*/

CREATE OR ALTER TRIGGER trg_ValidateOrderQuantity
ON Orders
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Quantity <= 0
    )
    BEGIN
        ROLLBACK;
        THROW 50001, 'Quantity must be greater than zero.', 1;
    END
END;
