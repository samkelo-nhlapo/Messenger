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
	@Country VARCHAR(250) = '',
	@Message VARCHAR(250) OUTPUT
)
AS 
BEGIN
	
	IF EXISTS(SELECT 1 FROM Location.Countries WHERE CountryDescripition = @Country)
	BEGIN

		SELECT 
			CountryId, 
			CountryDescripition 
		FROM Location.Countries WHERE CountryDescripition = @Country

		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 40)
	
	END ELSE 
	BEGIN
		
		SET @Message = (SELECT UserNotification FROM Auth.UserNotification WITH(NOLOCK) WHERE UserNotificationID = 40)

	END

END
GO


