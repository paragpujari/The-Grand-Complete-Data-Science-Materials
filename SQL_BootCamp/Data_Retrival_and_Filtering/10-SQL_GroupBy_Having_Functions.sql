USE DATASCIENCE;

/*
 1.  Find total number of customers in each country 
*/

SELECT Country, COUNT(CustomerID) AS Total_Customers FROM Customers GROUP BY Country ORDER BY 2 DESC;

/*
2.  Find average score of customers in each country
*/

SELECT Country, AVG(Score) AS Average_Scores FROM Customers GROUP BY Country ORDER BY 2 DESC;

/*
3.  Find maximum score in each country
*/

SELECT Country, MAX(Score) AS Maximum_Scores FROM Customers GROUP BY Country ORDER BY 2 DESC;

/*
4.  Find minimum score in each country
*/

SELECT Country, MIN(Score) AS Minimum_Scores FROM Customers GROUP BY Country ORDER BY 2 DESC;

/*
5.  Find total score of customers in each country
*/

SELECT Country, SUM(Score) AS Total_Scores FROM Customers GROUP BY Country ORDER BY 2 DESC;

/*
6.  Find number of customers per Country and Score
*/


SELECT Country,Score, COUNT(CustomerID) AS Total_Customers FROM Customers GROUP BY Country,Score ORDER BY 3 DESC;

/*
7.  Show only countries having more than 5 customers
*/


SELECT Country, COUNT(CustomerID) AS Total_Customers FROM Customers GROUP BY Country HAVING COUNT(CustomerID) > 5 ORDER BY 2 DESC;

/*
8.  Show countries where average score is greater than 80
*/


SELECT Country, AVG(Score) AS Average_Score FROM Customers GROUP BY Country HAVING AVG(Score) > 80 ORDER BY 2 DESC;

/*
9.  Show countries where total score is more than 500
*/

SELECT Country, SUM(Score) AS Total_Score FROM Customers GROUP BY Country HAVING SUM(Score) > 500 ORDER BY 2 DESC;


/*
10.  Show countries where maximum score is at least 95
*/

SELECT Country, MAX(Score) AS Total_Score FROM Customers GROUP BY Country HAVING MAX(Score) >= 95 ORDER BY 2 DESC;


/*
11.  For customers from India only, show countries having avg score > 70
*/

SELECT Country, AVG(Score) AS Average_Score FROM Customers where Country in ('India') GROUP BY Country order by 2 desc;

/*
12.  Show countries having more than 3 customers with score > 60
*/

SELECT Country, COUNT(1) AS Customer FROM Customers WHERE Score > 60 GROUP BY Country order by 2 desc;


/*
13.  Find countries having exactly 1 customer
*/

SELECT Country, COUNT(1) AS Customer FROM Customers  GROUP BY Country HAVING COUNT(1) = 1 order by 2 desc;


/*
14.  Find country with the highest average score
*/

SELECT TOP 1 Country, AVG(ISNULL(Score,0)) AS Average_Score FROM Customers  GROUP BY Country  order by 2 desc;

/*
15. Find countries where average score is higher than overall average score
*/

SELECT Country, AVG(Score) AS Average_Score
FROM Customers
GROUP BY Country
HAVING AVG(Score) > (
SELECT AVG(ISNULL(Score,0)) AS Overall_avg_score FROM Customers
)
ORDER BY 2 DESC;