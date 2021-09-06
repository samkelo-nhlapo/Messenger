USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	insert Cities
--	TFS Task	Store Procedure 
--================================================================================================

CREATE OR ALTER PROC Location.spInsertCities
(
	@City VARCHAR(250),
	@Province VARCHAR(250),
	@Message VARCHAR(250) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @IsActive BIT = 1,
			@DefaultDate DATETIME = GETDATE()
	
	BEGIN TRAN

	BEGIN TRY
	

		INSERT INTO Location.Cities
		(
			CityName, 
			CityIsActive, 
			UpdateDate, 
			ProvinceIdIdFK
		)
		VALUES(@City, @IsActive, @DefaultDate, (SELECT ProvinceId FROM Location.Provinces WHERE ProvinceDecription = @Province))
		
		SET @Message = ''

		COMMIT TRAN
	
	END TRY 
	BEGIN CATCH
		
		ROLLBACK TRAN

		SET @Message = 'Sorry cant insert data check store procedure '

	END CATCH 
	
	SET NOCOUNT OFF
END