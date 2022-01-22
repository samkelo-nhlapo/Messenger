USE Messenger
GO

--================================================================================================
--	Author:		Samkelo Nhlapo
--	Create date	22/01/2022
--	Description	Phone number Function
--	TFS Task	Ensure Phone number format has - between numbers
--================================================================================================

CREATE FUNCTION Contacts.FormatPhoneNumber
(
	@phoneNumber VARCHAR(10)
)
RETURNS 
	VARCHAR(12)
BEGIN
    RETURN SUBSTRING(@phoneNumber, 1, 3) + '-' + 
           SUBSTRING(@phoneNumber, 4, 3) + '-' + 
           SUBSTRING(@phoneNumber, 7, 4)
END
