USE Messenger
GO

--================================================================================================
--Author:		Samkelo Nhlapo
--Create date	05/11/2021
--Description	LOG Table
--TFS Task		Create Log table
--================================================================================================

CREATE TABLE Dblogs.AuditLog
(
	AuditLogIdD INT,
	ModifiedTime DATETIME,
	ModifiedBy VARCHAR(250),
	Operation VARCHAR(250),
	SchemaName VARCHAR(250),
	TableName VARCHAR(250),
	TABLEId INT,
	LogData VARCHAR(250)
)

GO