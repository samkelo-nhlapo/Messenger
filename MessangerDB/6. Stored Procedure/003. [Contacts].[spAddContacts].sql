USE [Messenger]
GO

/****** Object:  StoredProcedure [Contacts].[spAddContacts]    Script Date: 22-Jan-22 06:36:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	22/01/2022
--	Description	Save Contacts 
--	TFS Task	Add Phone, Email and Contact Details 
--================================================================================================


ALTER     PROC [Contacts].[spAddContacts]
(
	@PhoneNumber VARCHAR(12) = '',
	@PhoneTypeID INT = 1,
	@Email VARCHAR(250) = '',
	@EmailType INT = 1,
	@Message VARCHAR(250) OUTPUT
)
AS
BEGIN

SET NOCOUNT ON
	
	DECLARE @DefaultDate DATETIME = GETDATE(),
			@PhoneID UNIQUEIDENTIFIER = NEWID(),
			@EmailID UNIQUEIDENTIFIER = NEWID(),
			@ContactID UNIQUEIDENTIFIER = NEWID(),
			@ContactTypeID INT = 1,
			@IsActive BIT = 0,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME

	BEGIN TRY 
		
		/*Email verification */
		IF NOT EXISTS (SELECT 1 FROM Contacts.Emails WITH(NOLOCK) WHERE EmailDescription = @Email)
		BEGIN
			
			SET @IsActive = 1

			INSERT INTO Contacts.Phones 
			(
				PhoneID, 
				PhoneNumber, 
				PhoneTypeIDFK, 
				PhoneIsActive, 
				UpdatedDate
			)
			VALUES(@PhoneID, @PhoneNumber, ISNULL(CONVERT(VARCHAR,@PhoneTypeID), 1), @IsActive, @DefaultDate)

			INSERT INTO Contacts.Emails
			(
				EmailID, 
				EmailDescription, 
				EmailTypeIDFK, 
				EmailIsActive, 
				UpdatedDate
			)
			VALUES(@EmailID, @Email, ISNULL(CONVERT(VARCHAR,@EmailType), 1), @IsActive, @DefaultDate)

			

			SET @Message = ''

		END ELSE
		BEGIN
			
			SET @Message = 'Email already exists '

		END


		IF (@Message = '' OR @Message = NULL)
		BEGIN
			
			SET @IsActive = 1
			
			--Save contact (Email and Phone Details to Contacts Table)
			INSERT INTO Contacts.Contacts
			(
				ContactID, 
				PhoneIDFK, 
				EmailIDFK, 
				ContactTypeIDFK, 
				ContactIsActive, 
				UpdatedDate
			)
			VALUES(@ContactID, @PhoneID, @EmailID, @ContactTypeID, @IsActive, @DefaultDate)
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
GO


