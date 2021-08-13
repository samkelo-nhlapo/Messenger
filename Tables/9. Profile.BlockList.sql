USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating BlockList Table
--TFS Task		Create BlockList 
--================================================================================================

CREATE TABLE Profile.BlockList 
(
	BlockListID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO