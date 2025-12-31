/* ==============================================================================
   SQL CASE Statement
-------------------------------------------------------------------------------
   This script demonstrates various use cases of the SQL CASE statement, including
   data categorization, mapping, quick form syntax, handling nulls, and conditional 
   aggregation.
   
   Table of Contents:
     1. Categorize Data
     2. Mapping
     3. Quick Form of Case Statement
     4. Handling Nulls
     5. Conditional Aggregation
=================================================================================
*/

/* ==============================================================================
   USE CASE: CATEGORIZE DATA
===============================================================================*/

/* TASK 1: 
   Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/

USE DATASCIENCE;

;with cte as(
SELECT *,CASE WHEN Sales > 50                 THEN 'High'
              WHEN Sales > 20 AND Sales <= 50 THEN 'Medium'
			  WHEN Sales <= 20                THEN 'Low'
			                                  ELSE 'Invalid' END AS Category
FROM Orders
)
SELECT Category, SUM(CONVERT(INT, Sales)) AS Total_Sales
FROM cte
GROUP BY Category
ORDER BY 2 DESC;




/* ==============================================================================
   USE CASE: MAPPING
===============================================================================*/

/*
TASK 2:
Retrieve customer details with abbreviated country codes 
*/

;with cte1 as(
SELECT *,CASE WHEN Country = 'Germany' THEN 'GE'
              WHEN Country = 'USA'     THEN 'US'
			  WHEN Country = 'India'   THEN 'IN'
			                           ELSE 'Invalid'
									   END AS Country_Code
FROM Customers
)
SELECT * FROM cte1 order by Score desc;


/*
TASK 3:
Retrieve customer details with Continent for each country
*/
;with cte1 as(
SELECT *, CASE WHEN Country = 'Germany' THEN 'Europe'
               WHEN Country = 'USA'     THEN 'North America'
			   WHEN Country = 'India'   THEN 'Asia'
			                            ELSE 'Invalid' END AS Continent
										FROM Customers
)
SELECT * FROM cte1;

/*
TASK 4:
   Average scores based on country making sure than when the score IS NULL THEN 0 else score.
*/

;with cte1 as(
SELECT *, CASE WHEN Score IS NULL THEN 0 ELSE Score END AS Scores FROM Customers
)
SELECT Country, SUM(Scores) AS Total_Score
FROM cte1
GROUP BY Country
ORDER BY 2 DESC;

/* ==============================================================================
   CONDITIONAL AGGREGATION
===============================================================================*/

/*
TASK 5:
Count how many orders each customer made with sales greater than 30 
*/

;with cte1 as(
SELECT *,CASE WHEN Sales > 30 THEN 1 ELSE 0 END AS SalesNumber FROM Orders
)
SELECT * FROM cte1
WHERE SalesNumber = 1;