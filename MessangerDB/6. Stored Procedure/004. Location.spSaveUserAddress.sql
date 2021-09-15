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
	@Street VARCHAR(200) = '',
	@CityID INT = 0,
	@PostalCode VARCHAR(10) = '',
	@ProvinceFK INT = 0,
	@CountryFK INT = 0, 
	@Latitude NVARCHAR(MAX) = '',
	@Longitude NVARCHAR(MAX) = '',
	@Message VARCHAR(MAX) OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @IsActive BIT ,
			@DefaultDate DATETIME  = GETDATE(),
			@GeoFK UNIQUEIDENTIFIER = NEWID(),
			@AddressID UNIQUEIDENTIFIER,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME

	BEGIN TRAN spSaveUserAddress
	BEGIN TRY
		
		--if country exists 
		IF EXISTS(SELECT 1 FROM Location.Countries WITH (NOLOCK) WHERE CountryId = @CountryFK)
		BEGIN
			

			SET @GeoFK = NEWID()
			SET @IsActive  = 1

			INSERT INTO Location.Geo
			(
				GeoId,
				Latitude,
				Longitude
			)
			VALUES(@GeoFK ,@Latitude, @Longitude)

			INSERT INTO Location.Address
			(
				Street, 
				CityIDFK, 
				PostalCode, 
				ProvinceIDFK, 
				CountryIDFK, 
				GeoIDFK, 
				IsActive, 
				UpdateDate
			)
			VALUES(@Street, @CityID, @PostalCode, @ProvinceFK, @CountryFK, (SELECT GeoId FROM Location.Geo WHERE GeoId = @GeoFK), @IsActive, @DefaultDate)

			SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 7)

			COMMIT TRAN spSaveUserAddress

		END	ELSE
		BEGIN

			SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 8)

			ROLLBACK TRAN spSaveUserAddress

		END
	END TRY
	BEGIN CATCH

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

		ROLLBACK TRAN spSaveUserAddress

	END CATCH
END