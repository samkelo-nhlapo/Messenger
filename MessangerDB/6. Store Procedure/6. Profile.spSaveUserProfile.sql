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
	@Status VARCHAR(50),
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

	IF NOT EXISTS(SELECT * FROM Profile.Profile WHERE UserIDFK = @UserID)
	BEGIN
		
		INSERT INTO Profile.Profile
		(
			UserIDFK, 
			DisplayProfileIDFK, 
			Status, 
			Created_at, 
			Updatedate
		)
		VALUES(@UserID, @DP, dbo.CapitalizeFirstLetter(@Status), @DefaultDate, @DefaultDate)

		SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID =)

	END ELSE
	BEGIN

		UPDATE Profile.Profile SET
				UserIDFK = @UserID,
				DisplayProfileIDFK = @DP,
				Status = @Status,
				Created_at = @DefaultDate,
				Updatedate = @DefaultDate
		WHERE UserIDFK = @UserID

		SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID =)

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

		EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,

		SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID =)
	END CATCH
SET NOCOUNT OFF
END