USE Messenger
GO

/****** Object:  StoredProcedure [Location].[spC]    Script Date: 29-Oct-21 05:18:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	25/10/2021
--	Description	Get Provinces Procedure
--	TFS Task	Get Province Table
--================================================================================================

CREATE OR ALTER PROC [Location].[spGetProvinces]
(
	@ProvinceId	INT = 0,
	@ProvinceName VARCHAR(250) = ''
)
AS 
BEGIN

	IF EXISTS(SELECT 1 FROM Location.Provinces WHERE ProvinceDecription = @ProvinceName)
	BEGIN

		SELECT 
			CAST(ProvinceId AS VARCHAR(1000)) AS ProvinceId,
			ProvinceDecription 
		FROM Location.Provinces 

	END 

END
GO