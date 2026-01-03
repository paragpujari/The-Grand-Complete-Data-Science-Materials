/*
SELECT * FROM Employees;

SELECT * FROM EmployeeLogs;

*/


CREATE OR ALTER TRIGGER [dbo].[trigger_employees_details_before_insert]
ON Employees
AFTER INSERT
AS
  BEGIN
       BEGIN TRANSACTION;
	      BEGIN TRY
		      INSERT INTO EmployeeLogs(
                       EmployeeID                                       ,
                       LogMessage							            ,
                       LogDate
			  )
			  SELECT
			  EmployeeID                                               ,
			  'New Employee Added = ' + CAST(EmployeeID AS VARCHAR)    ,
			  GETDATE()
			  FROM inserted
		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
	     SELECT ERROR_LINE()                                           ;
		 SELECT ERROR_MESSAGE()                                        ;
		 SELECT ERROR_NUMBER()
	END CATCH
END



INSERT INTO Employees(
            EmployeeID                   ,
            FirstName					 ,
            LastName					 ,
            Department					 ,
            BirthDate					 ,
            Gender						 ,
            Salary						 ,
            ManagerID
)
SELECT  
            1                            ,
			'Alice'                      ,
			'Annie'                     ,
			'Sales'                      ,
			GETDATE()                    ,
			'F'                          ,
			87900                        ,
			4