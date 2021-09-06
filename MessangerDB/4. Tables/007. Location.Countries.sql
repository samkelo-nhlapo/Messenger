USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Countries Table
--TFS Task		Create Countries 
--================================================================================================

CREATE TABLE Location.Countries
(
	CountryId INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	CountryDescripition VARCHAR (250) NOT NULL,
	CountryAlph2Code VARCHAR (250) NOT NULL,
	CountryAlph3Code VARCHAR (250) NOT NULL,
	CountryNumeric INT NOT NULL,
	CountryIsActive BIT NOT NULL,
	UpdateDate DATETIME
)
GO