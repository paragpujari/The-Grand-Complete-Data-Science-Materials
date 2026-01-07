/*
  Write a stored procedure to get the customer order details based on a given date range

                          SELECT 
			              a.CustomerID                                         ,
			              a.FirstName                                          ,
			              a.LastName                                           ,
			              a.Country                                            ,
			              a.Score                                              ,
			              b.OrderDate                                          ,
			              b.Sales
			              FROM Customers a
			              JOIN          Orders    b
			              ON            a.CustomerID = b.CustomerID
			              WHERE         b.OrderDate >= '2025-01-01'   
			              AND           b.OrderDate <= '2025-12-31'
						  ORDER BY b.OrderDate;

*/
--EXEC [DBO].[Get_Customer_Order_Details]'2025-01-01', '2025-12-31'
CREATE OR ALTER PROCEDURE [DBO].[Get_Customer_Order_Details]
(
       @FromDate    DATETIME              ,
	   @ToDate      DATETIME
)
 AS
    BEGIN
	     SET   NOCOUNT ON;

		 BEGIN TRANSACTION;


		      BEGIN    TRY

			  /*----------------Define the SQL Variables-----------------*/
			  DECLARE @SQL   NVARCHAR(MAX);

			  /*---------------Set the Dynamic SQL Statement----------------*/
			  SET     @SQL = N'
			              SELECT 
			              a.CustomerID                                         ,
			              a.FirstName                                          ,
			              a.LastName                                           ,
			              a.Country                                            ,
			              a.Score                                              ,
			              b.OrderDate                                          ,
			              b.Sales
			              FROM Customers a
			              JOIN          Orders    b
			              ON            a.CustomerID = b.CustomerID
			              WHERE         b.OrderDate >= @FromDateparam   
			              AND           b.OrderDate <= @ToDateparam
						  ORDER BY b.OrderDate;
			  ';

			/*-------------Execute the Dynamic SQL Statement---------------------*/
			EXEC sp_executesql
			@SQL                                                      ,
			N'@FromDateparam                         DATETIME         ,
			  @ToDateparam                           DATETIME'        ,
			  @FromDateparam     =           @FromDate                ,
			  @ToDateparam       =           @ToDate

		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
	    THROW;
		SELECT ERROR_LINE();
		SELECT ERROR_MESSAGE();
	END   CATCH



	END