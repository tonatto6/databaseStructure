-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<SP to insert a new product>
-- =============================================
CREATE PROCEDURE usp_Products_Insert 
	@IdProductType TINYINT
	,@Description VARCHAR(50)
	,@Price DECIMAL(18,2)
AS
BEGIN
	
	IF NOT EXISTS(SELECT 1 FROM ProductsTypes WHERE IdProductType=@IdProductType)
	BEGIN
		RAISERROR('Product type does not exist',16,104)
		RETURN
	END

	IF NOT EXISTS(SELECT 1 FROM ProductsTypes WHERE IdProductType=@IdProductType AND DeleteDate IS NULL)
	BEGIN
		RAISERROR('Product type does was removed',16,104)
		RETURN
	END

	IF EXISTS(SELECT 1 FROM ProductsTypes WHERE IdProductType=@IdProductType AND Description=@Description AND DeleteDate IS NULL)
	BEGIN
		RAISERROR('Alredy exist this product',16,104)
		RETURN
	END

	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @Now DATETIME=GETDATE()

		--INSERT PRODUCT
		INSERT INTO Products(
			IdProductType
			,Description
			,Available
			,CreteDate
			,UpdateDate
		)
		VALUES (
			@IdProductType
			,@Description
			,1 -- DEFAULT
			,@Now
			,@Now
		)

		DECLARE @IdProduct INT = (SELECT SCOPE_IDENTITY())

		--INSERT PRICE
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
		,'Product was inserted' Message

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION
		
		DECLARE @Error VARCHAR(MAX)=(SELECT ERROR_MESSAGE())

		RAISERROR(@Error,16,104)

	END CATCH
    SET NOCOUNT OFF;

END
