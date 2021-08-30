USE Messanger
GO

CREATE PROC Location.spInsertCities
(
	@City VARCHAR(250),
	@Province VARCHAR(250),
	@Message VARCHAR(250) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
	DECLARE @IsActive BIT = 1,
			@DefaultDate DATETIME = GETDATE()

	INSERT INTO Location.Cities(CityName, CityIsActive, UpdateDate, ProvinceIdIdFK)
	VALUES(@City, @IsActive, @DefaultDate, (SELECT ProvinceId FROM Location.Provinces WHERE ProvinceDecription = @Province))
	
	SET @Message = ''
	END TRY 
	BEGIN CATCH
		
		SET @Message = 'Sorry cant insert data check store procedure '

	END CATCH 
END