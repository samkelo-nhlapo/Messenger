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

CREATE OR ALTER PROCEDURE spSaveContacts
(
@PhoneNumber VARCHAR(250),
@Email VARCHAR(250),
@ContactTypeID INT
)
AS
BEGIN
	
	DECLARE @DEFAULTDATE DATETIME = GETDATE(),
			@ContactIsActive BIT = 1

	BEGIN TRY

		IF NOT EXISTS
		(	SELECT PU.FirstName, PC.PhoneNumber, PC.Email 
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


	END CATCH
END