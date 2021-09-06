USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting EmailTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Contacts.EmailTypes(Description, UpdatedDate)
VALUES('Primary Email', @DefaultDate),
	('Secondary Email', @DefaultDate),
	('Alternative Email', @DefaultDate)