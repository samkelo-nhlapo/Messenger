USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  13/09/2021
		Description:      Add Getting Contact data
		TFS Task:	      Create stored procedures for Contacts
================================================================================
*/
CREATE OR ALTER PROC Profile.spGetUserDetails
(
	@UserName VARCHAR(250),
	@Message  VARCHAR(250) OUTPUT
)
AS
BEGIN

SET NOCOUNT ON

	DECLARE @ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	
	BEGIN TRY

		IF EXISTS(SELECT 1 FROM Profile.Users WITH(NOLOCK) WHERE UserName = @UserName)
		BEGIN

			SELECT PU.UserName, PU.DateOfBirth, CP.PhoneNumber, CE.EmailDescription ,LA.Street, LC.CityName, LA.PostalCode 
			FROM Profile.Users AS PU
				JOIN Location.Address AS LA ON PU.AddressIDFK = LA.AddressID
				JOIN Location.Cities AS LC ON LA.CityIDFK = LC.CityID
				JOIN Location.Provinces AS LP ON LC.ProvinceIdIdFK = LP.ProvinceId
				JOIN Location.Countries AS LCountry ON LP.CountryIdFk = LCountry.CountryId
				JOIN Contacts.Contacts AS CC ON PU.ContactIDFK = CC.ContactID
				JOIN Contacts.Phones AS CP ON CC.PhoneIDFK = CP.PhoneID
				JOIN Contacts.Emails AS CE ON CC.EmailIDFK = CE.EmailID
			WHERE UserName = @UserName


		END ELSE
		BEGIN
			
			SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH (NOLOCK) WHERE UserNotificationID = 30 ) 

		END
	END TRY
	BEGIN CATCH
		
		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()

		EXEC Auth.spLogExceptions  @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@ErrorDate, 27

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH (NOLOCK) WHERE UserNotificationID = 27)

	END CATCH
SET NOCOUNT OFF
END