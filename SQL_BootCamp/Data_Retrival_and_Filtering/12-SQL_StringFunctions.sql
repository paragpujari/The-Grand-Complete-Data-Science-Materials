USE DATASCIENCE;

--------------------------------------------String Functions------------------------------------------------
/*
1.  Display customer full name in a single column
*/

SELECT *,CONCAT(FirstName,' ',LastName) AS FullName FROM Customers;

/*
2.  Convert all customer first names to UPPERCASE
*/

SELECT *,UPPER(FirstName) AS First_Names FROM Customers;

/*
3.  Convert last names to lowercase
*/

SELECT *,LOWER(LastName) AS Last_Name FROM Customers;

/*
4.  Find length of each customer’s first name
*/

SELECT *,LEN(FirstName) AS len_firstname FROM Customers;

/*
5. Get first 3 characters of the customer’s country
*/

SELECT *,LEFT(Country,3) AS Countrynewleft FROM Customers;

/*
6.  Get last 2 characters of the country name
*/

SELECT *,RIGHT(Country,2) AS Countrynewright FROM Customers;

/*
7.  Extract middle part of the first name (from 2nd position, 3 characters)
*/

SELECT *,SUBSTRING(FirstName,2,3) as middlename FROM Customers;

/*
8.  Remove leading and trailing spaces from country names
*/

SELECT *,LTRIM(RTRIM(Country)) AS Trimmedcountry FROM Customers;

/*
9.  Find customers whose first name starts with 'A'
*/

SELECT * FROM Customers WHERE FirstName LIKE 'A%';

/*
10. Find customers whose last name ends with 'son'
*/

SELECT * FROM Customers WHERE LastName LIKE '%son';

/*
11. Find customers whose country name contains 'land'
*/

SELECT * FROM Customers WHERE Country LIKE '%land%';

/*
12.  Replace 'USA' with 'United States' in Country column
*/

SELECT *,REPLACE(Country,'USA','United States') AS Replaced_Country FROM Customers;

/*
13.  Find position of letter 'a' in first name
*/

SELECT *,CHARINDEX('a',FirstName) as indexedpos FROM Customers;

/*
14.  Find position of letter 'e' in last name
*/

SELECT *,CHARINDEX('e',LastName) as indexposlast FROM Customers;

/*
15.  Display initials of customer (First letter of FirstName + LastName)
*/

SELECT CustomerID, LEFT(FirstName,1), LEFT(LastName,1), CONCAT(LEFT(FirstName,1) , ' ',LEFT(LastName,1)) AS Initials FROM Customers;

/*
16.  Create a username

(First 3 letters of FirstName + CustomerID)
*/

SELECT *,CONCAT(LEFT(FirstName,3),'',CustomerID) AS username FROM Customers;

/*
17.  Find customers whose full name length > 10
*/

;with cte as(
SELECT *,CONCAT(FirstName,LastName) as Full_name FROM Customers
),cte1 as(
SELECT *,LEN(Full_name) as length FROM cte
)
SELECT * FROM cte1 where length > 10;

/*
18.  Show customers with country name in uppercase only if score > 80
*/

SELECT CustomerID,FirstName,LastName,UPPER(Country) AS Countryupper FROM Customers where Score > 80 ORDER BY Score;

