USE messenger
GO

-- Media
IF OBJECT_ID('deleteMediaById', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteMediaById
GO
CREATE PROCEDURE dbo.deleteMediaById
	@id int
AS
BEGIN
	DELETE FROM [media] WHERE id = @id
END
GO

IF OBJECT_ID('addMedia', 'P' ) IS NOT NULL   
    DROP PROCEDURE addMedia
GO
CREATE PROCEDURE dbo.addMedia
	@src varchar(255)
AS
BEGIN
	INSERT INTO [media]
	([src])
	VALUES
	(@src)

	RETURN IDENT_CURRENT('media')
END
GO

-- User
IF OBJECT_ID('addUser', 'P' ) IS NOT NULL   
    DROP PROCEDURE addUser
GO
CREATE PROCEDURE dbo.addUser
	@login varchar(255),
    @password varchar(255),
	@name varchar(255),
	@email varchar(255)
AS
BEGIN
	INSERT INTO [user]
	([login], [password], [name], [email])
	VALUES
	(@login, @password, @name, @email)

	RETURN IDENT_CURRENT('user')
END
GO

IF OBJECT_ID('deleteUserById', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteUserById
GO
CREATE PROCEDURE dbo.deleteUserById
	@id int
AS
BEGIN
	DELETE FROM [user] WHERE id = @id
END
GO

IF OBJECT_ID('changeUserById', 'P' ) IS NOT NULL   
    DROP PROCEDURE changeUserById
GO
CREATE PROCEDURE dbo.changeUserById
	@id int,
	@login varchar(255),
	@password varchar(255),
	@name varchar(255),
	@user_img int,
	@git varchar(255),
	@skype varchar(255),
	@phone varchar(255),
	@email varchar(255),
	@user_p_1 varchar(255),
	@user_p_2 varchar(255)
AS
BEGIN
	UPDATE [user]
	SET [login] = @login,
		[password] = @password,
		[name] = @name,
		[user_img] = @user_img,
		[git] = @git,
		[skype] = @skype,
		[phone] = @phone,
		[email] = @email,
		[user_p_1] = @user_p_1,
		[user_p_2] = @user_p_2
	WHERE id = @id
END
GO

-- Direct
IF OBJECT_ID('deleteMessageFromDirectChat', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteMessageFromDirectChat
GO
CREATE PROCEDURE dbo.deleteMessageFromDirectChat
	@user_id int,
    @to_user_id int,
	@message_id int
AS
BEGIN
	DELETE FROM dbo.[direct_chat] 
	WHERE [user_id] = @user_id AND [to_user_id] = @to_user_id AND [message_id] = @message_id
END
GO

IF OBJECT_ID('deleteAllMessagesFromDirectChat', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteAllMessagesFromDirectChat
GO
CREATE PROCEDURE dbo.deleteAllMessagesFromDirectChat
	@user_id int,
    @to_user_id int
AS
BEGIN
	DELETE FROM dbo.[direct_chat] 
	WHERE [user_id] = @user_id AND [to_user_id] = @to_user_id
END
GO

-- Conference
IF OBJECT_ID('deleteMessageFromConferenceChat', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteMessageFromConferenceChat
GO
CREATE PROCEDURE dbo.deleteMessageFromConferenceChat
	@user_id int,
    @conference_id int,
	@message_id int
AS
BEGIN
	DELETE FROM dbo.[conference_chat] 
	WHERE [user_id] = @user_id AND [conference_id] = @conference_id AND [message_id] = @message_id
END
GO

IF OBJECT_ID('deleteAllMessagesFromConferenceChat', 'P' ) IS NOT NULL   
    DROP PROCEDURE deleteAllMessagesFromConferenceChat
GO
CREATE PROCEDURE dbo.deleteAllMessagesFromConferenceChat
	@user_id int,
    @conference_id int
AS
BEGIN
	DELETE FROM dbo.[conference_chat] 
	WHERE [user_id] = @user_id AND [conference_id] = @conference_id
END
GO

-- joinToConference : procedure
-- leaveConference : procedure
-- newConference : procedure
-- inviteToConference : procedure

-- Sent Message
IF OBJECT_ID('sentMessageToUser', 'P' ) IS NOT NULL   
    DROP PROCEDURE sentMessageToUser
GO
CREATE PROCEDURE dbo.sentMessageToUser
	@user_id int,
    @to_user_id int,
	@data text,
	@media_id int
AS
BEGIN
	DECLARE @messageId int;

	INSERT INTO [message]
	([from_user_id], [data], [media_id])
	VALUES
	(@user_id, @data, @media_id)
	SET @messageId = IDENT_CURRENT('message');


END
GO

-- sentMessageToConference(user_id, conference_id, data, media_id) : procedure