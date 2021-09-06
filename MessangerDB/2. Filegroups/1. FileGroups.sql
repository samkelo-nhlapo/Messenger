USE Messenger
GO

/*
	--================================================================================================
	--Author:		Samkelo Nhlapo
	--Create date	02/08/2021
	--Description	Creating Filegroup
	--TFS Task		Create filegroup
	--================================================================================================
*/

ALTER DATABASE Messenger ADD FILEGROUP MessengerData
GO

USE Messenger
GO

ALTER DATABASE Messenger 
ADD FILE 
(
	NAME = MessengerDataFile,
	FILENAME = 'D:\DB BackUp\SQL_DB_FILES\MessangerData.mdf'
)
TO FILEGROUP MessengerData
GO

ALTER DATABASE Messenger 
	ADD LOG FILE
	(
		NAME = MessengerLog,
		FILENAME = 'D:\DB BackUp\SQL_DB_FILES\MessangerLog.ldf'
	)