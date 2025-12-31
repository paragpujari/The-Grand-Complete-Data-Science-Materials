USE DATASCIENCE;

/*

1. Get all customers created today.

*/

SELECT *,CAST(GETDATE() AS DATE) AS Dates FROM Customers;


/*
2. Fetch customers added in the last 7 days
*/

----ALTER TABLE Customers ADD CreatedDate DATETIME;

----UPDATE Customers SET CreatedDate = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 15, GETDATE());


;with cte1 as(
SELECT *,GETDATE() AS PresentDate FROM Customers
),cte2 as(
SELECT *,DATEDIFF(DAY,CreatedDate,PresentDate) as Days FROM cte1
)
SELECT * FROM cte2 WHERE Days <= 7 ORDER BY CreatedDate DESC;


/*
3.  Find customers created in the current month
*/

;with cte1 as(
SELECT *,YEAR(CreatedDate) AS Years, MONTH(CreatedDate) AS Months FROM Customers
)
SELECT CustomerID, FirstName,LastName,CONCAT(FirstName,' ',LastName) AS FullName
FROM cte1 where Years = '2025' AND Months = '12';



/*

4.  Display customer name with year, month, and day separately

*/

SELECT 
CONCAT(FirstName,' ',LastName) AS FullName                          , 
YEAR(CreatedDate)              AS years                             , 
MONTH(CreatedDate)             AS months                            ,
DAY(CreatedDate)               AS day
FROM Customers;

/*

5.  Get customers created in 2024.

*/

SELECT * FROM Customers WHERE YEAR(CreatedDate) = '2024' order by CreatedDate;

/*
6.  Get customers whose account is older than 30 days
*/

;with cte1 as(
SELECT *,GETDATE() AS PresentedDate FROM Customers
)
SELECT *,DATEDIFF(DAY,CreatedDate, PresentedDate) AS Total_Days
FROM cte1
where DATEDIFF(DAY,CreatedDate, PresentedDate) > 30
order by DATEDIFF(DAY,CreatedDate, PresentedDate) desc;


/*
7.  Calculate how many days "old" each customer is
*/

;with cte1 as(
SELECT *,GETDATE() AS PresentedDate FROM Customers
)
SELECT *,DATEDIFF(DAY,CreatedDate,PresentedDate) as Days
FROM cte1
order by DATEDIFF(DAY,CreatedDate,PresentedDate) desc;

/*
8.  Fetch customers created between 2024-01-01 and 2024-12-31

*/

SELECT * FROM Customers 
WHERE CONVERT(DATE,CreatedDate) BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY CreatedDate;

/*
9.  Display CreatedDate in DD-MM-YYYY format.
*/

SELECT *,FORMAT(CreatedDate,'dd-MM-yyyy') AS Created_Date FROM Customers;

/*
10.  Show customers created in the current month using start & end dates.
*/

;with cte1 as(
SELECT * FROM Customers WHERE YEAR(CreatedDate) = '2025' AND MONTH(CreatedDate) = '12'
)
SELECT * FROM cte1 where CONVERT(DATE,CreatedDate) >= '2025-12-01' AND CONVERT(DATE,CreatedDate) <= '2025-12-31'
ORDER BY CreatedDate;


/*
11.  Find customers created on weekends
*/
;with cte1 as(
SELECT *,DATENAME(WEEKDAY,CreatedDate) as DayName FROM Customers
)
SELECT * FROM cte1 WHERE DayName IN ('Saturday','Sunday') ORDER BY CreatedDate;

/*
12.  Customers created in the last 1 hour
*/

;with cte1 as(
SELECT *,GETDATE() AS Lastonehour FROM Customers
)
SELECT *,DATEDIFF(MINUTE,CreatedDate,Lastonehour) as lastonehour 
FROM cte1
WHERE DATEDIFF(MINUTE,CreatedDate,Lastonehour) <= 60;


/*
13.  Remove time part from CreatedDate
*/

SELECT *,CONVERT(DATE,CreatedDate) as dates FROM Customers order by Createddate;


/*
14.  Count customers created each day
*/

;with cte1 as(
SELECT *,CONVERT(DATE,CreatedDate) as day1 FROM Customers
)
SELECT day1,count(1) as total_customers
FROM cte1
GROUP BY day1
order by 1;


/*
15.  Get latest 5 customers based on CreatedDate
*/

SELECT TOP 5 * FROM Customers ORDER BY CreatedDate DESC;



