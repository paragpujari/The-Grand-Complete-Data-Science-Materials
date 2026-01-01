USE DATASCIENCE;

/*
1. Rank customers by Score ascending  within each Country
*/

SELECT *,DENSE_RANK()OVER(PARTITION BY Country ORDER BY Score) AS Ranks FROM Customers;


/*
2. Rank customers by Score descending  within each Country
*/

SELECT *,DENSE_RANK()OVER(PARTITION BY Country ORDER BY Score DESC) AS Dense_Ranks FROM Customers;


/*
3. Find top 2 customers by Score in each Country
*/

;with cte as(
SELECT *,ROW_NUMBER()OVER(PARTITION BY Country ORDER BY Score DESC) AS Row FROM Customers
)
SELECT * FROM cte where Row <= 2 order by Score desc;


/*OR*/

;with cte as(
SELECT *,DENSE_RANK() OVER(PARTITION BY Country ORDER BY Score DESC) AS Ranks FROM Customers
)
SELECT * FROM cte WHERE Ranks <= 2 ORDER BY Score desc;


/*
3. Assign row number to orders per customer ordered by OrderDate
*/

;with cte as(
SELECT *,ROW_NUMBER()OVER(PARTITION BY CustomerID ORDER BY OrderDate) as Rwn FROM Orders
)
SELECT * FROM cte;


/*
4.  Find latest order for each customer
*/

;with cte as(
SELECT *,ROW_NUMBER()OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC) AS Rows FROM Orders
)
select * from cte WHERE Rows = 1;


/*
5.  Calculate running total of Sales per Customer
*/

;with cte as(
SELECT *,SUM([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Total_Sales FROM Orders
)
SELECT * FROM cte ORDER BY OrderDate;

/*
6.  Calculate cumulative Sales across all orders
*/

;with cte as(
SELECT *,SUM([Sales])OVER(ORDER BY OrderDate) AS CumSales FROM Orders
)
SELECT * FROM cte ORDER BY OrderDate;

/*
7. Find previous order Sales for each customer
*/

SELECT *,CustomerID,Sales,LAG([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Previous_Sales FROM Orders
ORDER BY 3;


/*
8. Find next order Sales for each customer
*/


SELECT *,CustomerID,Sales,LEAD([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Previous_Sales FROM Orders
ORDER BY 3;

/*
9.  Find Sales difference between current and previous order
*/

;with cte as(
SELECT *,LAG([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Previous_Sales FROM Orders
)
SELECT *,(Sales - ISNULL(Previous_Sales,0)) AS Sales_Difference FROM cte;


/*
10. Rank orders by Sales per Product
*/

;with cte as(
SELECT *,DENSE_RANK()OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Ranks FROM Orders
)
SELECT * FROM cte;

/*
11. Find highest Sales order per Product
*/

;with cte as(
SELECT *,RANK()OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Ranks FROM Orders
)
SELECT * FROM cte WHERE Ranks = 1;

/*
12. Calculate average Sales per customer using window function
*/

;with cte as(
SELECT *,AVG([Sales])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Average_Sales FROM Orders
)
SELECT * FROM cte;

/*
13. Find customers whose order Sales is above their average Sales
*/

SELECT * FROM Orders where Sales > (
SELECT AVG([Sales]) FROM Orders
)ORDER BY OrderDate;



/* 
14.  Count total orders per customer
*/

;with cte as(
SELECT COUNT([OrderID])OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS Rwn,* FROM Orders
)
SELECT  * FROM cte;


/*
15. Identify duplicate Sales values per Product
*/

;with cte as(
SELECT ROW_NUMBER()OVER(PARTITION BY ProductID,Sales ORDER BY OrderDate) as Rwn,* FROM Orders
)
SELECT * FROM cte;


