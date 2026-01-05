--Loop through each customer and generate Order Count and Total Sales from the Orders table
--EXEC [DBO].[Generate_Order_Details_for_each_customer]
CREATE OR ALTER PROCEDURE [DBO].[Generate_Order_Details_for_each_customer]
AS
 BEGIN
     SET NOCOUNT ON;

	 BEGIN TRANSACTION;

	   BEGIN  TRY

	   /*-----------------Loop through each customer and print the details-------------------------*/
	   DECLARE   @MinCustomerID INT;
	   DECLARE   @MaxCustomerID INT;

	   DECLARE   @TotalCustOrders INT;
	   DECLARE   @TotalSalesNum   INT;

	   SELECT    @MinCustomerID = MIN([CustomerID]) FROM Customers;
	 --  SELECT    @MinCustomerID AS MinCustomerID;

	   SELECT    @MaxCustomerID = MAX([CustomerID]) FROM Customers;
	--   SELECT    @MaxCustomerID AS MaxCustomerID;

	   WHILE(@MinCustomerID <= @MaxCustomerID)
	     BEGIN
		    PRINT CONCAT('Customer ID is:', @MinCustomerID);

			/*-----------Get the total count and total sales for each customer--------------------------*/
			SELECT @TotalCustOrders = COUNT(1) FROM Orders WHERE CustomerID = @MinCustomerID;
			SELECT @TotalSalesNum   = SUM([Sales]) FROM Orders WHERE CustomerID = @MinCustomerID;

			/*------------Print the sales details for each customer-------------------------------------*/
		    PRINT CONCAT(
			'Customer ID   :',  @MinCustomerID                       ,
			'Total Orders  :',  @TotalCustOrders                     ,
			'Total Sales   :',  @TotalSalesNum
			);

		    SET @MinCustomerID = @MinCustomerID + 1
		 END

	COMMIT TRANSACTION;
 END TRY

 BEGIN CATCH
    ROLLBACK TRANSACTION;
	SELECT ERROR_LINE();
	SELECT ERROR_MESSAGE();
	SELECT ERROR_NUMBER();
 END CATCH
 END