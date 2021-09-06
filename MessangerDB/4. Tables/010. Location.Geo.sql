USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	05/08/2021
--Description	Creating Geo Table
--TFS Task		Create Geo
--================================================================================================

CREATE TABLE Location.Geo
(
	GeoId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	Latitude NVARCHAR(MAX) NOT NULL,
	Longitude NVARCHAR(MAX) NOT NULL
)
GO