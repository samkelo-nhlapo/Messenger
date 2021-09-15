USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  02/09/2021
		Description:      Add insert into Contacts data
		TFS Task:	      Create stored procedures for contact
================================================================================
*/

CREATE OR ALTER PROCEDURE Contacts.spSaveUserContacts
(
	@ContactType INT = 0,
	@PhoneNumber VARCHAR(12) = '',
	@PhoneTypeID INT = 0,
	@Email VARCHAR(MAX) = '',
	@EmailType INT = 0,
	@Message VARCHAR (MAX) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON

	DECLARE @DEFAULTDATE DATETIME = GETDATE(),
			@IsActive BIT = 1,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME,
			@GUID UNIQUEIDENTIFIER 
	
	BEGIN TRAN spSaveUserContacts

	BEGIN TRY	
		
		--Check if Phone number and email Are not in the database
		IF NOT EXISTS(SELECT 1 FROM Contacts.Phones WHERE PhoneNumber = @PhoneNumber) AND NOT EXISTS(SELECT 1 FROM Contacts.Emails WHERE EmailDescription = @Email)
		BEGIN

			INSERT INTO Contacts.Phones
			(
				PhoneNumber, 
				PhoneTypeIDFK, 
				PhoneIsActive, 
				UpdatedDate
			)
			VALUES(@PhoneNumber, @PhoneTypeID, @IsActive, @DEFAULTDATE)

			INSERT INTO Contacts.Emails
			(
				EmailDescription, 
				EmailTypeIDFK, 
				EmailIsActive, 
				UpdatedDate
			)
			VALUES(@Email, @EmailType, @IsActive, @DEFAULTDATE)

			INSERT INTO Contacts.Contacts
			(
				PhoneIDFK, 
				EmailIDFK, 
				ContactTypeIDFK, 
				ContactIsActive, 
				UpdatedDate
			)
			VALUES( @PhoneNumber, @Email, @ContactType, @IsActive, @DEFAULTDATE)

			SET @Message = (SELECT UserNotification FROM Auth.UserNotification WHERE UserNotificationID = 1)

			COMMIT TRAN spSaveUserContacts
		END 
		ELSE 
		BEGIN

			SET @Message = (SELECT UserNotification FROM Auth.UserNotification WHERE UserNotificationID = 6)

			ROLLBACK TRAN spSaveUserContacts

		END

	END TRY
	BEGIN CATCH
		

		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState  = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorDate = @DEFAULTDATE
		

		EXEC [Auth].[spLogExceptions] @ErrorSchema, @ErrorProc, @ErrorNumber, @ErrorState, @ErrorSeverity, @ErrorLine, @ErrorMessage, @ErrorDate, 2

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 2)

		ROLLBACK TRAN spSaveUserContacts

	END CATCH
SET NOCOUNT OFF
END