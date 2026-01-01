USE DATASCIENCE;


/*
1.  Customers who have never placed an order
*/

;with cte as(
SELECT 
a.CustomerID                  ,
a.FirstName					  ,
a.LastName					  ,
a.Country					  ,
a.Score						  ,
a.CreatedDate				  ,
b.OrderID					  ,
b.ProductID					  ,
b.SalesPersonID				  ,
b.OrderDate					  ,
b.ShipDate					  ,
b.OrderStatus				  ,
b.ShipAddress				  ,
b.BillAddress				  ,
b.Quantity					  ,
b.Sales						  ,
b.CreationTime
FROM Customers a
LEFT JOIN     Orders    b
ON            a.CustomerID  = b.CustomerID
WHERE         b.OrderID   IS  NULL
)
SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
FROM cte;



/*
2.  Total Sales per Customer
*/

;with cte as(
SELECT CustomerID,SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID
)
SELECT * FROM cte;


/*
3.  Customers whose total Sales > 300
*/

;with cte as(
SELECT CustomerID, SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID
HAVING SUM([Sales]) > 300
)
SELECT * FROM cte;


/*
4. Join Customers with their total Sales
*/

;with cte as(
SELECT a.*                ,
b.OrderID                 ,
b.ProductID				  ,
b.SalesPersonID			  ,
b.OrderDate				  ,
b.ShipDate				  ,
b.OrderStatus			  ,
b.ShipAddress			  ,
b.BillAddress			  ,
b.Quantity				  ,
b.Sales					  ,
b.CreationTime
FROM Customers a
INNER JOIN    Orders    b
ON            a.CustomerID = b.CustomerID
)
SELECT CustomerID, SUM([Sales]) AS Total_Sales
FROM cte
GROUP BY CustomerID;


/*
5.  Find top-spending customer
*/

;with cte1 as(
SELECT CustomerID, SUM([Sales]) AS Total_Sales
FROM Orders
GROUP BY CustomerID
),cte2 as(
SELECT *,DENSE_RANK()OVER(ORDER BY Total_Sales DESC) AS Ranks FROM cte1
)
SELECT * FROM cte2;


/*
6.  Orders placed in 2025
*/

;with cte as(
SELECT *,YEAR([OrderDate]) AS years FROM Orders
)
SELECT * FROM cte WHERE years = '2025'; 


/*
7. Monthly Sales trend
*/

;with cte as(
SELECT YEAR(OrderDate) AS years, MONTH(OrderDate) AS Months, *
FROM Orders

)
SELECT years,Months, SUM([Sales]) AS Total_Sales
FROM cte
GROUP BY years,Months;


/*
8. Customers with more than 2 orders
*/

;with cte1 as(
SELECT CustomerID,COUNT([OrderID]) AS Total_Orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT([OrderID]) > 1
)
SELECT * FROM cte1;

/*
9.  First and last order date per customer
*/

;with cte as(
SELECT CustomerID,MIN([OrderDate]) as mindate, MAX([OrderDate]) as maxdate
FROM Orders
GROUP BY CustomerID
)
SELECT * FROM cte;


/*
10.  Customers who placed orders but have NULL shipping address
*/

;with cte1 as(
SELECT CustomerID FROM Orders WHERE ShipAddress IS NULL GROUP BY CustomerID
)
SELECT * FROM cte1;