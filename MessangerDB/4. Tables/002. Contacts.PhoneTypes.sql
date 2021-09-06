USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Creating PhoneTypes Table
--	TFS Task	Create Contacts 
--================================================================================================

CREATE TABLE Contacts.PhoneTypes
(
	PhoneTypeID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Description VARCHAR(250) NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO