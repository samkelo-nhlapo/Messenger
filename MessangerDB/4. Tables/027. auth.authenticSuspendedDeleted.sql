USE Messanger
GO
-- ============================================================================================
-- Author:        Samkelo Nhlapo
-- Create date:	  30/08/2021
-- Description:   Creating Auth Suspended Table
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

/* CREATING SCHEMA FOR SUBSCRIPTION  */

IF (OBJECT_ID('auth.authenticSuspendedDeleted') IS NOT NULL)
  DROP TABLE auth.authenticSuspendedDeleted
GO

CREATE TABLE auth.authenticSuspendedDeleted(
 AuthenticId UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES auth.authentic(AuthenticId),
 Suspended BIT NOT NULL,
 IsDeleted BIT NOT NULL,
 authenticSuspendedDeletedTypeId INT NOT NULL FOREIGN KEY REFERENCES auth.authenticSuspendedDeletedTypes(authenticSuspendedDeletedTypeId),
 UpdateDate DATETIME NOT NULL
)