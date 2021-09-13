USE Messenger
GO

-- ============================================================================================
-- Author:        Samkelo Nhlapo
-- Create date:	  02/09/2021
-- Description:   Add UserNotification data
-- TFS Task:	  Create Registration Tables
-- ============================================================================================

INSERT INTO Auth.UserNotification(UserNotification, IsActive, UpdateDate)
VALUES
('User Contact details saved successfully.', 1, GETDATE()),
('User Contact details not successfully saved, please try re-enter again. If the problem continues, please contact support', 1, GETDATE()),
('No User Contact  details currently saved for ', 1, GETDATE()),
('Unable to get User Contact details, please try re-enter again. If the problem continues, please contact support.', 1, GETDATE()),
('User Contact details successfully updated', 1, GETDATE()),
('User contact details already exists please try again. If the problem continues. Please contact customer support', 1, GETDATE()),

--Address
('User Address details saved successfully.', 1, GETDATE()),
('User Address details not saved successfully, please try re-enter again. If the problem continues, please Address support', 1, GETDATE()),
('No User Address details currently saved for ', 1, GETDATE()),
('Unable to get User Address details, please try re-enter again. If the problem continues, please Address support.', 1, GETDATE()),
('User Address details successfully updated', 1, GETDATE()),

--Email
('User Email saved successfully.', 1, GETDATE()),
('User Email not successfully saved, please try re-enter again. If the problem continues, please contact support', 1, GETDATE()),
('No User email details currently saved for ', 1, GETDATE()),
('Unable to get Email details, please try re-enter again. If the problem continues, please contact support.', 1, GETDATE()),
('User Email details updated successfully ', 1, GETDATE()),
('User Email details already exists please try again. If the problem continues. Please contact customer support', 1, GETDATE()),

--Phone
('User Phone number saved successfully.', 1, GETDATE()),
('User Phone Number not successfully saved, please try re-enter again. If the problem continues, please contact support', 1, GETDATE()),
('No User Phone number currently saved for ', 1, GETDATE()),
('Unable to get Phone number , please try re-enter again. If the problem continues, please contact support.', 1, GETDATE()),
('User Phone number updated successfully ', 1, GETDATE()),
('User Phone number already exists please try again. If the problem continues. Please contact customer support', 1, GETDATE())