-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<Change order state to accepted>
-- =============================================
CREATE PROCEDURE usp_OrderStates_Accepted 
	@IdOrder INT
AS
BEGIN
	
	IF NOT EXISTS(SELECT 1 FROM Orders WHERE IdOrder=@IdOrder)
	BEGIN
		RAISERROR('Order does not exist',16,104)
		RETURN
	END

	IF EXISTS(SELECT 1 FROM Orders WHERE IdOrder=@IdOrder AND DeleteDate IS NOT NULL)
	BEGIN
		RAISERROR('Order was removed',16,104)
		RETURN
	END

	IF NOT EXISTS(SELECT 1 FROM Orders WHERE IdOrder=@IdOrder AND IdOrderState=1)
	BEGIN
		RAISERROR('Order must be in pending status',16,104)
		RETURN
	END

	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION

		--UPDATE STATE
		UPDATE Orders
			SET IdOrderState=2
		WHERE IdOrder=@IdOrder

		--INSERT LOG
		EXEC usp_OrderStatesLogs_Insert
			@IdOrder
			,2

		SELECT @IdOrder Id
		,'Order state changed' Message

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		ROLLBACK TRANSACTION

		DECLARE @Error VARCHAR(MAX)=(SELECT ERROR_MESSAGE())

		RAISERROR(@Error,16,104)

	END CATCH

    SET NOCOUNT OFF;
END
