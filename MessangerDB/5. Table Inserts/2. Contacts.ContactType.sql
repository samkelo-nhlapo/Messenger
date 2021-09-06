USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting ContactTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Contacts.ContactType(Description, UpdatedDate)
VALUES('Primary Contact', @DefaultDate),
	('Secondary Contact', @DefaultDate),
	('Alternative Contact', @DefaultDate)