USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Access Table
--TFS Task		Create Access
--================================================================================================

CREATE TABLE Profile.Access
(
	AccessID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Users(UserID),
	DeviceIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Devices(DeviceID),
	Token VARCHAR(60) NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO