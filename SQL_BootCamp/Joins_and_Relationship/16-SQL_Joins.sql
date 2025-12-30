USE DATASCIENCE;

SELECT * FROM Customers;

SELECT * FROM Orders;

/*
1.  find customers who have placed orders.
*/

;with cte as(
SELECT a.CustomerID,CONCAT(a.FirstName,' ', a.LastName) AS FullName, b.OrderID, b.OrderStatus 
FROM Customers a
INNER JOIN    Orders    b
ON            a.CustomerID = b.CustomerID
)
SELECT FullName FROM cte
GROUP BY FullName;

/*

2.  List all customers and their orders (if any)

*/

SELECT CONCAT(a.FirstName, ' ', a.LastName) AS FullName, a.CreatedDate, b.OrderID, b.OrderStatus , b.OrderDate
FROM Customers a
LEFT JOIN     Orders    b
ON            a.CustomerID = b.CustomerID
ORDER BY a.CustomerID

/*
3. List all the Customers that do have have ordered any product
*/

SELECT 
b.CustomerID                                                      ,
CONCAT(b.FirstName, ' ', b.LastName)   AS  FullName               ,
b.Country                                                         ,
b.Score                                                           ,
b.CreatedDate                                                     ,
a.OrderID
FROM Orders                                         a
RIGHT JOIN    Customers                             b
ON            a.CustomerID = b.CustomerID
WHERE         a.OrderID IS NULL
ORDER BY      b.CreatedDate;

/*
4.  List all customers and all orders, matched where possible
*/

SELECT 
a.CustomerID                                                      ,
CONCAT(a.FirstName, ' ', a.LastName)      AS   FullName           ,
a.Country                                                         ,
a.Score                                                           ,
b.OrderID                                                         ,
b.OrderStatus                                                     ,
b.OrderDate
FROM Customers a
FULL OUTER JOIN  Orders b
ON               a.CustomerID = b.CustomerID
ORDER BY b.OrderDate

/*
5.  Find customers from the same country with different names
*/

;with cte1 as(
SELECT *,CONCAT(FirstName, ' ',LastName) AS FullName
FROM Customers
),cte2 as(
SELECT *,CONCAT(FirstName, ' ',LastName) AS FullName
FROM Customers
)
SELECT 
a.Country                                            ,
a.CustomerID                                         ,
b.CustomerID                                         ,
a.FullName                                           ,
b.FullName
FROM  cte1 a
JOIN           cte2 b
ON             a.Country = b.Country
AND            a.CustomerID <> b.CustomerID
ORDER BY       a.CreatedDate;


/*

6.  Generate all possible customer–orders combinations.

*/

SELECT * FROM Customers a
CROSS JOIN    Orders    b;

/*
7.  Find customers whose score is higher than the average score
*/

SELECT * FROM Customers WHERE Score > (
SELECT AVG([Score]) AS Average_Score FROM Customers
)ORDER BY Score DESC;


/*
 8.  Find USA customers who placed an order

 */

;with cte1 as(
 SELECT * FROM Customers  where Country = 'USA'
),cte2 as(
 SELECT * FROM Orders
)
SELECT 
a.CustomerID                                                         ,
a.FirstName                                                          ,
a.LastName                                                           ,
a.Country                                                            ,
CONCAT(a.FirstName, ' ',a.LastName)  AS FullName                     ,
b.OrderID
FROM cte1 a
JOIN          cte2 b
ON            a.CustomerID = b.CustomerID
ORDER BY b.OrderDate


/*
9. Find customers who never placed any order
*/

SELECT 
a.CustomerID                                                        ,
a.FirstName                                                         ,
a.LastName                                                          ,
CONCAT(a.FirstName, ' ', a.LastName)   AS   FullName                ,
b.OrderID
FROM Customers a
LEFT JOIN     Orders    b
ON            a.CustomerID = b.CustomerID
WHERE         b.OrderID IS NULL
ORDER BY a.CreatedDate;


/*
10.  Find highest sales per country
*/

SELECT a.Country,MAX(b.Sales) AS Highest_Sales
FROM Customers a
INNER JOIN    Orders    b
ON            a.CustomerID = b.CustomerID
GROUP BY a.Country
ORDER BY 2 DESC;

