USE DATASCIENCE;

----- Create the Clustered index on Country column-----------------
CREATE CLUSTERED INDEX CIX_Customers_Country ON Cust1(Country);

/*
Non-Clustered Index

A non-clustered index creates a separate structure that points back to the data rows
*/
-------Create a non clustered index on Last Name------------------------

CREATE NONCLUSTERED INDEX NONCIX_Customers_LastName ON Cust1(LastName);


------------Create a filtered index on all the scores above 500------------------------------
CREATE NONCLUSTERED INDEX NONCIX_Cust1_Scores ON Cust1(Score) WHERE Score > 500; 


-----------Create Unique Index on Score-----------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX UNI_Cust1_Scores ON cust111(CustomerID);




