USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  06/09/2021
		Description:      Add insert into User data
		TFS Task:	      Create stored procedures for Profile
================================================================================
*/

CREATE OR ALTER PROC Profile.spSaveUser
(
	@UserID UNIQUEIDENTIFIER,
	@UserName VARCHAR(255),
	@DateOfBirth DATETIME,
	@AddressFK UNIQUEIDENTIFIER,
	@PhoneNumber UNIQUEIDENTIFIER,
	@Email UNIQUEIDENTIFIER,
	@UserAuth UNIQUEIDENTIFIER,
	@Message VARCHAR(255) OUTPUT
)
AS
BEGIN

SET NOCOUNT ON
BEGIN TRAN
	DECLARE @IsActive BIT,
			@IsArchived BIT,
			@IsReported BIT,
			@IsBlocked BIT,
			@DefaultDate DATETIME = GETDATE(),
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME

	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM Profile.Users AS PU 
						JOIN Contacts.Contacts AS CC ON PU.ContactIDFK = CC.ContactID
						JOIN Contacts.Phones AS CP ON CC.PhoneIDFK = CP.PhoneID
						JOIN Contacts.Emails AS CE ON CC.EmailIDFK = CE.EmailID WHERE CP.PhoneNumber = @PhoneNumber OR CE.EmailID = @Email)
		BEGIN

			SET @IsArchived = 0
			SET @IsReported = 0
			SET @IsBlocked = 0
			SET @IsActive = 1

			INSERT INTO 

			INSERT INTO Profile.Users
			(
				UserName, 
				DateOfBirth, 
				AddressIDFK, 
				ContactIDFK, 
				UserAuthTypeIDFK, 
				UserIsArchived, 
				UserIsReported, 
				UserIsBlocked, 
				UserIsActive, 
				CreatedDate, 
				UpdateDate
			)
			VALUES(@UserName, @DateOfBirth, @AddressFK, @ContactFK, @UserAuth, @IsArchived, @IsReported, @IsBlocked, @IsActive, @DefaultDate, @DefaultDate)

			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID =)

			COMMIT TRAN

		END ELSE IF(SELECT * FROM Profile.Users WHERE )
		BEGIN

			

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