USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Creating Phones Table
--	TFS Task	Create Contacts 
--================================================================================================

CREATE TABLE Contacts.Phones
(
	PhoneID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	PhoneNumber VARCHAR(250) NOT NULL,
	PhoneTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Contacts.PhoneTypes(PhoneTypeID),
	PhoneIsActive BIT NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO