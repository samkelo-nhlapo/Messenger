USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	26/08/2021
--Description	Creating Media Table
--TFS Task		Create Media
--================================================================================================

CREATE TABLE Media.Media
(
	MediaID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	Filename VARCHAR(250) NOT NULL,
	Directory VARCHAR(250) NOT NULL,
	MediaTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Media.MediaTypes(MediaTypesID),
	UpdateDate DATETIME NOT NULL
)
GO