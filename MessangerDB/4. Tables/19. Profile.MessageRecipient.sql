USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	30/08/2021
--Description	Creating Message Recipient Table
--TFS Task		Create Message Recipient
--================================================================================================

CREATE TABLE Profile.MessageRecipient
(
	MessageRecipientID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	RecipientIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	Recipient_GroupID INT NOT NULL FOREIGN KEY REFERENCES Groups.UserGroups(UserGroupID),
	MessageIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Messages(MessagesID),
	MediaIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Media.Media(MediaID),
	IsRead BIT NOT NULL,
	UpdateDate DATETIME NOT NULL
)
GO