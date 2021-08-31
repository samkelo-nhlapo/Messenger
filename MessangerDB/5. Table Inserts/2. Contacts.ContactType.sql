USE Messanger
GO

--================================================================================================
--	Author:			Samkelo Nhlapo
--	Create date		31/08/2021
--	Description		Inserting ContectTypes 
--	TFS Task		Insert ContactTypes
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Contacts.ContactType(Description, UpdatedDate)
VALUES	('Primary Contact', @DefaultDate),
		('Secondary Contact', @DefaultDate)