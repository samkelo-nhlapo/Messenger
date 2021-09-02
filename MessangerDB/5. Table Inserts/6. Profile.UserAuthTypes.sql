USE Messanger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting UserAuthTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @IsActive BIT = 1

INSERT INTO Profile.UserAuthTypes(UserTypeDescription, UserTypeIsActive)
VALUES('Administrator', @IsActive ),
	('System', @IsActive),
	('Internal-EndUser', @IsActive),
	('External-EndUser',@IsActive)