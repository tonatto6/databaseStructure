-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<SP To creat a new order>
-- =============================================
CREATE PROCEDURE usp_Orders_Insert 
	@Name VARCHAR(100)
	,@Products NVARCHAR(MAX)
	,@Observation VARCHAR(1000)=NULL
AS
BEGIN
	
	DECLARE @ProductsTable TABLE
	(
		IdProduct INT
	)

	INSERT INTO @ProductsTable
	SELECT *
	FROM OPENJSON(@Products)
	WITH (
		IdProduct INT
	)

	IF EXISTS(SELECT 1 FROM Products P
						RIGHT JOIN @ProductsTable T ON T.IdProduct=P.IdProduct AND P.DeleteDate IS NULL
						WHERE P.IdProduct IS NULL)
	BEGIN
		RAISERROR('Product does not exist',16,104)
		RETURN
	END

	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION

			DECLARE @Now DATETIME=GETDATE()

			DECLARE @TotalPrice DECIMAL(18,2)=(SELECT SUM(P.Price) FROM @ProductsTable T 
														INNER JOIN ProductPrices P ON P.IdProduct=T.IdProduct AND P.DeleteDate IS NULL)

			--CREATE ORDER
			INSERT INTO Orders(
				IdOrderState
				,Name
				,Observation
				,Price
				,CreateDate
				,UpdateDate
			)
			VALUES(
				1 -- DEFAULT
				,@Name
				,@Observation
				,@TotalPrice
				,@Now
				,@Now
			)

			DECLARE @IdOrder INT = (SELECT SCOPE_IDENTITY())

			--INSERT PRODUCTS FOR ORDER
			INSERT INTO OrderProducts(
				IdOrder
				,IdProduct
				,Price
				,CreateDate
				,UpdateDate
			)
			SELECT @IdOrder
			,T.IdProduct
			,P.Price
			,@Now
			,@Now
			FROM @ProductsTable T
			INNER JOIN ProductPrices P ON P.IdProduct=T.IdProduct AND P.DeleteDate IS NULL

			SELECT @IdOrder Id
			,'Order created' Message

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION

		DECLARE @Error VARCHAR(MAX)=(SELECT ERROR_MESSAGE())

		RAISERROR(@Error,16,104) 

	END CATCH
    SET NOCOUNT OFF;

END
