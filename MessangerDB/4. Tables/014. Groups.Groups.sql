USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	26/08/2021
--Description	Creating Groups Table
--TFS Task		Create Groups
--================================================================================================

CREATE TABLE Groups.Groups
(
	GroupID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	GroupName VARCHAR(250) NOT NULL,
	CreatedBy VARCHAR(250) NOT NULL,
	TotalMembers INT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	UpdateDate DATETIME NOT NULL
)
GO