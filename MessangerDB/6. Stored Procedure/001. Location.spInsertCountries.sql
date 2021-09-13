USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Insert Countries Proc
--	TFS Task	Insert Into Table
--================================================================================================

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
	
	SET NOCOUNT ON

	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsActive BIT = 0
	
	BEGIN TRAN

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

			SET @Message = ''

			COMMIT TRAN

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

			COMMIT TRAN

		END
	END
	ELSE
	BEGIN
		
		ROLLBACK TRAN

		SET @Message = 'Error inserting the Countries please check stored procedure'

	END

	SET NOCOUNT OFF

END