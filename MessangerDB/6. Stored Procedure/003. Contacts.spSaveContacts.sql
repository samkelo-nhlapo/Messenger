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
	@ContactType INT,
	@PhoneNumber VARCHAR(12),
	@PhoneTypeID INT,
	@Email VARCHAR(MAX),
	@EmailType INT,
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
	
	
	BEGIN TRY	
		
		IF NOT EXISTS(SELECT 1 FROM Contacts.Phones WHERE PhoneNumber = @PhoneNumber)
		BEGIN
			
			INSERT INTO Contacts.Phones
			(
				PhoneNumber, 
				PhoneTypeIDFK, 
				PhoneIsActive, 
				UpdatedDate
			)
			VALUES(@PhoneNumber, @PhoneTypeID, @IsActive, @DEFAULTDATE)

		END
		ELSE
		IF NOT EXISTS(SELECT * FROM Contacts.Emails WHERE EmailDescription = @Email)
		BEGIN

			INSERT INTO Contacts.Emails
			(
				EmailDescription, 
				EmailTypeIDFK, 
				EmailIsActive, 
				UpdatedDate
			)
			VALUES(@Email, @EmailType, @IsActive, @DEFAULTDATE)

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

	END CATCH
SET NOCOUNT OFF
END