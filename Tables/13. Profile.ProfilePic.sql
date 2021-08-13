USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating ProfilePic Table
--TFS Task		Create ProfilePic 
--================================================================================================

CREATE TABLE Profile.ProfilePic
(
	ProfilePicID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	ProfileIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Profile(ProfileID),
	PicFileName NVARCHAR(100) NOT NULL,
	PicFileData VARBINARY(MAX) NOT NULL,
	Created_at DATETIME NOT NULL,
	Updatedate DATETIME NOT NULL
)
GO