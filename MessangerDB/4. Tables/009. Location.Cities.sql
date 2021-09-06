USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating City Table
--TFS Task		Create City 
--================================================================================================

CREATE TABLE Location.Cities
(
	CityID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	CityName NVARCHAR(100) NOT NULL,
	CityIsActive BIT NOT NULL,
	UpdateDate DATETIME NOT NULL,
	ProvinceIdIdFK INT NOT NULL FOREIGN KEY REFERENCES Location.Provinces(ProvinceId)
)
GO