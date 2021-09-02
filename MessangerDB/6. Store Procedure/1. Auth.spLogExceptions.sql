USE Messanger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  02/09/2021
		Description:      Stored procedure to log exceptions
		TFS Task:	      Create stored procedures for exceptions
================================================================================
*/

CREATE OR ALTER PROC Auth.spLogExceptions
(
	@ErrorSchema VARCHAR(MAX),
	@ErrorProc VARCHAR(MAX),
	@ErrorNumber VARCHAR(MAX),
	@ErrorState VARCHAR(MAX),
	@ErrorSeverity VARCHAR(MAX),
	@ErrorLine VARCHAR(MAX),
	@ErrorMessage VARCHAR(MAX),
	@ErrorDate DATETIME,
	@UserNotificationID INT
)
AS
BEGIN

	INSERT INTO Auth.Exceptions
	(
		ErrorSchema,
		ErrorProc,
		ErrorNumber,
		ErrorState,
		ErrorSeverity,
		ErrorLine,
		ErrorMessage,
		ErrorDate,
		UserNotificationID
	)
	VALUES(@ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@ErrorDate,@UserNotificationID)


END