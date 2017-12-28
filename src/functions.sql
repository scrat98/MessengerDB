USE messenger
GO

-- Dialog
IF OBJECT_ID('getDialogsPage', N'IF' ) IS NOT NULL   
    DROP FUNCTION getDialogsPage
GO
CREATE FUNCTION dbo.getDialogsPage(@user_id int, @page_number int, @dialogs_per_page int)
RETURNS TABLE
AS
    RETURN (
        SELECT * FROM [dialog] WHERE [user_id] = @user_id
        ORDER BY [last_update] DESC
        OFFSET (@page_number - 1) * @dialogs_per_page ROWS
        FETCH NEXT @dialogs_per_page ROWS ONLY
    );
GO

IF OBJECT_ID('getDialogsCount', N'FN' ) IS NOT NULL   
    DROP FUNCTION getDialogsCount
GO
CREATE FUNCTION dbo.getDialogsCount(@user_id int)
RETURNS INT
AS
BEGIN
    DECLARE @dialogsCount INT;

    SET @dialogsCount = (SELECT COUNT(*)
    FROM dbo.[dialog]
    WHERE [user_id] = @user_id)

    RETURN @dialogsCount;
END
GO

-- Direct
IF OBJECT_ID('getDirectChatPage', N'IF' ) IS NOT NULL   
    DROP FUNCTION getDirectChatPage
GO
CREATE FUNCTION dbo.getDirectChatPage(@user_id int, @to_user_id int, @page_number int, @dialogs_per_page int)
RETURNS TABLE
AS
    RETURN (
        SELECT dbo.[message].[id], dbo.[message].[from_user_id], dbo.[message].[data], dbo.[message].[media_id], 
        dbo.[message].[create_date], dbo.[message].[modify_date]
        FROM (dbo.[direct_chat] JOIN dbo.[message] ON dbo.[direct_chat].[message_id] = dbo.[message].[id])
        WHERE dbo.[direct_chat].[user_id] = @user_id and dbo.[direct_chat].[to_user_id] = @to_user_id
        ORDER BY dbo.[message].[modify_date] DESC
        OFFSET (@page_number - 1) * @dialogs_per_page ROWS
        FETCH NEXT @dialogs_per_page ROWS ONLY
    );
GO

IF OBJECT_ID('getCountDirectChatMessages', N'FN' ) IS NOT NULL   
    DROP FUNCTION getCountDirectChatMessages
GO
CREATE FUNCTION dbo.getCountDirectChatMessages(@user_id int, @to_user_id int)
RETURNS INT
AS
BEGIN
    DECLARE @messagesCount INT;

    SET @messagesCount = (SELECT COUNT(*)
    FROM dbo.[direct_chat]
    WHERE [user_id] = @user_id and [to_user_id] = @to_user_id)

    RETURN @messagesCount;
END
GO

-- Conference
IF OBJECT_ID('getConferenceChatPage', N'IF' ) IS NOT NULL   
    DROP FUNCTION getConferenceChatPage
GO
CREATE FUNCTION dbo.getConferenceChatPage(@user_id int, @conference_id int, @page_number int, @dialogs_per_page int)
RETURNS TABLE
AS
    RETURN (
        SELECT dbo.[message].[id], dbo.[message].[from_user_id], dbo.[message].[data], dbo.[message].[media_id], 
        dbo.[message].[create_date], dbo.[message].[modify_date]
        FROM (dbo.[conference_chat] JOIN dbo.[message] ON dbo.[conference_chat].[message_id] = dbo.[message].[id])
        WHERE dbo.[conference_chat].[user_id] = @user_id and dbo.[conference_chat].[conference_id] = @conference_id
        ORDER BY dbo.[message].[modify_date] DESC
        OFFSET (@page_number - 1) * @dialogs_per_page ROWS
        FETCH NEXT @dialogs_per_page ROWS ONLY
    );
GO

IF OBJECT_ID('getCountConferenceMessages', N'FN' ) IS NOT NULL   
    DROP FUNCTION getCountConferenceMessages
GO
CREATE FUNCTION dbo.getCountConferenceMessages(@user_id int, @conference_id int)
RETURNS INT
AS
BEGIN
    DECLARE @messagesCount INT;

    SET @messagesCount = (SELECT COUNT(*)
    FROM dbo.[conference_chat]
    WHERE [user_id] = @user_id and [conference_id] = @conference_id)

    RETURN @messagesCount;
END
GO