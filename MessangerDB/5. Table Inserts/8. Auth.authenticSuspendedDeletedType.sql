USE Messanger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/09/2021
--	Description	Inserting AuthenticsuspendedDeletedTypes Table
--	TFS Task	Insert Data
--================================================================================================

DECLARE @DefaultDate DATETIME = GETDATE()

INSERT INTO Auth.authenticSuspendedDeletedTypes(Note, UpdateDate)
VALUES('User account is currently set to be deleted, which means all the data will be permanently deleted from our servers. This process will take 3 months and you are able to revoked the account deletion within this timeframe, a full package will be sent containing all that data we have on your company, but the financial data can be held for up to 3 years for tax and governmet regulatory reasons.',@DefaultDate),
   ('You have choosen to suspend your account, which means your account will not be charged and you will have full access to the data up-to the point of suspension.',@DefaultDate),
   ('Your account is currently suspend due to none payment, but you will you still be have access to the data up-to the point of suspension.',@DefaultDate),
   ('Suspension/Deletion lefted on your account, and you will have access to all the features in your subscription.',@DefaultDate),
   ('This is a confirmation, that your account has been deleted and that we have sent you a package containing all the data we have on your company, if you have not received the package please contact use within the next 3 months.',@DefaultDate)
   