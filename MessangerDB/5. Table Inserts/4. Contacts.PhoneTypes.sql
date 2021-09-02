USE Messanger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting PhoneTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Contacts.PhoneTypes(Description, UpdatedDate)
VALUES('Primary Phone', @DefaultDate),
	('Secondary Phone', @DefaultDate),
	('Altinative phone', @DefaultDate)