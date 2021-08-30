USE Messanger
GO
-- ============================================================================================
-- Author:        Samkelo nhlapo
-- Create date:	  30/08/2021
-- Description:   Creating Auth Table
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

/* CREATING SCHEMA FOR SUBSCRIPTION  */

IF (OBJECT_ID('auth.authentic') IS NOT NULL)
  DROP TABLE auth.authentic
GO

CREATE TABLE auth.authentic(
 AuthenticId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
 AuthName NVARCHAR(MAX) NOT NULL,
 AuthPassword NVARCHAR(MAX) NOT NULL,
 AuthEmail NVARCHAR(MAX) NOT NULL,
 UserToken NVARCHAR(MAX) NOT NULL,
 AuthIsActive BIT NOT NULL,
 DateCreated DATETIME NOT NULL,
 AuthLoginCount INT NOT NULL
)