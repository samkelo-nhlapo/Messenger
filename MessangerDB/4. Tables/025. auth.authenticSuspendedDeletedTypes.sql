USE Messanger
GO
-- ============================================================================================
-- Author:        Samkelo Nhlapo
-- Create date:	  30/08/2021
-- Description:   Creating Auth Suspended Delete look up Table
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

/* CREATING SCHEMA FOR SUBSCRIPTION  */

IF (OBJECT_ID('auth.authenticSuspendedDeletedTypes') IS NOT NULL)
  DROP TABLE auth.authenticSuspendedDeletedTypes
GO

CREATE TABLE auth.authenticSuspendedDeletedTypes(
 authenticSuspendedDeletedTypeId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 Note VARCHAR(500) NOT NULL,
 UpdateDate DATETIME NOT NULL
)