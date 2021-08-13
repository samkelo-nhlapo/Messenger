USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Contact Table
--TFS Task		Create Contacts 
--================================================================================================

CREATE TABLE Profile.Contacts
(
	ContactID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	PhoneNumber VARCHAR(15) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	ContactTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Profile.ContactType(ContactTypeID),
	ContactIsActive BIT NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO