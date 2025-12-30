USE DATASCIENCE;

SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM Employees;

SELECT * FROM OrdersArchive;

SELECT * FROM Products;



/*
1.  Identify Data Types of All Columns in a Table
*/

SELECT TABLE_NAME, COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME = 'Customers';

/*
2. Assume Orders.OrderDate is stored as VARCHAR. Convert it to DATE while selecting
*/

SELECT *,CONVERT(DATE,[OrderDate]) AS date FROM Orders;

/*
3.  Some rows in OrdersArchive.OrderDate have invalid date strings. Avoid query failure.Convert OrderDate into proper date
*/

SELECT *, TRY_CAST([OrderDate] AS DATE) AS Date_Orders FROM OrdersArchive;

/*
4. Find Orders Where Quantity Is Stored as VARCHAR Instead of INT
*/

SELECT * FROM [Orders] WITH (NOLOCK) WHERE CONVERT(INT,[Quantity]) IS NULL ;


SELECT * FROM [Orders] WITH (NOLOCK) WHERE TRY_CAST([Quantity] AS INT) IS NULL;


/*
5. 
Calculate Total Order Value Using Proper Numeric Data Types

Calculate total order value = Quantity × Sales.

*/

SELECT *,CONVERT(NUMERIC(18,5),[Quantity] * [Sales]) AS Total_Order_Value FROM Orders ORDER BY OrderDate;

/*
6.  Change Data Type While Creating a New Table  Create a cleaned table from OrdersArchives with correct data types
*/

SELECT * INTO OrdersArchives FROM OrdersArchive;

SELECT *,
CONVERT([date], OrderDate) AS Order_Dates,
CONVERT(INT,[Quantity])AS Quantity, 
CONVERT(NUMERIC(18,5),[Sales]) AS Sales_Price
FROM OrdersArchives;


/*
7. Convert the FirstName and LastName into varchar types
*/

SELECT *,
CONVERT(VARCHAR,FirstName) AS FirstName,
CONVERT(VARCHAR,LastName)  AS LastName
FROM Employees;

/*
8.  Find customers whose Score is NULL or empty.
*/

SELECT * FROM Customers WHERE Score IS NULL OR Score = 0.0;

/*
9.  Replace NULL BillAddress with 'Not Available'
*/


SELECT *,CASE WHEN BillAddress IS NULL THEN 'Not Available' ELSE BillAddress END AS BillAddressnew FROM Orders;

/*
10. Why does this query fail sometimes?
*/

SELECT * FROM Orders WHERE OrderID = '1001';

SELECT * FROM Orders WHERE CAST(OrderID AS INT) = '1';

/*
11. Calculate number of days since order placed.
*/

SELECT *,DATEDIFF(DAY,[OrderDate],GETDATE()) AS Days FROM Orders

/*
12.  Convert OrderDateTime to only date.
*/

SELECT *,CONVERT(DATE,[OrderDate]) AS Orderdates FROM [Orders];


/*
13.  List columns that should be numeric but are stored as strings
*/

SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Orders' AND DATA_TYPE = 'nvarchar';


/*
14.  Why should we avoid float for prices

*/

SELECT 
    0.1 + 0.2 AS FloatResult,
    CAST(0.1 + 0.2 AS DECIMAL(10,2)) AS DecimalResult;