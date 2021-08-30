USE Messanger
GO

CREATE OR ALTER PROC Location.spInsertCountries
(
	@Country VARCHAR(250),
	@Alpha2Code VARCHAR(250),
	@Alpha3Code VARCHAR(250),
	@Numeric INT,
	@Message VARCHAR(250) OUTPUT
)
AS 
BEGIN
	
	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsActive BIT = 0


	IF NOT EXISTS(SELECT * FROM Location.Countries WHERE CountryDescripition = @Country )
	BEGIN
		
		IF (@Country = 'South Africa')
		BEGIN
			
			SET @IsActive = 1

			INSERT INTO Location.Countries
			(
				CountryDescripition, 
				CountryAlph2Code, 
				CountryAlph3Code, 
				CountryNumeric, 
				CountryIsActive, 
				UpdateDate
			)
			VALUES(@Country, @Alpha2Code, @Alpha3Code, @Numeric, @IsActive, @DefaultDate )

		END ELSE
		BEGIN

			INSERT INTO Location.Countries
			(
				CountryDescripition, 
				CountryAlph2Code, 
				CountryAlph3Code, 
				CountryNumeric, 
				CountryIsActive, 
				UpdateDate
			)
			VALUES(@Country, @Alpha2Code, @Alpha3Code, @Numeric, @IsActive, @DefaultDate )
			
			SET @Message = ''

		END
	END
	ELSE
	BEGIN
		
		SET @Message = 'Error with inserting the code please check stored procedure'

	END

END