USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Profile Table
--TFS Task		Create Profile 
--================================================================================================

CREATE TABLE Profile.Profile
(
	ProfileID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	DisplayProfileIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.DisplayProfile(DisplayprofileID),
	Status VARCHAR(50) NOT NULL,
	Created_at DATETIME NOT NULL,
	Updatedate DATETIME NOT NULL
)
GO