USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	26/08/2021
--Description	Creating MediaTypes Table
--TFS Task		Create MediaTypes 
--================================================================================================

CREATE TABLE Media.MediaTypes
(
	MediaTypesID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Description VARCHAR(250) NOT NULL,
	UpdateDate DATETIME NOT NULL
)
GO