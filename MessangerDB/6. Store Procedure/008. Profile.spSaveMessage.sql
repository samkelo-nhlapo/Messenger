USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  03/09/2021
		Description:      Add insert into Message data
		TFS Task:	      Create stored procedures for Profile
================================================================================
*/
CREATE OR ALTER PROC Profile.spSaveMessage
(
	@MessageBody VARCHAR(MAX),
	@CreatorFK UNIQUEIDENTIFIER,
	@MediaFK UNIQUEIDENTIFIER,
	@Message VARCHAR(200) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
	

SET NOCOUNT OFF
END