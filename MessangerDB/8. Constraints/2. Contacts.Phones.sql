USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	22/01/2022
--	Description	Phone number constraint
--	TFS Task	Ensure Phone number column has numbers not any other letters
--================================================================================================

ALTER TABLE Contacts.Phones 
ADD CONSTRAINT chk_phone 
CHECK (PhoneNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')