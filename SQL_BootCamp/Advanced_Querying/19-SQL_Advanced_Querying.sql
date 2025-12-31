USE DATASCIENCE;

/*
1. Find customers whose Score is above the average score
*/

SELECT * FROM Customers WHERE Score > (
SELECT AVG([Score]) AS Average_Score FROM Customers
)
ORDER BY CreatedDate;

/*
2. Show total sales per customer using a CTE
*/
;with cte as(
SELECT 
CustomerID,SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID
)
SELECT * FROM cte;

/*
3. List customers who placed more than 1 order
*/

;with cte as(
SELECT CustomerID, COUNT([OrderID]) AS Total_Orders FROM Orders GROUP BY CustomerID HAVING COUNT([OrderID]) > 1
)
SELECT * FROM cte;

/*
4. Generate numbers from 1 to 10 using Recursive CTE
*/

;WITH cte AS(
 -------Define a base case
    SELECT 1 AS num
	UNION ALL
 -------Define the recursive case
    SELECT num + 1
	FROM cte
	WHERE num < 10

)
SELECT * FROM cte;

/*
5. Generate order-wise running days starting from OrderDate
*/

;with orderdays as(
SELECT OrderID, OrderDate, 1 AS OrderDateNum
FROM Orders
UNION ALL
SELECT OrderID, OrderDate, OrderDateNum + 1
FROM
orderdays
WHERE OrderDateNum < 10
)
SELECT * FROM orderdays
order by OrderID, OrderDate;


/*
6.  Display each customer with average score of their country
*/

SELECT CustomerID, FirstName, LastName,CONCAT(FirstName, ' ', LastName) AS FullName, Country,
AVG([Score])OVER(PARTITION BY Country ORDER BY CreatedDate) AS Average_Score
FROM Customers
ORDER BY CreatedDate;

/*
7. Show total sales per Customer with total sales of all orders
*/

SELECT *,SUM([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Total_Sales,
SUM([Sales])over() AS Total_Sales_All_Orders
FROM Orders
ORDER BY OrderDate;

/*
8.  Calculate running total of sales by OrderDate in CustomerWise
*/

SELECT *,SUM([Sales])OVER(PARTITION BY CustomerID order by OrderDate) AS Total_Sales
FROM Orders
ORDER BY OrderDate;

/*
9.  Show maximum score per country
*/

SELECT *,MAX([Score])OVER(PARTITION BY Country) AS Maximum_Scores
FROM Customers
ORDER BY Country;

/*
10.  Assign row number to customers ordered by Score
*/
SELECT ROW_NUMBER()OVER(ORDER BY Score)AS Rowno,* FROM Customers ORDER BY CreatedDate;


/*
11.  Rank customers by Score (ties allowed)
*/

SELECT *,RANK()OVER(ORDER BY Score) as Ranks FROM Customers;


/*
12. Dense rank customers by Score
*/

SELECT *,DENSE_RANK()OVER(ORDER BY Score) AS Dense_Ranks FROM Customers;


/*
13.  Find top 3 customers by score
*/

;with cte as(
SELECT *,DENSE_RANK()OVER(ORDER BY Score DESC) AS Ranks FROM Customers
)
SELECT * FROM cte where Ranks <= 3 order by Score desc;


/*
14. Show previous order’s sales
*/

SELECT *,Sales,LAG([Sales])OVER(ORDER BY OrderDate) AS Previous_Sales
FROM Orders
ORDER BY OrderDate;

/*
15. Find difference between current and previous order sales
*/

;with cte as(
SELECT *,Sales as Current_Sales, ISNULL(LAG([Sales])OVER(ORDER BY OrderDate),0) AS Previous_Sales FROM Orders
)
SELECT *,(Current_Sales - Previous_Sales) AS Sales_Difference
FROM cte;

/*
16.  Show next order’s sales
*/

;with cte as(
SELECT *,[Sales] AS Current_Sales, ISNULL(LEAD([Sales])OVER(ORDER BY OrderDate),0) AS Next_Sales FROM Orders
)
SELECT * FROM cte;

/*
17.  Divide customers into 4 performance buckets based on Score
*/

;with cte as(
SELECT *,NTILE(4)OVER(ORDER BY Score) as buckets FROM Customers
)
SELECT * FROM cte;

/*
18.  Identify top 25% customers
*/
;with cte as(
SELECT *,NTILE(4)OVER(ORDER BY Score) AS buckets FROM Customers
)
SELECT * FROM cte where buckets = 1;

/*
19.  Find highest order sales per customer
*/
;with cte as(
SELECT *,ROW_NUMBER()OVER(PARTITION BY CustomerID ORDER BY Sales DESC) as row FROM Orders
)
SELECT * FROM cte where row = 1;

/*
20.  Find latest order per customer
*/

;with cte as(
SELECT *,ROW_NUMBER()OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC) AS Row FROM Orders
)
SELECT * FROM cte where Row = 1;