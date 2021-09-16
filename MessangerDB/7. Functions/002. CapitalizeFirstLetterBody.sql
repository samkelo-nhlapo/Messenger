USE [Messenger]
GO

/****** Object:  UserDefinedFunction [dbo].[CapitalizeFirstLetter]    Script Date: 16-Sep-21 11:37:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
===============================================================================
		Author:			  Samkelo Nhlapo
		Create date:	  16/09/2021
		Description:      Function to capitalise first letter in Message Body data
		TFS Task:	      Create function
================================================================================
*/

CREATE OR ALTER   FUNCTION [dbo].[CapitalizeFirstLetterBody]
(
	@InputString VARCHAR (MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN

	DECLARE @Index          INT,
			@Char           CHAR(1),
			@PrevChar       CHAR(1),
			@OutputString   VARCHAR(MAX)
	
	SET @OutputString = LOWER(@InputString)
	SET @Index = 1
	
		WHILE @Index <= LEN(@InputString)
		BEGIN
		    SET @Char     = SUBSTRING(@InputString, @Index, 1)
		    SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
		                         ELSE SUBSTRING(@InputString, @Index - 1, 1)
		                    END
		
		    IF @PrevChar IN (';', ':', '!', '?', ',', '.', '_', '-', '/', '&', '''', '(')
		    BEGIN
		        IF @PrevChar != '''' 
		            SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char))
		    END
		
		    SET @Index = @Index + 1
		END
	
	RETURN @OutputString
	

END
GO