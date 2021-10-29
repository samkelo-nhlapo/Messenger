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
	@provinceName VARCHAR(250) = '',
	@Message VARCHAR(250) OUTPUT
)
AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsActive BIT = 0,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	
	BEGIN TRAN
	
	BEGIN TRY

		IF EXISTS(SELECT 1 FROM Location.Provinces WHERE ProvinceDecription = @provinceName)
		BEGIN
				
			SET @IsActive = 1

			SELECT 
				ISNULL(ProvinceDecription,''), 
				ISNULL(ProvinceIsActive,0), 
				ISNULL(UpdateDate,GETDATE()), 
				ISNULL(CountryIdFk,0) 
			FROM Location.Provinces WHERE ProvinceDecription = @provinceName

			SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 48)

			COMMIT TRAN

		END ELSE
		BEGIN
			
			SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 49)

			ROLLBACK

		END
	END TRY
	BEGIN CATCH
		
			
		ROLLBACK TRAN

		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()

		EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,50

		SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 50)

	END CATCH

	SET NOCOUNT OFF

END