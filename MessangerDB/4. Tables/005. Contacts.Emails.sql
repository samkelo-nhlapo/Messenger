USE Messanger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Creating Emails Table
--	TFS Task	Create Contacts 
--================================================================================================

CREATE TABLE Contacts.Emails
(
	EmailID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	EmailDescription VARCHAR(250) NOT NULL,
	EmailTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Contacts.EmailTypes(EmailTypeID),
	EmailIsActive BIT NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO