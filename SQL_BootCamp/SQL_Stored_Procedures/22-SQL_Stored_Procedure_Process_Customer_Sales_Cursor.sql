/*
Write a stored procedure that performs the Customer Sales details using Cursors

--CustomerID
--TotalOrders 
--TotalSales 
--CustomerCategory 


EXEC [DBO].[Perform_Sales_Details_using_cursor]

TRUNCATE TABLE Customer_Sales_Summary;


SELECT * FROM Customer_Sales_Summary;


*/

CREATE OR ALTER PROCEDURE [DBO].[Perform_Sales_Details_using_cursor]
AS
   BEGIN
        SET  NOCOUNT ON;
			   /*------------------Declare the Variables------------------------------*/
			   DECLARE  @CustomerID         INT          ;
			   DECLARE  @TotalOrders        INT          ;
			   DECLARE  @TotalSales         INT          ;
			   DECLARE  @CustomerCategory   NVARCHAR(30) ;

			   

			   /*-----------------Declare the cursor for the customer details-------------*/
			   DECLARE Sales_customer_data_customer CURSOR
			   FOR
			   SELECT CustomerID FROM Customers

			   /*-----------------Open the cursor----------------------------------------*/
			   OPEN Sales_customer_data_customer;

			   /*-----------------Fetch the first record from the customer---------------*/
			   FETCH NEXT FROM Sales_customer_data_customer  INTO @CustomerID

			   /*-----------------If the fetch operation is successful-------------------*/
			   WHILE(@@FETCH_STATUS = 0)
			      BEGIN
				      /*------------Calculate the KPI of the orders from the tables---------------------*/
					  SELECT @TotalOrders = COUNT(1) FROM Orders WHERE CustomerID = @CustomerID;

					  SELECT @TotalSales  = SUM(ISNULL([Sales],0))  FROM Orders   WHERE CustomerID = @CustomerID;

					  IF(@TotalSales >= 500)
					     BEGIN
						    SET   @CustomerCategory = 'Premium'
						 END
					  ELSE
					     BEGIN
						    SET   @CustomerCategory = 'Standard'
						 END						

						 

						/*------------Insert all the KPI details into the table---------------------------------*/
						INSERT INTO Customer_Sales_Summary(
                                    CustomerID                             ,
                                    TotalOrders							   ,
                                    TotalSales							   ,
                                    CustomerCategory
						)VALUES(
						            @CustomerID                            ,
									@TotalOrders     					   ,
									@TotalSales      					   ,
									@CustomerCategory
						)

					/*------------Fetch the next record from the cursor------------------------------------------*/
					FETCH NEXT FROM Sales_customer_data_customer INTO @CustomerID;

				  END;

				  CLOSE Sales_customer_data_customer;
				DEALLOCATE Sales_customer_data_customer;
   END
