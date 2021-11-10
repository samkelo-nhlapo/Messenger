USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Get Cities
--	TFS Task	Store Procedure 
--================================================================================================

CREATE OR ALTER PROC Location.spGetCities
(
	@CityId INT = 0,
	@CityName VARCHAR(250) = ''
)
AS
BEGIN

	--DECLARE @IsActive BIT = 0,
	--		@DefaultDate DATETIME = GETDATE(),
	--		@ErrorSchema VARCHAR(MAX) = '',
	--		@ErrorProc VARCHAR(MAX) = '',
	--		@ErrorNumber VARCHAR(MAX) = '',
	--		@ErrorState VARCHAR(MAX) = '',
	--		@ErrorSeverity VARCHAR(MAX) = '',
	--		@ErrorLine VARCHAR(MAX) = '',
	--		@ErrorMessage VARCHAR(MAX) = '',
	--		@ErrorDate DATETIME = GETDATE()

	IF EXISTS(SELECT 1 FROM Location.Cities WHERE CityName = @CityName)
	BEGIN

		SELECT 
			CAST(CityID AS VARCHAR(1000)) AS CityID,
			CityName
		FROM Location.Cities WHERE CityName = @CityName

	END 
	--ELSE
	--BEGIN
	--
	--	SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
	--	SET @ErrorProc = OBJECT_NAME(@@PROCID)
	--	SET @ErrorNumber = ERROR_NUMBER()
	--	SET @ErrorState = ERROR_STATE()
	--	SET @ErrorSeverity = ERROR_SEVERITY()
	--	SET @ErrorLine = ERROR_LINE()
	--	SET @ErrorMessage = ERROR_MESSAGE()
	--	
	--	EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,46
	--END
END