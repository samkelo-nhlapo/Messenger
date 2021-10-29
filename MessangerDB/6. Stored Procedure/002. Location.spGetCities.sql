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
	@City VARCHAR(250) = '',
	@Message VARCHAR(250) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IsActive BIT = 0,
			@DefaultDate DATETIME = GETDATE(),
			@ErrorSchema VARCHAR(MAX) = '',
			@ErrorProc VARCHAR(MAX) = '',
			@ErrorNumber VARCHAR(MAX) = '',
			@ErrorState VARCHAR(MAX) = '',
			@ErrorSeverity VARCHAR(MAX) = '',
			@ErrorLine VARCHAR(MAX) = '',
			@ErrorMessage VARCHAR(MAX) = '',
			@ErrorDate DATETIME = GETDATE()
	
	BEGIN TRAN

		BEGIN TRY

			IF EXISTS(SELECT 1 FROM Location.Cities WHERE CityName = @City)
			BEGIN
			
				SET @IsActive = 1

				SELECT 
					ISNULL(CityName,''), 
					ISNULL(CityIsActive,@IsActive), 
					ISNULL(UpdateDate,@DefaultDate), 
					ISNULL(ProvinceIdIdFK,0)
				FROM Location.Cities
				
				SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 44)
				
				COMMIT TRAN
			
			END ELSE 
			BEGIN
				
				SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 45)

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
			
			EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,46
			
			SET @Message = (SELECT 1 FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 46)

		END CATCH 
	
	SET NOCOUNT OFF
END