/*
SELECT * FROM Employees;

SELECT * FROM EmployeeLogs;
*/

-----Create a trigger that will delete the employee with no title and this trigger will be triggerred after the delete operation

CREATE OR ALTER TRIGGER [dbo].[trigger_employees_details_after_delete]
ON Employees
AFTER DELETE
AS
 BEGIN
   INSERT INTO EmployeeLogs(
        EmployeeID                     ,
        LogMessage					   ,
        LogDate
   )
   SELECT 
   EmployeeID                                              ,
   'New Employee Added =' + CAST(EmployeeID AS VARCHAR)	   ,
   GETDATE()
   FROM deleted
 END