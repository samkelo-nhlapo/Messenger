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
	

	IF EXISTS(SELECT 1 FROM Location.Countries WHERE CountryDescripition = @Country )
	BEGIN

		SELECT 
			CAST(CountryId AS VARCHAR(1000)) AS CountryId, 
			CountryDescripition 
		FROM Location.Countries 
	
	END 
END
GO


