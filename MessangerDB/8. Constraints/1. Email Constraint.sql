USE Messanger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  02/09/2021
		Description:      Email Constraints 
		TFS Task:	      Create Constraint
================================================================================
*/

ALTER TABLE Contacts.Emails ADD CONSTRAINT chk_eMail CHECK( EmailDescription LIKE '%_@__%.__%')