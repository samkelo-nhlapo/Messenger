USE Messanger
GO
-- ============================================================================================
-- Author:        Samkelo Nhlapo
-- Create date:	  23/08/2021
-- Description:   Create User Notification Table
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

IF (OBJECT_ID('Profile.UserNotification') IS NOT NULL)
  DROP TABLE Profile.UserNotification
GO

CREATE TABLE Profile.UserNotification
(
	UserNotificationID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserNotification VARCHAR(250) NOT NULL,
	IsActive BIT NOT NULL,
	UpdateDate DATETIME NOT NULL 
)

GO
