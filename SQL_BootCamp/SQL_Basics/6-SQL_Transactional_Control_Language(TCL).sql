USE DATASCIENCE;


-----1. Insert a new customer into the Customers table and commit the transaction-----

BEGIN TRANSACTION;

     INSERT INTO Customers(CustomerID, FirstName, LastName, Country,Score)VALUES(2,'Kelly','Martin','USA',789);
	 INSERT INTO Customers(CustomerID, FirstName, LastName, Country,Score)VALUES(3,'Peter','Stewart','USA',768);
	 INSERT INTO Customers(CustomerID, FirstName, LastName, Country,Score)VALUES(6,'Bruce','Mckley','USA',785);
	 INSERT INTO Customers(CustomerID, FirstName, LastName, Country,Score)VALUES(8,'Mayna','Arora','India',987);

COMMIT;


SELECT * FROM Customers;


-----2.Insert a customer but undo the operation--------------------------------------------------

BEGIN  TRANSACTION;
      INSERT INTO Customers(CustomerID, FirstName, LastName, Country,Score)VALUES(11,'Kamna','Sharma','India',879);

ROLLBACK;

SELECT * FROM Customers;


CREATE TABLE Customerss (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Status VARCHAR(20)
);


INSERT INTO Customerss (CustomerID, CustomerName, City, Status)
VALUES
(1, 'Rahul Sharma', 'Mumbai', 'Active'),
(2, 'Amit Verma', 'Delhi', 'Active'),
(3, 'Neha Singh', 'Mumbai', 'Active'),
(4, 'Pooja Mehta', 'Delhi', 'Active'),
(5, 'Rohit Patil', 'Pune', 'Active');



SELECT * FROM Customerss;



-------------3. Update a part of the Customerss details but undo other part of the Customerss transaction details------------------------

BEGIN TRANSACTION;
       -----------------Perform Save point for Mumbai records----------------------------
	   UPDATE Customerss
	   SET    Status = 'Inactive'
	   WHERE  City = 'Mumbai'

	   SAVE TRANSACTION SP1;

	   -----------------Perform Rollback for Delhi Records--------------------------------
	   UPDATE Customerss
	   SET    Status = 'Inactive'
	   WHERE  City = 'Delhi'
	   
	   ROLLBACK TRANSACTION SP1;

COMMIT;


SELECT * FROM Customerss;