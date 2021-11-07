USE [Messenger]
GO

/****** Object:  StoredProcedure [Location].[spC]    Script Date: 29-Oct-21 05:18:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Select Countries Procedure
--	TFS Task	Select Into Table
--================================================================================================

CREATE OR ALTER PROC [Location].[spGetCountries]
(
	@CountryId INT = 0,
	@Country VARCHAR(250) = ''
	
)
AS 
BEGIN
	
	DECLARE @DefaultDate DATETIME = GETDATE(),
			@IsActive BIT = 0,
			@ErrorSchema VARCHAR(MAX),
			@ErrorProc VARCHAR(MAX),
			@ErrorNumber VARCHAR(MAX),
			@ErrorState VARCHAR(MAX),
			@ErrorSeverity VARCHAR(MAX),
			@ErrorLine VARCHAR(MAX),
			@ErrorMessage VARCHAR(MAX),
			@ErrorDate DATETIME
	

	IF EXISTS(SELECT 1 FROM Location.Countries WHERE CountryDescripition = @Country )
	BEGIN

		SELECT 
			CAST(CountryId AS VARCHAR(1000)) AS CountryId, 
			CountryDescripition 
		FROM Location.Countries 
	
	END ELSE
	BEGIN
		
		SET @ErrorSchema = OBJECT_SCHEMA_NAME(@@PROCID)
		SET @ErrorProc = OBJECT_NAME(@@PROCID)
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorLine = ERROR_LINE()
		SET @ErrorMessage = ERROR_MESSAGE()

		EXEC Auth.spLogExceptions @ErrorSchema,@ErrorProc,@ErrorNumber,@ErrorState,@ErrorSeverity,@ErrorLine,@ErrorMessage,@DefaultDate,42

	END
END
GO


