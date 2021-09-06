USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	04/08/2021
--Description	Creating DisplayProfile Table
--TFS Task		Create DisplayProfile 
--================================================================================================

CREATE TABLE Profile.DisplayProfile
(
	DisplayProfileID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	DPName VARCHAR(250) NOT NULL,
	DPDirectory VARCHAR(max) NOT NULL,
	UpdateDate DATETIME NOT NULL,
	IsDeleted BIT NOT NULL
)
GO