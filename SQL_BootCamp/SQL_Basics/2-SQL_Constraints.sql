USE DATASCIENCE;


--SELECT * FROM Customers;


---------- 1. Create CustomersData table with CustomerID as Primary Key------------------------

DROP TABLE IF EXISTS CustomersData;

CREATE TABLE CustomersData(
       CustomerID  INT IDENTITY(1,1)  PRIMARY KEY            ,
	   FirstName   VARCHAR(50)         NOT   NULL            ,
	   LastName    VARCHAR(50)         NOT   NULL            ,
	   Country     VARCHAR(50)         NOT   NULL            ,
	   Score       INT
)

SELECT * FROM CustomersData;


------------2. Drop the Defined Constraint from the table-------------------------------------

ALTER TABLE CustomersData DROP CONSTRAINT PK__Customer__A4AE64B800413893;

------------3. Add Primary Key to existing table-----------------------------------------------


ALTER TABLE CustomersData ADD CONSTRAINT PK_CustomersData_CustomerID   PRIMARY KEY(CustomerID);


------------4. Ensure Score cannot be NULL-------------------------------------

ALTER TABLE CustomersData ALTER COLUMN Score INT NOT NULL;

------------5. Ensure combination of FirstName and LastName is unique-------------------------

ALTER TABLE CustomersData ADD CONSTRAINT UK_CustomersData_FirstNameLastName UNIQUE(FirstName,LastName);

-----------6. Ensure Score is between 0 and 100-------------------------------------------------------

ALTER TABLE CustomersData ADD CONSTRAINT CHECK_CustomersData_Score CHECK(Score BETWEEN 0 AND 100);

-----------7. Insert invalid score (will fail)-----------------------------------------------------------

INSERT INTO CustomersData(
            FirstName                 ,
            LastName 				  ,
            Country  				  ,
            Score    
)
VALUES(
            'John'                    , 
			'Doe'                     ,
			'USA'                     ,
			 150
);

/*
OBSERVATIONS:-

1.  The query fails as this insert query fails to insert the record. 
    This is because a check constraint has been applied on the Score saying that its value should between 0 to 100.
    But the query is inserting the record for the score of 150.
*/


-----------8. Set default Country as 'India'--------------------------------------------------------------

ALTER TABLE CustomersData ADD CONSTRAINT DEFAULT_CustomersData_Country DEFAULT 'India' FOR Country;


----------9. Insert data without Country-------------------------------------------------------------------

INSERT INTO CustomersData(
            FirstName                 ,
            LastName 				  ,
            Score    
)
VALUES(
           'Naman'                    ,
		   'Sharma'                   ,
		   99
);

SELECT * FROM CustomersData;

/*
OBSERVATIONS:-

1.  Here as the default constraint has been applied on Country as 'India'. We are not inserting any record for the Country column.
    But by default the value of Country = 'India' is appearing on the table due to the default constraint on it.
*/



-------------10. Create Orders table with FK reference to Customers---------------------------------------------

/*
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
*/

CREATE TABLE OrdersData(
    OrderID           INT       PRIMARY KEY                ,
	CustomerID        INT                                  ,
	OrderDate         DATE                                 ,
	CONSTRAINT       FK_OrdersData_CustomerID
	FOREIGN KEY      (CustomerID)
	REFERENCES       CustomersData(CustomerID)
)

SELECT * FROM CustomersData;

SELECT * FROM OrdersData;



---------- 11. Insert order with invalid CustomerID---------------------------------------------------------------------

INSERT INTO OrdersData VALUES(101, 999, GETDATE());


SELECT * FROM OrdersData;

/*
OBSERVATIONS:

1. Here while inserting the record into the OrdersData table, we can see that the Foreign key constraint appears.

2. This means that the CustomerID must be the same in the CustomerData and OrdersData table.

3.  But error occurs while inserting the record in the OrdersData table as we are inserting the record for the CustomerID = 999 that does not 
exists in the CustomerData table.
*/



--------- 12.Create Customers table with all constraints-------------------------------------------------------------------

DROP TABLE IF EXISTS CustomersDatas;


--CustomerID     INT PRIMARY KEY,
--FirstName      VARCHAR(50) NOT NULL,
--LastName       VARCHAR(50) NOT NULL,
--Country        VARCHAR(50) DEFAULT 'India',
--Score          INT CHECK (Score BETWEEN 0 AND 100),
--CONSTRAINT UQ_Customers_Name UNIQUE (FirstName, LastName)


CREATE TABLE CustomersDatas(
          CustomerID  INT                                 PRIMARY KEY                              ,
		  FirstName   VARCHAR(50)                         NOT   NULL                               ,
		  LastName    VARCHAR(50)                         NOT   NULL                               ,
		  Country     VARCHAR(50)                         DEFAULT 'India'                          ,--------------add a default constraint--------------
		  Score       INT                                 CHECK(Score BETWEEN 0 AND 100)           , -------------add a check constraint---------------
		  CONSTRAINT  UIQ_CustomersDatas_Name             UNIQUE(FirstName, LastName)               --------------add a unique constraint of the full name
)

SELECT * FROM CustomersDatas;


------ 13. List all constraints on Customers table--------------------------------------------------------------------

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'CustomersDatas';



----------14.Drop CHECK constraint----------------------------------------------------------------

ALTER TABLE CustomersDatas   DROP CONSTRAINT CK__Customers__Score__5441852A;



