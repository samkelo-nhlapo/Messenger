USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Sender Table
--TFS Task		Create Sender 
--================================================================================================

CREATE TABLE Profile.Sender
(
	SenderID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	UserGroupIDFK INT NOT NULL FOREIGN KEY REFERENCES Groups.UserGroups(UserGroupID),
	CreatedDate DATETIME NOT NULL,
	IsActive BIT NOT NULL,
	IsRead BIT NOT NULL
)
GO