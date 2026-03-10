-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<SP to update a product price>
-- =============================================
CREATE PROCEDURE usp_ProductsPrice_Update 
	@IdProduct INT
	,@Price DECIMAL(18,2)
AS
BEGIN
	
	IF NOT EXISTS(SELECT 1 FROM Products WHERE IdProduct=@IdProduct)
	BEGIN
		RAISERROR('Product does not exist',16,104)
		RETURN
	END

	IF EXISTS(SELECT 1 FROM Products WHERE IdProduct=@IdProduct AND DeleteDate IS NOT NULL)
	BEGIN
		RAISERROR('Product was removed',16,104)
		RETURN
	END

	SET NOCOUNT ON;
	BEGIN TRY

		BEGIN TRANSACTION

		DECLARE @Now DATETIME=GETDATE()

		--REMOVE LAST PRICE
		UPDATE ProductPrices
			SET DeleteDate=@Now
		WHERE IdProduct=@IdProduct
		AND DeleteDate IS NULL

		--CREATE NEW PRICE
		INSERT INTO ProductPrices(
			IdProduct
			,Price
			,CreateDate
			,UpdateDate
		)
		VALUES(
			@IdProduct
			,@Price
			,@Now
			,@Now
		)

		SELECT @IdProduct Id
		,'Price updated' Message

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION

		DECLARE @Error VARCHAR(MAX)=(SELECT ERROR_MESSAGE())

		RAISERROR(@Error,16,104)

	END CATCH
	

	SET NOCOUNT ON;

END
