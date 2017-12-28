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
CREATE TRIGGER TriggerForDeleteMessageFromDirectChat
ON dbo.[direct_chat]
AFTER DELETE
AS
BEGIN
    DECLARE @user_id int
    DECLARE @to_user_id int
    DECLARE @chat_code varchar(255)

    SET @user_id = (SELECT DISTINCT [user_id] FROM deleted)
    SET @to_user_id = (SELECT DISTINCT [to_user_id] FROM deleted)
    SET @chat_code = CONCAT('u', @to_user_id)

    IF NOT EXISTS (
        SELECT * FROM [direct_chat] 
        WHERE [user_id] = @user_id AND [to_user_id] = @to_user_id)
    BEGIN
        DELETE FROM [dialog]
        WHERE [user_id] = @user_id AND [chat_code] = @chat_code 
    END ELSE
    BEGIN
        DECLARE @last_update datetime
        DECLARE @message_id int

        SELECT @last_update = [modify_date], @message_id = [id]
        FROM dbo.getDirectChatPage(@user_id, @to_user_id, 1, 1)

        UPDATE [dialog]
        SET 
            [last_update] = @last_update,
            [last_message_id] = @message_id
	    WHERE [user_id] = @user_id AND [chat_code] = @chat_code
    END
END
GO

CREATE TRIGGER TriggerForAddMessageInDirectChat
ON dbo.[direct_chat]
AFTER INSERT
AS
BEGIN
    DECLARE @user_id int
    DECLARE @to_user_id int
    DECLARE @chat_code varchar(255)
    DECLARE @message_id int
    DECLARE @last_update datetime

    SET @user_id = (SELECT DISTINCT [user_id] FROM Inserted)
    SET @to_user_id = (SELECT DISTINCT [to_user_id] FROM Inserted)
    SET @chat_code = CONCAT('u', @to_user_id)
    SET @message_id = (SELECT DISTINCT [message_id] FROM Inserted)
    SET @last_update = (SELECT [modify_date] FROM dbo.[message] WHERE [id] = @message_id)

    IF NOT EXISTS (
        SELECT * FROM [dialog]
        WHERE [user_id] = @user_id AND [chat_code] = @chat_code)
    BEGIN
        INSERT INTO [dialog]
        ([user_id], [chat_code], [last_update], [last_message_id])
        VALUES
        (@user_id, @chat_code, @last_update, @message_id)
    END

    UPDATE [dialog]
    SET 
        [last_update] = @last_update,
        [last_message_id] = @message_id
	WHERE [user_id] = @user_id AND [chat_code] = @chat_code
END
GO

-- Conference Chat triggers
CREATE TRIGGER TriggerForDeleteMessageFromConferenceChat
ON dbo.[conference_chat]
AFTER DELETE
AS
BEGIN
    DECLARE @user_id int
    DECLARE @conference_id int
    DECLARE @chat_code varchar(255)

    SET @user_id = (SELECT DISTINCT [user_id] FROM deleted)
    SET @conference_id = (SELECT DISTINCT [conference_id] FROM deleted)
    SET @chat_code = CONCAT('c', @conference_id)

    IF NOT EXISTS (
        SELECT * FROM [conference_chat] 
        WHERE [user_id] = @user_id AND [conference_id] = @conference_id)
    BEGIN
        DELETE FROM [dialog]
        WHERE [user_id] = @user_id AND [chat_code] = @chat_code 
    END ELSE
    BEGIN
        DECLARE @last_update datetime
        DECLARE @message_id int

        SELECT @last_update = [modify_date], @message_id = [id]
        FROM dbo.getConferenceChatPage(@user_id, @conference_id, 1, 1)

        UPDATE [dialog]
        SET 
            [last_update] = @last_update,
            [last_message_id] = @message_id
	    WHERE [user_id] = @user_id AND [chat_code] = @chat_code
    END
END
GO

CREATE TRIGGER TriggerForAddMessageInConferenceChat
ON dbo.[conference_chat]
AFTER INSERT
AS
BEGIN
    DECLARE @user_id int
    DECLARE @conference_id int
    DECLARE @chat_code varchar(255)
    DECLARE @message_id int
    DECLARE @last_update datetime

    SET @user_id = (SELECT DISTINCT [user_id] FROM Inserted)
    SET @conference_id = (SELECT DISTINCT [conference_id] FROM Inserted)
    SET @chat_code = CONCAT('c', @conference_id)
    SET @message_id = (SELECT DISTINCT [message_id] FROM Inserted)
    SET @last_update = (SELECT [modify_date] FROM dbo.[message] WHERE [id] = @message_id)

    IF NOT EXISTS (
        SELECT * FROM [dialog]
        WHERE [user_id] = @user_id AND [chat_code] = @chat_code)
    BEGIN
        INSERT INTO [dialog]
        ([user_id], [chat_code], [last_update], [last_message_id])
        VALUES
        (@user_id, @chat_code, @last_update, @message_id)
    END

    UPDATE [dialog]
    SET 
        [last_update] = @last_update,
        [last_message_id] = @message_id
	WHERE [user_id] = @user_id AND [chat_code] = @chat_code
END
GO