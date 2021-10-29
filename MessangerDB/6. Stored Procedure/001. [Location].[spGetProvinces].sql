USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Select Countries Procedure
--	TFS Task	Select Into Table
--================================================================================================

CREATE OR ALTER PROC Location.spGetCountries
(
	@Country VARCHAR(250) = '',
	@Message VARCHAR(250) OUTPUT
)
AS 
BEGIN
	
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
	
	IF EXISTS(SELECT 1 FROM Location.Countries WHERE CountryDescripition = '%' + @Country + '%')
	BEGIN

		SELECT 
			CountryId, 
			CountryDescripition 
		FROM Location.Countries WHERE CountryDescripition = @Country

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 40)
	
	END ELSE
	BEGIN
		
		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()

		EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,42

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 41)

	END

END