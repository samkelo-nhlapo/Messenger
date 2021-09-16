USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  03/09/2021
		Description:      Add insert into Profile data
		TFS Task:	      Create stored procedures for Profile
================================================================================
*/

CREATE OR ALTER PROC Profile.spSaveUserProfile
(
	@UserID UNIQUEIDENTIFIER,
	@DP UNIQUEIDENTIFIER,
	@Status VARCHAR(50) = '',
	@Message VARCHAR(MAX) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
	
	DECLARE @DefaultDate DATETIME = GETDATE(),
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME

	BEGIN TRY
	
	--IF USER EXISTS
	IF EXISTS(SELECT 1 FROM Profile.Profile WITH (NOLOCK) WHERE UserIDFK = @UserID)
	BEGIN
		
		UPDATE Profile.Profile SET
				UserIDFK = @UserID,
				DisplayProfileIDFK = @DP,
				Status = dbo.CapitalizeFirstLetter(@Status),
				Created_at = @DefaultDate,
				Updatedate = @DefaultDate
		WHERE UserIDFK = @UserID

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 35)

	END ELSE
	BEGIN

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 33) + (SELECT UserName FROM Profile.Users WITH(NOLOCK) WHERE UserID = @UserID)

	END
	END TRY
	BEGIN CATCH

		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()

		EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,32

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 32)
	END CATCH
SET NOCOUNT OFF
END