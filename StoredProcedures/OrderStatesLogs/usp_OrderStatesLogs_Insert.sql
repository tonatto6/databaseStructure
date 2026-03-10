-- =============================================
-- Author:		<Tonatto Lázaro>
-- Description:	<Save every states change>
-- =============================================
CREATE PROCEDURE usp_OrderStatesLogs_Insert
	@IdOrder INT
	,@IdOrderState INT
AS
BEGIN
	
	SET NOCOUNT ON;

		INSERT INTO OrderStatesLogs(
			IdOrder
			,IdOrderState
			,CreatedDate
		)
		VALUES(
			@IdOrder
			,@IdOrderState
			,GETDATE()
		)

	SET NOCOUNT OFF;

END
