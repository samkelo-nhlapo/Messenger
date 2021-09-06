USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	26/08/2021
--Description	Creating UserAuthTypes Table
--TFS Task		Create UserAuthtypes
--================================================================================================

CREATE TABLE Profile.UserAuthTypes
(
	UserAuthTypesID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	UserTypeDescription VARCHAR (255) NOT NULL,
	UserTypeIsActive BIT NOT NULL
)
GO