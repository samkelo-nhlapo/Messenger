USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Devices Table
--TFS Task		Create Devices
--================================================================================================

CREATE TABLE Profile.Devices
(
	DeviceID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	DeviceTypeIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.DevicesTypes(DeviceTypeID),
	DeviceToken VARCHAR(120),
	DeviceIsActive BIT NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO