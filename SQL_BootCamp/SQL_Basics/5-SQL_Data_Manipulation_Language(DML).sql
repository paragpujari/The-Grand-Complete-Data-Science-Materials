/* ==============================================================================
   SQL Data Manipulation Language (DML)
-------------------------------------------------------------------------------
   This guide covers the essential DML commands used for inserting, updating, 
   and deleting data in database tables.

   Table of Contents:
     1. INSERT - Adding Data to Tables
     2. UPDATE - Modifying Existing Data
     3. DELETE - Removing Data from Tables
=================================================================================
*/





/* ============================================================================== 
   INSERT
=============================================================================== */

USE DATASCIENCE;

------Insert new records into the customers table

INSERT INTO Customers(CustomerID, FirstName,LastName,Country,Score) VALUES(6,  'Max',    'Wilson'  ,    'USA'       , 368);
INSERT INTO Customers(CustomerID, FirstName,LastName,Country,Score) VALUES(7,  'Kim',    'Peterson',    'Germany'   , 468);
INSERT INTO Customers(CustomerID, FirstName,LastName,Country,Score) VALUES(8,  'Tim',    'Brown'   ,    'USA    '   , 568);
INSERT INTO Customers(CustomerID, FirstName,LastName,Country,Score) VALUES(9,  'Willie', 'Mckley'  ,    'Germany'   , 668);
INSERT INTO Customers(CustomerID, FirstName,LastName,Country,Score) VALUES(10, 'Annie',  'Luther'  ,    'India'     , 768);



SELECT * FROM Customers;

---Insert a record with only id and first_name (other columns will be NULL or default values)

INSERT INTO Customers(CustomerID, FirstName)VALUES(11,'Katty');


/* #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */

INSERT INTO Customers(
CustomerID              ,
FirstName               ,
LastName                ,
Country                 ,
Score
)
SELECT 
'12'          ,
'Anisha'      ,
'Banka'       ,
'India'       ,
987

SELECT * FROM Customers;



/* ============================================================================== 
   UPDATE
=============================================================================== */



-------------1.  Update the title for 'Katty' to Perry------------------

UPDATE Customers
SET    LastName = 'Perry'
WHERE FirstName = 'Katty' AND CustomerID = 11;

-------------2.  Update the Country for 'Katty' to India------------------

UPDATE Customers
SET    Country = 'India'
WHERE FirstName = 'Katty' AND LastName = 'Perry' AND CustomerID = 11;



-------------3.  Update the Salary for 'Katty' to twice of 245------------------

UPDATE Customers
SET    Score = 2 * 245
WHERE FirstName = 'Katty' AND LastName = 'Perry' AND CustomerID = 11;


--------------4. Change the LastName to 'Brown' for id 6 and 9------------------------

UPDATE Customers 
SET   LastName = 'Brown'
WHERE CustomerID IN (6,9)

SELECT * FROM Customers;



/* ============================================================================== 
   DELETE
=============================================================================== */

----------------Delete all the details from the Customers whose ID > 10------------------------------------
DELETE FROM Customers WHERE CustomerID > 10;

----------------Delete all the details whose Country = 'USA'--------------------------------------------------

DELETE FROM Customers WHERE Country = 'USA';



SELECT * FROM Customers;
