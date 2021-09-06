USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  03/09/2021
		Description:      Add insert into User data
		TFS Task:	      Create stored procedures for User
================================================================================
*/

CREATE OR ALTER PROC Profile.spSaveUserDetails
(
	@UserID UNIQUEIDENTIFIER,
	@Name VARCHAR(250),
	@DateOfBirth DATETIME,
	@AddressFK UNIQUEIDENTIFIER,
	@ContactsFK UNIQUEIDENTIFIER,
	@UserAuthtypeFK INT,
	@Message VARCHAR(MAX) OUTPUT
)
AS
BEGIN
	
SET NOCOUNT ON 

	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsArchived BIT = 0,
			@IsReported BIT = 0,
			@IsBlocked BIT = 0,
			@IsActive BIT = 1,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	
	BEGIN TRY
		
		IF NOT EXISTS(SELECT * FROM Profile.Users WHERE UserID = @UserID)
		BEGIN

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
			VALUES(@Name, @DateOfBirth, @AddressFK, @ContactsFK, @UserAuthtypeFK, @IsArchived, @IsReported, @IsBlocked, @IsActive, @DefaultDate, @DefaultDate)

			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID = )

		END ELSE
		BEGIN

			UPDATE Profile.Users SET
			UserName = @Name,
			DateOfBirth = @DateOfBirth,
			AddressIDFK = @AddressFK,
			ContactIDFK = @ContactsFK,
			UserAuthTypeIDFK = @UserAuthtypeFK,
			UserIsArchived = @IsArchived,
			UserIsReported = @IsReported,
			UserIsBlocked = @IsBlocked,
			UserIsActive = @IsActive,
			CreatedDate = @DefaultDate,
			UpdateDate = @DefaultDate
			WHERE UserID = @UserID

			
			SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID = )

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
		
		SET @Message = (SELECT * FROM Auth.UserNotification WHERE UserNotificationID = )

	END CATCH
SET NOCOUNT OFF
END