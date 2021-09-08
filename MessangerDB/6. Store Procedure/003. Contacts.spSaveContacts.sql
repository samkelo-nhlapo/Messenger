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
	
	BEGIN TRAN
	
	BEGIN TRY	
		--/*IF PHONE AND EMAIL DOES NOT EXISTS INSERT*/
		IF NOT EXISTS (SELECT CP.PhoneNumber, CE.EmailDescription
						FROM Contacts.Contacts AS CC WITH (NOLOCK) 
						JOIN Contacts.Phones AS CP WITH (NOLOCK) ON CC.PhoneIDFK = CP.PhoneID
						JOIN Contacts.Emails AS CE WITH (NOLOCK) ON CC.EmailIDFK = CE.EmailID 
						WHERE CP.PhoneNumber = @PhoneNumber AND CE.EmailDescription = @Email
					)
		BEGIN
			
			/*INSERTING PHONE NUMBER*/
			INSERT INTO Contacts.Phones
			(
				PhoneNumber, 
				PhoneTypeIDFK, 
				PhoneIsActive, 
				UpdatedDate
			)
			VALUES(@PhoneNumber, @PhoneTypeID, @IsActive, @DEFAULTDATE)


			/*INSERT EMAIL*/
			INSERT INTO Contacts.Emails
			(
				EmailDescription,
				EmailTypeIDFK, 
				EmailIsActive, 
				UpdatedDate
			)
			VALUES(@Email, @EmailType, @IsActive, @DEFAULTDATE)

			/*INSERT CONTACTS*/
			INSERT INTO Contacts.Contacts
			(
				PhoneIDFK, 
				EmailIDFK, 
				ContactTypeIDFK, 
				ContactIsActive, 
				UpdatedDate
			)
			VALUES((SELECT PhoneID FROM Contacts.Phones WHERE PhoneNumber = @PhoneNumber), (SELECT EmailID FROM Contacts.Emails WHERE EmailDescription = @Email), (SELECT ContactTypeID FROM Contacts.ContactType WHERE ContactTypeID = @ContactType) , @IsActive, @DEFAULTDATE)

			SET @Message = (SELECT UserNotification FROM Auth.UserNotification (NOLOCK) WHERE UserNotificationID = 1)

			COMMIT TRAN

		END ELSE
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM Contacts.Phones AS CP WITH (NOLOCK) WHERE PhoneNumber = @PhoneNumber) /*IF PHONE DOES NOT EXISTS*/
			BEGIN
				
				INSERT INTO Contacts.Phones
				(
					PhoneNumber, 
					PhoneTypeIDFK, 
					PhoneIsActive, 
					UpdatedDate
				)
				VALUES(@PhoneNumber, @PhoneTypeID, @IsActive, @DEFAULTDATE)

				INSERT INTO Contacts.Contacts
				(
					PhoneIDFK, 
					EmailIDFK, 
					ContactTypeIDFK, 
					ContactIsActive, 
					UpdatedDate
				)
				VALUES((SELECT PhoneID FROM Contacts.Phones WHERE PhoneNumber = @PhoneNumber), (SELECT EmailID FROM Contacts.Emails WHERE EmailDescription = @Email), (SELECT ContactTypeID FROM Contacts.ContactType WHERE ContactTypeID = @ContactType) , @IsActive, @DEFAULTDATE)

					

				SET @Message = 'Phone number saved successfully'
			
			END 
			ELSE
			IF NOT EXISTS (SELECT 1 FROM Contacts.Emails WITH (NOLOCK) WHERE EmailDescription = @Email) /*IF EMAIL DOES NOT EXISTS*/
			BEGIN
				
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
				VALUES((SELECT PhoneID FROM Contacts.Phones WHERE PhoneNumber = @PhoneNumber), (SELECT EmailID FROM Contacts.Emails WHERE EmailDescription = @Email), (SELECT ContactTypeID FROM Contacts.ContactType WHERE ContactTypeID = @ContactType) , @IsActive, @DEFAULTDATE)

				SET @Message = 'Email saved successfully'
				

			END ELSE
			BEGIN
				
				SET @Message = 'Check Email AND Phone'
				--SET @Message = (SELECT UserNotification FROM Auth.UserNotification WHERE UserNotificationID = 6)
				
				--ROLLBACK TRAN
			END

		COMMIT TRAN
		
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

		--ROLLBACK TRAN

	END CATCH

	SET NOCOUNT OFF
END