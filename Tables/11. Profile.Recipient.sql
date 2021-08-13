USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Recipient Table
--TFS Task		Create Recipient 
--================================================================================================

CREATE TABLE Profile.Recipient
(
	RecipientID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	UserGroupIDFK INT NOT NULL FOREIGN KEY REFERENCES Groups.UserGroups(UserGroupID),
	IsRead BIT NOT NULL
)
GO