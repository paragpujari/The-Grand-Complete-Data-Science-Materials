USE DATASCIENCE;

/*
  1.  Find customers whose Score is greater than the average score of all customers.
*/

SELECT * FROM Customers WHERE Score > (
SELECT AVG(Score) AS Average_Score FROM Customers
) order by Score;

/*
2. Find customers who have the maximum score.
*/

SELECT * FROM Customers WHERE Score IN (
SELECT MAX([Score]) AS Maximum_Score FROM Customers
)ORDER BY Score;

/*
3. Find orders where Sales is greater than the average sales across all orders.
*/
SELECT * FROM Orders WHERE Sales > (
SELECT AVG([Sales]) AS Average_Sales FROM Orders
)
ORDER BY OrderDate


/*
4. Display each customer with the total number of orders (scalar subquery in SELECT)
*/

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT CustomerID, COUNT([OrderID]) AS Total_Orders
FROM Orders
GROUP BY CustomerID
)
SELECT 
a.CustomerID                                             ,
a.FirstName                                              ,
a.LastName                                               ,
CONCAT(a.FirstName, ' ', a.LastName)  AS  FullName       ,
a.Country                                                ,
a.Score                                                  ,
a.CreatedDate                                            ,
b.Total_Orders
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID



/*
5. Find customers who placed more than 1 order
*/

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT CustomerID, COUNT([OrderID]) AS Total_Orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT([OrderID]) > 1
)
SELECT 
a.CustomerID                                             ,
a.FirstName                                              ,
a.LastName                                               ,
CONCAT(a.FirstName, ' ', a.LastName)  AS  FullName       ,
a.Country                                                ,
a.Score                                                  ,
a.CreatedDate                                            ,
b.Total_Orders
FROM          cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY a.CreatedDate

/*
6. Find customers whose total sales are greater than 50
*/

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT CustomerID,SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID
HAVING SUM([Sales]) > 50
)
SELECT 
a.CustomerID                                             ,
a.FirstName                                              ,
a.LastName                                               ,
CONCAT(a.FirstName, ' ', a.LastName)  AS  FullName       ,
a.Country                                                ,
a.Score                                                  ,
a.CreatedDate                                            ,
b.Total_Sales
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY a.CreatedDate;


/*
7.  Find orders where Sales is greater than the average sales of that customer.
*/

SELECT * FROM Orders WHERE Sales > (
SELECT AVG([Sales]) AS Average_Sales FROM Orders
)
ORDER BY OrderDate;


/*
8.  Find customers who ordered products ordered by USA customers
*/

;with cte1 as(
SELECT * FROM Customers WHERE Country = 'USA'
),cte2 as(
SELECT * FROM Orders
)
SELECT 
a.CustomerID                                             ,
a.FirstName                                              ,
a.LastName                                               ,
CONCAT(a.FirstName, ' ', a.LastName)  AS  FullName       ,
a.Country                                                ,
a.Score                                                  ,
a.CreatedDate                                            ,
b.OrderID                                                ,
b.OrderDate                                              ,
b.OrderStatus
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY b.OrderDate;


/*

9.  Find customers whose score is greater than the average score of German customers.

*/

SELECT * FROM Customers WHERE Score > (
SELECT AVG([Score]) AS Average_Score FROM Customers WHERE Country = 'Germany'
)ORDER BY CreatedDate;

/*

10.  Find customers who have placed at least one order

*/

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT CustomerID, COUNT([OrderID]) AS Total_Orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT([OrderID]) >= 1
)
SELECT * FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER  BY    a.CreatedDate;


/*
11. Find customers who have never placed an order
*/

;with cte1 as(
SELECT * FROM Customers
),cte2 as(
SELECT CustomerID,COUNT([OrderID]) AS Total_Orders
FROM Orders
GROUP BY CustomerID
)
SELECT * FROM cte1 a
LEFT JOIN     cte2 b
ON            a.CustomerID = b.CustomerID
WHERE         b.CustomerID IS NULL
ORDER  BY     a.CreatedDate;


/*
12.  Find orders placed by customers from India using EXISTS
*/

SELECT * FROM Orders WHERE EXISTS(
SELECT * FROM Customers WHERE Country = 'India'
)ORDER BY OrderDate;


/*
13. Find customers who placed an order with Sales greater than 50
*/

SELECT * FROM Customers WHERE EXISTS(
SELECT * FROM Orders WHERE Sales > 50
)
ORDER BY CreatedDate;

/*
14. Get all countries from Customers and Orders billing addresses (UNION removes duplicates).
*/

SELECT Country FROM Customers
UNION
SELECT BillAddress FROM Orders
ORDER BY 1;


/*
15. Get all customer IDs from Orders and Customers including duplicates (UNION ALL)
*/

SELECT CustomerID FROM Orders
UNION ALL
SELECT CustomerID FROM Customers
ORDER BY 1;


/*
16. Find customers who exist in both Customers table and Orders table (INTERSECT)
*/

SELECT CustomerID FROM Customers
INTERSECT
SELECT CustomerID FROM Orders
ORDER BY 1;

/*
17. Find customers who exist in Customers table but have never placed orders (EXCEPT)
*/

SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM Orders
ORDER BY 1;


/*
18. Find customers from India OR USA using UNION
*/

SELECT CustomerID,FirstName,LastName,CONCAT(FirstName,' ',LastName) AS FullName, Country FROM Customers WHERE Country = 'India'
UNION
SELECT CustomerID,FirstName,LastName,CONCAT(FirstName,' ',LastName) AS FullName, Country FROM Customers WHERE Country = 'USA'
ORDER BY 1;

