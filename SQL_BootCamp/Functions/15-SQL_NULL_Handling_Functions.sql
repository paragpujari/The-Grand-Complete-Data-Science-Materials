USE DATASCIENCE;

/*
1. Find customers whose Score is NULL
*/

SELECT * FROM Customers WHERE Score IS NULL;

/*
2. Customers with a valid CreatedDate
*/

SELECT * FROM Customers WHERE CONVERT(DATE,CreatedDate) IS NOT NULL;

/*
3.  Customers who have a Score
*/

SELECT * FROM Customers WHERE Score IS NOT NULL ORDER BY CreatedDate;

/*
4. Show Score as 0 if NULL
*/

SELECT ISNULL(Score,0) AS Total_Score,* FROM Customers order by CreatedDate;

/*
5.  Replace NULL Country with 'Unknown'
*/

SELECT *,ISNULL(Country,'Unknown') AS replacedcountry FROM Customers ORDER BY CreatedDate;


/*
6. Replace NULL Score with 0 ------------> It returns the first NOT NULL Value from the list.
*/

SELECT *,COALESCE([Score],0) AS Scores FROM Customers ORDER BY CreatedDate;

/*
7.  Multiple fallback values
*/

SELECT *,COALESCE([Country],'India','USA') AS newcountry FROM Customers;

/*
8. Convert the Score to 0 if NULL
*/

SELECT *,ISNULL([Score],0) AS Scores, NULLIF([Score],0) AS Total_Scores, COALESCE([Score],0) AS newscores FROM Customers ORDER BY CreatedDate;

/*
9.  Example: Avoid divide-by-zero error
*/

SELECT *,(1000/NULLIF([Score],0)) AS Scores , (1000/ISNULL([Score],0)) AS Scoress FROM Customers;

/*
10. Replace NULL Score, NULL Country, and format output
*/

SELECT
    CustomerID,
    FirstName,
    LastName,
    COALESCE(Country, 'Unknown') AS Country,
    ISNULL(Score, 0) AS Score,
    CreatedDate
FROM Customers
WHERE CreatedDate IS NOT NULL;
