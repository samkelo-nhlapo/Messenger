USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Provinces Table
--TFS Task		Create Provinces 
--================================================================================================

CREATE TABLE Location.Provinces
(
	ProvinceId INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	ProvinceDecription VARCHAR (255) NOT NULL,
	ProvinceIsActive BIT NOT NULL,
	UpdateDate DATETIME NOT NULL,
	CountryIdFk  INT NOT NULL FOREIGN KEY REFERENCES Location.Countries(CountryId),
)
GO