USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  03/09/2021
		Description:      Add insert into Message data
		TFS Task:	      Create stored procedures for Profile
================================================================================
*/
CREATE OR ALTER PROC Profile.spSaveUserMessage
(
	@MessageBody VARCHAR(MAX),
	@CreatorFK UNIQUEIDENTIFIER,
	@MediaFK UNIQUEIDENTIFIER ,
	@Message VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsRead BIT,
			@IsDeleted BIT,
			@GUID_New UNIQUEIDENTIFIER = NEWID(),
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	BEGIN TRY

		--CHECK IF USER IS SENDING A MESSAGE AND MEDIA
		IF(@MessageBody != '') AND (@MediaFK != '')
		BEGIN
			
			SET @IsDeleted = 0

			INSERT INTO Profile.Messages(MessageBody, CreatorIDFK, MediaIDFK, Created_at, IsRead, IsDeleted)
			VALUES(@MessageBody, @CreatorFK, @MediaFK, @DefaultDate, @IsRead, @IsDeleted)

			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotification = )

		END ELSE IF(@MessageBody = '')OR (@MediaFK = '')	--CHECK IF USER IS SENDING MESSAGE OR MEDIA
		BEGIN
			
			SET @IsDeleted = 0

			INSERT INTO Profile.Messages(MessageBody, CreatorIDFK, MediaIDFK, Created_at, IsRead, IsDeleted)
			VALUES(@MessageBody, @CreatorFK, @MediaFK, @DefaultDate, @IsRead, @IsDeleted)

			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotification = )
		
		END ELSE	--IF NO MESSAGE AND NO MEDIA 
		BEGIN

			SET @MessageBody = ''

			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotification = )

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