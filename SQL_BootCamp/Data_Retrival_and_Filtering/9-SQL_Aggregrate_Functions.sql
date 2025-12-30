USE DATASCIENCE;

/*
1.  Count total number of customers
*/


SELECT COUNT(CustomerID) AS Total_Customers FROM Customers;

/*
2. Count customers who have a score
*/

SELECT COUNT(CustomerID) AS Total_Customers FROM Customers WHERE Score IS NOT NULL;

/*
3. Find the total score of all customers
*/

SELECT SUM(CONVERT(INT,Score)) AS Total_Scores FROM Customers;

/*
4.Find the average customer score
*/

SELECT AVG(CONVERT(FLOAT,Score)) AS Average_Scores FROM Customers;

/*
5.  Find the highest score
*/

SELECT MAX(Score) AS Highest_Score FROM Customers;

/*
6.  Find the lowest score
*/

SELECT MIN(Score) AS Lowest_Score FROM Customers;


/*
7.  Count customers country-wise
*/

SELECT Country, COUNT(1) AS Customers
FROM Customers
GROUP BY Country;


/*
8.  Find average score per country
*/

SELECT Country, AVG(Score) AS Average_Score
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/*
9.  Find countries where average score > 70
*/

SELECT Country, AVG(Score) AS Average_Score
FROM Customers
GROUP BY Country
HAVING AVG(Score) > 70
ORDER BY 2 DESC;

/*
10.  Find max score in each country
*/

SELECT Country, MAX(Score) AS Maximum_Score
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/*
11. Count distinct countries
*/

SELECT  COUNT(DISTINCT(Country)) AS Distinct_Coutry FROM Customers;

/* 12. Find total score per country */

SELECT  Country, SUM(Score) AS Total_score 
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/*
   13. Find countries having more than 5 customers
*/

SELECT Country, COUNT(CustomerID) AS Total_Customers
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY 2 DESC;


/* 14. Find customers whose score is above the overall average score */

SELECT * FROM Customers WHERE Score > (
SELECT AVG(Score) AS Average_Score FROM Customers
)ORDER BY Score desc;

/* 15. Find the customer(s) with the maximum score */

SELECT * FROM Customers WHERE Score IN (
SELECT MAX(Score) AS Max_Score FROM Customers
) ORDER BY Score;

/* 16. Difference between COUNT(*) and COUNT(Score) */

SELECT COUNT(*) AS TotalRows,
       COUNT(Score) AS NonNullScores
FROM Customers;


/* 17.  Handle NULL scores while calculating average */

SELECT AVG(ISNULL(Score,0)) AS Average_Score FROM Customers;


/* 18. Round average score to 2 decimals */


SELECT ROUND(AVG(ISNULL(Score,0)),2) AS Average_Score FROM Customers;

/* 19. Country with highest average score */

SELECT TOP 1 Country, AVG(ISNULL(Score,0)) AS Average_Score
FROM Customers
GROUP BY Country
ORDER BY 2 DESC;

/* 20. Country with lowest total score */


SELECT TOP 1 Country, AVG(ISNULL(Score,0)) AS Average_Score
FROM Customers
GROUP BY Country
ORDER BY 2;