USE DATASCIENCE;


SELECT * FROM Customers;

USE DATASCIENCE;
GO

SELECT name FROM sys.database_principals





------1. Give read-only access on the Customers table to a user named sys.---------------------------

GRANT SELECT ON dbo.Customers TO sys;


-----2. Grant INSERT permission to a sys on the Customer table----------------------------------------

GRANT INSERT ON dbo.Customers TO sys;


-----3. Grant SELECT, INSERT, and UPDATE permissions on Customers to sys---------------------------------

GRANT SELECT, INSERT, UPDATE ON dbo.Customers TO sys;


--------4. Remove UPDATE access from sys on Customers table.----------------------------------------------

REVOKE UPDATE ON dbo.Customers FROM sys;

--------5. Give user cleanup_user permission to delete records from Customers--------------------------------

GRANT DELETE ON dbo.Customers TO sys;

----------6. Remove all permissions from report_user on Customers---------------------------------------------

REVOKE ALL ON dbo.Customers FROM sys;