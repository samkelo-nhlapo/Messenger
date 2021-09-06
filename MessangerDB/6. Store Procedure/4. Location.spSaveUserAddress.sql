USE Messenger
GO

/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  03/09/2021
		Description:      Add insert into address data
		TFS Task:	      Create stored procedures for Address
================================================================================
*/

CREATE OR ALTER PROC Location.spSaveUserAddress
(
	@User UNIQUEIDENTIFIER,
	@Street VARCHAR(200),
	@CityID INT,
	@PostalCode VARCHAR(10),
	@ProvinceFK INT,
	@CountryFK INT,
	@Latitude NVARCHAR(MAX),
	@Longitude NVARCHAR(MAX),
	@Message VARCHAR(MAX) OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON
	BEGIN TRAN

	DECLARE @IsActive BIT = 1,
			@DefaultDate DATETIME  = GETDATE(),
			@GeoFK UNIQUEIDENTIFIER,
			@AddressID UNIQUEIDENTIFIER,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME

	IF NOT EXISTS(SELECT * FROM Location.Address AS PA JOIN Profile.Users AS PU ON PU.AddressIDFK = PA.AddressID WHERE PU.UserID = @User )
	BEGIN
		
		INSERT INTO Location.Geo(Latitude,Longitude)
		VALUES(@Latitude, @Longitude)

		INSERT INTO Location.Address
		(
			Street,
			CityIDFK,
			PostalCode,
			ProvinceIDFK,
			GeoIDFK,
			IsActive,
			UpdateDate
		)
		VALUES(dbo.CapitalizeFirstLetter(@Street),@CityID, @PostalCode, @ProvinceFK, @CountryFK, @GeoFK, @IsActive, @DefaultDate)

		SET @Message = (SELECT * FROM Auth.UserNotification WITH (NOLOCK) WHERE UserNotificationID = 7 )

		COMMIT TRAN

	END ELSE
	BEGIN
		
		UPDATE Location.Geo SET 
				Latitude = @Latitude,
				Longitude = @Longitude
		WHERE GeoId = @AddressID

		UPDATE Location.Address SET 
				Street = dbo.CapitalizeFirstLetter(@Street),
				CityIDFK = @CityID,
				PostalCode = @PostalCode,
				ProvinceIDFK = @ProvinceFK,
				CountryIDFK = @CountryFK,
				GeoIDFK = @GeoFK,
				IsActive = @IsActive,
				UpdateDate = @DefaultDate
		WHERE AddressID = @AddressID

		SET @Message = (SELECT * FROM Auth.UserNotification WITH (NOLOCK) WHERE UserNotificationID = 7 )

		COMMIT TRAN

	END

		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState  = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorDate = @DefaultDate

		EXEC [Auth].[spLogExceptions] @ErrorSchema, @ErrorProc, @ErrorNumber, @ErrorState, @ErrorSeverity, @ErrorLine, @ErrorMessage, @ErrorDate, 8

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 8)


END