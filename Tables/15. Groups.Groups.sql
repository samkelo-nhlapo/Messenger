USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating Groups Table
--TFS Task		Create Groups 
--================================================================================================

CREATE TABLE Groups.Groups
(
	GroupID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Members INT NOT NULL,
	IsActive BIT NOT NULL,
	Created_at DATETIME NOT NULL,
	UpdatedDate DATETIME NOT NULL
)
GO
