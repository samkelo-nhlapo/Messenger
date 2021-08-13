USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating DeviceTypes Table
--TFS Task		Create DevicesTypes
--================================================================================================

CREATE TABLE Profile.DevicesTypes
(
	DeviceTypeID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	DeviceName VARCHAR(50) NOT NULL,
	Description VARCHAR(100)NOT NULL,
	DeviceTypeIsActive BIT NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO