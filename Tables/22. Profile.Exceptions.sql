USE Messanger
GO
-- ============================================================================================
-- Author:        Samkelo Nhlapo
-- Create date:	  23/08/2021
-- Description:   Create Exceptions Table
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

IF (OBJECT_ID('Profile.Exceptions') IS NOT NULL)
  DROP TABLE Profile.Exceptions
GO

CREATE TABLE Profile.Exceptions
(
	ExceptionId INT PRIMARY KEY IDENTITY(1,1),
	ErrorSchema VARCHAR(100) NOT NULL,
	ErrorProc VARCHAR(100) NOT NULL,
	ErrorNumber VARCHAR(MAX) NOT NULL,
	ErrorState VARCHAR(MAX) NOT NULL,
	ErrorSeverity VARCHAR(MAX) NOT NULL,
	ErrorLine VARCHAR(MAX) NOT NULL,
	ErrorMessage VARCHAR(MAX) NOT NULL,
	ErrorDate DATETIME NOT NULL,
	UserNotificationID INT NOT NULL FOREIGN KEY REFERENCES Profile.UserNotification(UserNotificationID)
)

GO