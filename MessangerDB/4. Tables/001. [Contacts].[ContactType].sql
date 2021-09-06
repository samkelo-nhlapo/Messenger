USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Contact Type Table
--TFS Task		Create Contacts 
--================================================================================================

CREATE TABLE Contacts.ContactType
(
	ContactTypeID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Description VARCHAR(20) NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO