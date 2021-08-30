USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	21/08/2021
--Description	Creating Address Table
--TFS Task		Create Address
--================================================================================================

CREATE TABLE Location.Address
(
	AddressID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	Street VARCHAR(250) NOT NULL,
	CityIDFK INT NOT NULL FOREIGN KEY REFERENCES Location.Cities(CityID),
	PostalCode VARCHAR(10) NOT NULL,
	ProvinceIDFK INT NOT NULL FOREIGN KEY REFERENCES Location.Provinces(ProvinceID),
	CountryIDFK INT NOT NULL FOREIGN KEY REFERENCES Location.Countries(CountryID),
	GeoIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Location.Geo(GeoID),
	IsActive BIT NOT NULL,
	UpdateDate DATETIME NOT NULL
)
GO