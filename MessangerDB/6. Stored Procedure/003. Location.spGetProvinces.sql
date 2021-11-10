USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	25/10/2021
--	Description	Get Provinces Procedure
--	TFS Task	Get Province Table
--================================================================================================

CREATE OR ALTER PROC Location.spGetProvinces
(
	@ProvinceId	INT = 0,
	@ProvinceName VARCHAR(250) = ''
)
AS 
BEGIN
	
	SET NOCOUNT ON

	--DECLARE @DefaultDate DATETIME = GETDATE(),
	--		@IsActive BIT = 0,
	--		@ErrorSchema VARCHAR(MAX),
	--		@ErrorProc VARCHAR(MAX),
	--		@ErrorNumber VARCHAR(MAX),
	--		@ErrorState VARCHAR(MAX),
	--		@ErrorSeverity VARCHAR(MAX),
	--		@ErrorLine VARCHAR(MAX),
	--		@ErrorMessage VARCHAR(MAX),
	--		@ErrorDate DATETIME

	IF EXISTS(SELECT 1 FROM Location.Provinces WHERE ProvinceDecription = @provinceName)
	BEGIN

		SELECT 
			CAST(ProvinceId AS VARCHAR(1000)) AS ProvinceId,
			ProvinceDecription 
		FROM Location.Provinces WHERE ProvinceDecription = @provinceName

	END 
	--ELSE
	--BEGIN 
	--	
	--
	--	SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
	--	SET @ErrorProc = OBJECT_NAME(@@PROCID)
	--	SET @ErrorNumber = ERROR_NUMBER()
	--	SET @ErrorState = ERROR_STATE()
	--	SET @ErrorSeverity = ERROR_SEVERITY()
	--	SET @ErrorLine = ERROR_LINE()
	--	SET @ErrorMessage = ERROR_MESSAGE()
	--
	--	EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,50
	--
	--END
END