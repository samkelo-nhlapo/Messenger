USE Messanger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting MediaTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Media.MediaTypes(Description, UpdateDate)
VALUES('Audio', @DefaultDate),
	('Video', @DefaultDate),
	('Image', @DefaultDate),
	('Gif', @DefaultDate),
	('File', @DefaultDate)