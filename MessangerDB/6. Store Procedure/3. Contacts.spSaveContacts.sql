USE Messanger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  20/01/2021
		Description:      Add insert into Contacts data
		TFS Task:	      Create stored procedures for contact
================================================================================
*/

CREATE OR ALTER PROCEDURE Contacts.spSaveUserContacts
(
	@UserID UNIQUEIDENTIFIER,
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
			@UserNotification INT
	
	BEGIN TRAN
	
	BEGIN TRY
		

		IF NOT EXISTS ( 
						SELECT CP.PhoneNumber, CE.EmailDescription
						FROM Profile.Users AS PU 
						JOIN Contacts.Contacts AS CC ON PU.ContactIDFK = CC.ContactID
						JOIN Contacts.Phones AS CP ON CC.PhoneIDFK = CP.PhoneID
						JOIN Contacts.Emails AS CE ON CC.EmailIDFK = CE.EmailID 
						WHERE CP.PhoneNumber = @PhoneNumber AND CE.EmailDescription = @Email
					  )
		BEGIN
			
			/*iNSERTING PHONE NUMBER*/
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

			/*iNSERT CONTACTS*/
			INSERT INTO Contacts.Contacts
			(
				PhoneIDFK, 
				EmailIDFK, 
				ContactTypeIDFK, 
				ContactIsActive, 
				UpdatedDate
			)
			VALUES(@PhoneNumber, @Email, @ContactType, @IsActive, @DEFAULTDATE)

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
		

		EXEC [Auth].[spLogExceptions] @ErrorSchema, @ErrorProc, @ErrorNumber, @ErrorState, @ErrorSeverity, @ErrorLine, @ErrorMessage, @ErrorDate, 1

	END CATCH

	SET NOCOUNT OFF
END