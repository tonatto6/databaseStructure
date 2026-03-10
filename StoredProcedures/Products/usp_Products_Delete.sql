-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<SP to delete a product>
-- =============================================
CREATE PROCEDURE usp_Products_Delete 
	@IdProduct INT
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

		--REMOVE PRICE
		UPDATE ProductPrices
			SET DeleteDate=@Now
		WHERE IdProduct=@IdProduct
		AND DeleteDate IS NULL

		--REMOVE PRODUCT
		UPDATE Products
			SET DeleteDate=@Now
		WHERE IdProduct=@IdProduct

		COMMIT TRANSACTION

		SELECT @IdProduct Id
		,'Product was removed' Message

	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION
		
		DECLARE @Error VARCHAR(MAX)=(SELECT ERROR_MESSAGE())

		RAISERROR(@Error,16,104)

	END CATCH


    SET NOCOUNT OFF;

END
