/* ==============================================================================
   SQL SELECT Query
-------------------------------------------------------------------------------
   This guide covers various SELECT query techniques used for retrieving, 
   filtering, sorting, and aggregating data efficiently.

   Table of Contents:
     1. SELECT ALL COLUMNS
     2. SELECT SPECIFIC COLUMNS
     3. WHERE CLAUSE
     4. ORDER BY
     5. GROUP BY
     6. HAVING
     7. DISTINCT
     8. TOP
     9. Combining Queries
	 10. COOL STUFF - Additional SQL Features
=================================================================================
*/


/* ==============================================================================
   COMMENTS
=============================================================================== */

-- This is a single-line comment.

/* This
   is
   a multiple-line
   comment
*/

/* ==============================================================================
   SELECT ALL COLUMNS
=============================================================================== */



USE DATASCIENCE;


---------------Fetch all the data from the Customers-------------------------


SELECT * FROM Customers;

--------------OR--------------------------

SELECT 
CustomerID                ,
FirstName				  ,
LastName				  ,
Country					  ,
Score
FROM
Customers;



------------------------ Retrieve All Order Data-----------------------------------------------


SELECT * FROM Orders;


SELECT 
OrderID                 ,
ProductID				,
CustomerID				,
SalesPersonID			,
OrderDate				,
ShipDate				,
OrderStatus				,
ShipAddress				,
BillAddress				,
Quantity				,
Sales					,
CreationTime
FROM Orders;



---Retrieve each customer's name, country, and score.--------------------------------------------------


SELECT                                        
FirstName                                                 ,
LastName												  ,
CONCAT(FirstName,' ' ,LastName)   AS FullName			  ,
Country													  ,
Score
FROM Customers;



/* ==============================================================================
   ORDER BY
=============================================================================== */


/* Retrieve all customers and sort the results by the highest score first. */

SELECT * FROM Customers ORDER BY Score DESC;


/* Retrieve all customers and sort the results by the lowest score first. */

SELECT * FROM Customers ORDER BY Score ASC;

/* Retrieve all customers and sort the results by the country. */

SELECT * FROM Customers ORDER BY Country;

/* Retrieve all customers and sort the results by the country and then by the highest score. */

SELECT * FROM Customers ORDER BY Country, Score DESC;

/* Retrieve the name, country, and score of customers whose score is not equal to 0 and sort the results by the highest score first. */

SELECT CONCAT(FirstName, ' ', LastName) AS FullName ,
       Country                                      ,
	   Score
FROM Customers WHERE Score != 0 ORDER BY Score DESC;


/* Select only FirstName and Country */

SELECT FirstName, Country FROM Customers;

/* Select unique countries */

SELECT DISTINCT Country AS Unique_Country FROM Customers;

/* Get customers from India */

SELECT * FROM Customers WHERE Country = 'India';

/* Get customers with Score greater than 80 */

SELECT * FROM Customers WHERE Score > 80;

/* Get customers from India with Score ≥ 70*/

SELECT * FROM Customers WHERE Score >= 70 ORDER BY Score;

/* Get customers from India OR USA */

SELECT * FROM Customers WHERE Country IN ('India') OR Country IN ('USA') ORDER BY Score;

/* Get customers with Score between 60 and 90 */

SELECT * FROM Customers WHERE Score BETWEEN 60 AND 90 ORDER BY Score;

/* Get customers whose Score is NOT between 50 and 70 */

SELECT * FROM Customers WHERE Score NOT BETWEEN 50 AND 70 ORDER BY Score;

/*  Find customers whose Score is NULL  */


SELECT * FROM Customers WHERE Score IS NULL ORDER BY Score;

/* Replace NULL Score with 0 in output  */

SELECT *,ISNULL(Score,0) AS NewScores FROM Customers  ORDER BY Score;


/*  Sort customers by Score in ascending order  */

SELECT * FROM Customers ORDER BY Score;

/* Sort customers by Country and then Score descending */

SELECT * FROM Customers ORDER BY Country, Score DESC;


/*  Get top 5 customers with highest Score (SQL Server) */

SELECT TOP 5 * FROM Customers ORDER BY Score DESC;

/* Find customers whose FirstName starts with 'A' */

SELECT * FROM Customers WHERE FirstName like 'A%' ORDER BY Score;


/* Find customers whose LastName contains 'son' */

SELECT * FROM Customers WHERE LastName LIKE '%son%' ORDER BY Score;


/* Display Full Name of customers */

SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName,Score FROM Customers ORDER BY Score;

/* Find total number of customers */

SELECT COUNT(1) AS Total_Customers FROM Customers;

/* Find average customer Score */

SELECT AVG(Score) AS Average_Score FROM Customers;


/* Find maximum and minimum Score */

SELECT MIN(Score) as minimum_score, MAX(Score) as maximum_score FROM Customers;

/* Count customers per Country */

SELECT Country, COUNT(CustomerID) AS Customer
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/* Find average Score per Country */

SELECT Country, AVG(Score) as Average_Score
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/* Countries having average Score greater than 75 */

SELECT Country, AVG(Score) AS Average_Score
FROM Customers
GROUP BY Country
HAVING AVG(Score) > 75
ORDER BY 2 DESC;

/* Customers with Score higher than average Score */

SELECT * FROM Customers WHERE Score >(
SELECT AVG(Score) AS Average_Score FROM Customers
)
ORDER BY Score DESC;


/* Find top scorer from each Country */

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT Country, MAX(Score) AS Max_Score 
FROM Customers
GROUP BY Country
)
SELECT 
a.FirstName                                           ,
a.LastName                                            ,
CONCAT(a.FirstName,' ', a.LastName)   AS FullName     ,
B.Max_Score                           AS TopScore
FROM cte1 a
JOIN          cte2 b
ON            a.Country = b.Country
AND           a.Score   = b.Max_Score;



/* Customers with duplicate FirstName */

SELECT FirstName, COUNT(1) AS CountFirst
FROM Customers
GROUP BY FirstName
ORDER BY 2 DESC;