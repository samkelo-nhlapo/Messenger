USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  07/09/2021
		Description:      Add insert into MessageRecipient data
		TFS Task:	      Create stored procedures for Profile
================================================================================
*/
CREATE OR ALTER PROC Profile.spSaveUserMessageRecipient
(
	@MessageFK UNIQUEIDENTIFIER,
	@CreatorFK UNIQUEIDENTIFIER,
	@RecipientFK UNIQUEIDENTIFIER,
	@GroupFK_Recipient UNIQUEIDENTIFIER,
	@MediaFK UNIQUEIDENTIFIER,
	@Message VARCHAR(MAX) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @IsRead BIT,
			@DefaultDate DATETIME,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	
	BEGIN TRY
		
			IF NOT EXISTS (SELECT 1 FROM Profile.Messages WHERE MessagesID = @MessageFK)
			BEGIN
				
				INSERT INTO Profile.MessageRecipient(MessageIDFK, CreatorIDFK, RecipientIDFK, GroupID_Recipient, MediaIDFK, IsRead, UpdateDate)
				VALUES(@MessageFK, @CreatorFK, @RecipientFK, @GroupFK_Recipient, @MediaFK, @IsRead, @DefaultDate)
	
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