USE DATASCIENCE;

/*
1.  Find the absolute value of Score
*/

SELECT *,ABS(Score) AS Absolute_Scores FROM Customers;

/*
2. Round the Score to the nearest whole number.
*/

SELECT *,ROUND(Score,0) AS Rounded_Score FROM Customers;

/*
3.  Round Score to 2 decimal places
*/

SELECT *,ROUND(Score,2) AS Rounded_decimal_score FROM Customers;

/*
4. Remove decimal values from Score.
*/

SELECT *,FLOOR(Score) AS Scores FROM Customers;


SELECT FLOOR(123.456) AS Number;------Lower number


SELECT CEILING(123.456) AS Number;------high number

/*
5. Round the score to the higher number
*/

SELECT *,CEILING([Score]) AS Higher FROM Customers;

/*
6.  Display Score raised to power 2
*/

SELECT *,POWER([Score],2) AS Advance_Power FROM Customers;

/*
7.  Find square root of Score
*/

SELECT *,SQRT([Score]) AS Squarerootscore FROM Customers;

/*
8.  Convert Score into integer
*/

SELECT *,CONVERT(INT,Score) AS Scores FROM Customers;

/*
9.  Generate random score for each customer
*/

SELECT *,RAND(CHECKSUM(NEWID()))*10.0 AS Rnadomscore FROM Customers;

/*
10.  Find maximum Score
*/

SELECT MAX(Score) as maximum FROM Customers;

/*
10.  Find minimum Score
*/

SELECT MIN(Score) as minimum FROM Customers;

/*
11.  Calculate average Score
*/

SELECT AVG([Score]) AS Average_Score FROM Customers;

/*
12.  Total Score of all customers
*/

SELECT SUM([Score]) AS Total_Score FROM Customers;

/*
13. Count customers having Score
*/

SELECT COUNT(CustomerID) AS Customer FROM Customers WHERE Score != 0;

/*
14.  Increase Score by 10%
*/

SELECT *,(Score + (Score * (0.1))) AS newscores FROM Customers;

/*
15.  Display Score difference from average
*/

SELECT *,Score - (SELECT AVG([Score]) FROM Customers) AS Newvalue FROM Customers;

/*
16. Show customers with Score rounded & ranked
*/

SELECT *,ROUND([Score],0) AS Rounded_Score,
DENSE_RANK()OVER(ORDER BY Score DESC) AS Rnk FROM Customers;

/*

17.  Handle NULL Score safely

*/

SELECT *,ISNULL(Score,0) AS Scores FROM Customers;