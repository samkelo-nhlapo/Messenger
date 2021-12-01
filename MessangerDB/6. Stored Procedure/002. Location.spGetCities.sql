USE Messenger
GO

/****** Object:  StoredProcedure [Location].[spC]    Script Date: 29-Oct-21 05:18:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	02/08/2021
--	Description	Get Cities
--	TFS Task	Store Procedure 
--================================================================================================

CREATE OR ALTER PROC [Location].[spGetCities]
(
	@CityId INT = 0,
	@CityName VARCHAR(250) = ''
)
AS
BEGIN

	--IF EXISTS(SELECT 1 FROM Location.Cities WHERE CityName = @CityName)
	--BEGIN

		SELECT 
			CAST(CityID AS VARCHAR(1000)) AS CityID,
			CityName
		FROM Location.Cities 

	--END 

END
GO