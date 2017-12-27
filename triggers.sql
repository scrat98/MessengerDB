USE messenger
GO

-- Update Modify Date
CREATE TRIGGER UpdateModifyDateOnMedia
ON dbo.[media]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[media]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnUser
ON dbo.[user]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[user]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnConference
ON dbo.[conference]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[conference]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnDialog
ON dbo.[dialog]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[dialog]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnMessage
ON dbo.[message]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[message]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnUsersInConference
ON dbo.[users_in_conference]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[users_in_conference]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnConferenceChat
ON dbo.[conference_chat]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[conference_chat]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

CREATE TRIGGER UpdateModifyDateOnDirectChat
ON dbo.[direct_chat]
AFTER UPDATE
AS
BEGIN
    UPDATE dbo.[direct_chat]
    SET [modify_date] = GETDATE()
    WHERE [id] IN (SELECT DISTINCT id FROM Inserted)
END
GO

-- Direct Chat triggers

-- Conference Chat triggers