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
	@PhoneNumber VARCHAR(MAX),
	@PhoneTypeID INT,
	@Email VARCHAR(MAX),
	@EmailType INT,
	@ContactIsActive BIT,
	@Message VARCHAR (MAX) OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @DEFAULTDATE DATETIME = GETDATE()
	
	BEGIN TRAN
	
	BEGIN TRY

		IF NOT EXISTS
		(	
			SELECT PU.FirstName, PC.PhoneNumber, PC.Email 
			FROM Profile.Contacts AS PC 
			INNER JOIN Profile.Users AS PU 
			ON  PC.ContactID = PU.ContactIDFK
		)
		BEGIN

			INSERT INTO Profile.Contacts(PhoneNumber, Email, ContactTypeIDFK, ContactIsActive, UpdatedDate)
			VALUES(@PhoneNumber, @Email, @ContactTypeID, @ContactIsActive, @ContactIsActive, @DEFAULTDATE)

		END

	END TRY
	BEGIN CATCH
		
		-

	END CATCH
END