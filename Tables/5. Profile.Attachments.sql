USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Attachment Table
--TFS Task		Create Attachment 
--================================================================================================

CREATE TABLE Profile.Attachments
(
	AttachmentID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	thumb_URL VARCHAR (MAX) NOT NULL,
	File_URL VARCHAR(MAX) NOT NULL,
	Created_at DATETIME NOT NULL
)
GO