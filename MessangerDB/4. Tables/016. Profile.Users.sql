USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	26/08/2021
--Description	Creating User Table
--TFS Task		Create User
--================================================================================================

CREATE TABLE Profile.Users
(
	UserID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	UserName VARCHAR (255) NOT NULL,
	DateOfBirth DATETIME NOT NULL,
	AddressIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Location.Address(AddressID),
	ContactIDFK UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Contacts.Contacts(ContactID),
	UserAuthTypeIDFK INT NOT NULL FOREIGN KEY REFERENCES Profile.UserAuthTypes(UserAuthTypesID),
	UserIsArchived BIT NOT NULL,
	UserIsReported BIT NOT NULL,
	UserIsBlocked BIT NOT NULL,
	UserIsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	UpdateDate DATETIME NOT NULL
)
GO