USE DATASCIENCE;

/*  1. Get all customers from India */

SELECT * FROM Customers WHERE Country = 'India'ORDER BY Score;

/* 2. Get customers whose Score is greater than 80 */

SELECT * FROM Customers WHERE Score > 80 ORDER BY Score;

/* 3. Customers from India with Score greater than 85 */

SELECT * FROM Customers WHERE Score > 85 ORDER BY Score;

/* 4. Customers from India OR USA */

SELECT * FROM Customers WHERE Country IN ('India') OR Country IN ('USA') ORDER BY Score;

/* 5. Customers from India, USA, or UK */

SELECT * FROM Customers WHERE Country IN ('India','USA','UK') ORDER BY Score;

/* 6. Customers not from India or USA */

SELECT * FROM Customers WHERE Country NOT IN ('India','USA') ORDER BY Score;


/* 7. Customers with Score between 60 and 80 */

SELECT * FROM Customers WHERE Score BETWEEN 60 AND 80 ORDER BY Score;

/* 8. Customers whose CustomerID is between 100 and 200 */

SELECT * FROM Customers WHERE CustomerID BETWEEN 100 AND 200 ORDER BY Score;

/* 9. Customers whose FirstName starts with 'A' */

SELECT * FROM Customers WHERE FirstName LIKE 'A%' ORDER BY Score;

/* 10. Customers whose LastName ends with 'son' */

SELECT * FROM Customers WHERE LastName LIKE '%son' ORDER BY Score;


/* 11.  Customers whose FirstName contains 'ra'  */

SELECT * FROM Customers WHERE FirstName like '%ra%' order by score;

/* 12. Get list of unique countries */

SELECT DISTINCT Country AS Unique_Country FROM Customers;
 
/* 13. Count how many distinct countries */

;with cte1 as(
SELECT DISTINCT Country AS Country FROM Customers
)
SELECT COUNT(Country) as distinct_country FROM cte1;


/* 14. Sort customers by Score (Highest first) */

SELECT * FROM Customers ORDER BY Score DESC;

/* 15. Sort by Country (A–Z) and Score (High–Low) */

SELECT * FROM Customers ORDER BY Country, Score DESC;


/* 16. Get Top 5 customers by Score */

SELECT TOP 5 * FROM Customers ORDER BY Score;


/* 17. Top 3 customers from India based on Score */

SELECT TOP 3 * FROM Customers WHERE Country = 'India' ORDER BY Score;


/* 18.  Customers whose name starts with S and Score ≥ 70 */

SELECT  * FROM Customers WHERE FirstName LIKE 'S%' AND Score >= 70 ORDER BY Score;


/* 19. Customers not from India with Score between 50 and 90 */

SELECT  * FROM Customers WHERE Country <> 'India' AND Score BETWEEN 50 AND 90 ORDER BY Score DESC;


/* 20.  Second highest scoring customer (SQL Server) */

SELECT TOP 1 * FROM Customers WHERE Score < (
SELECT MAX(Score) AS Highest_Score FROM Customers
) ORDER BY Score DESC;