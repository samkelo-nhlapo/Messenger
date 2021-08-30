USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating UserGroups Table
--TFS Task		Create UserGroups 
--================================================================================================

CREATE TABLE Groups.UserGroups
(
	UserGroupID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	GroupIDFK INT NOT NULL FOREIGN KEY REFERENCES Groups.Groups(GroupID),
	IsActive BIT NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO