
CREATE DATABASE Messanger
GO

USE Messanger
GO

ALTER DATABASE Messanger ADD FILEGROUP MessangerData
GO

USE Messanger
GO

ALTER DATABASE Messanger 
ADD FILE 
(
	NAME = MessangerDataFile,
	FILENAME = 'D:\DB BackUp\SQL_DB_FILES\MessangerData.mdf'
)
TO FILEGROUP MessangerData
GO

ALTER DATABASE Messanger 
	ADD LOG FILE
	(
		NAME = MessangerLog,
		FILENAME = 'D:\DB BackUp\SQL_DB_FILES\MessangerLog.ldf'
	)