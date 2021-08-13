USE Messanger
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
	SenderIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Sender(SenderID),
	RecipientIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Recipient(RecipientID),
	MessageBody VARCHAR(MAX) NOT NULL,
	AttachmentIDFK INT NOT NULL FOREIGN KEY REFERENCES Profile.Attachments(AttachmentID),
	Created_at DATETIME NOT NULL
)
GO