USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	02/08/2021
--Description	Creating Users Table
--TFS Task		Create Users
--================================================================================================

CREATE TABLE Profile.Users
(
	UserID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	FirstName VARCHAR(20) NOT NULL,
	LastSurname VARCHAR(20) NOT NULL,
	PreferredName VARCHAR(20) NOT NULL,
	BirthDate DATE NOT NULL,
	UserName VARCHAR(255) NOT NULL,
	Password CHAR(60) NOT NULL,
	GenderIDFK INT NOT NULL FOREIGN KEY REFERENCES Profile.Genders(GenderID),
	ContactIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Contacts(ContactID),
	UserDeviceIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Profile.Devices(DeviceID),
	UserIsActive BIT NOT NULL,
	UserIsReported BIT NOT NULL,
	UserIsBlocked BIT NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO