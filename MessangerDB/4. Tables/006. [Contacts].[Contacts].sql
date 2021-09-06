USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Contact Table
--TFS Task		Create Contacts 
--================================================================================================

CREATE TABLE Contacts.Contacts
(
	ContactID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	PhoneIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Contacts.Phones(PhoneID),
	EmailIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Contacts.Emails(EmailID),
	ContactTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Contacts.ContactType(ContactTypeID),
	ContactIsActive BIT NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO