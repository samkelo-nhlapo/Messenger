USE Messanger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	05/08/2021
--Description	Creating Genders Table
--TFS Task		Create Genders 
--================================================================================================

CREATE TABLE Profile.Genders
(
	GenderID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	GenderName VARCHAR(25) NOT NULL,
	UpDatedate DATETIME NOT NULL
)
GO