USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Messages Table
--TFS Task		Create Messages 
--================================================================================================

CREATE TABLE Profile.Messages
(
	MessagesID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	MessageBody VARCHAR(MAX) NOT NULL,
	CreatorIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	MediaIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Media.Media(MediaID),
	Created_at DATETIME NOT NULL,
	IsRead BIT NOT NULL,
	IsDeleted BIT NOT NULL

)
GO