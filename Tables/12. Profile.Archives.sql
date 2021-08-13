USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Archives Table
--TFS Task		Create Archives 
--================================================================================================

CREATE TABLE Profile.Archives
(
	ArchivesID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	DateCreated DATETIME NOT NULL
)
GO