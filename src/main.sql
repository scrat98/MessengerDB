USE messenger
GO

DECLARE @user1 int
DECLARE @user2 int
DECLARE @user3 int

EXEC @user1 = dbo.addUser "login1", "pass1", "name1", "email1"
EXEC @user2 = dbo.addUser "login2", "pass2", "name2", "email2"
EXEC @user3 = dbo.addUser "login3", "pass3", "name3", "email3"
SELECT * FROM dbo.getUsers

EXEC dbo.sentMessageToUser 1, 2, "Hello"
EXEC dbo.sentMessageToUser 1, 2, "It's me"
EXEC dbo.sentMessageToUser 2, 1, "Nice to meet you"
EXEC dbo.sentMessageToUser 2, 1, "How are you?"
EXEC dbo.sentMessageToUser 2, 3, "Look, user1 he wrote to me! I love him ^_^"
EXEC dbo.sentMessageToUser 3, 1, "User 2 love you))"
EXEC dbo.sentMessageToUser 1, 3, "Oh, no! My wife is here. CU"
SELECT * FROM [dialog]
SELECT * FROM [direct_chat] JOIN [message] ON [direct_chat].message_id = [message].id
SELECT * FROM getDialogsPage(1, 1, 10)

DECLARE @conf int
EXEC @conf = dbo.createNewConference 3, "Lovely couple chat"
EXEC dbo.inviteUserToConference 3, 1, @conf
EXEC dbo.inviteUserToConference 3, 2, @conf
SELECT * FROM [conference]
SELECT * FROM [users_in_conference]

EXEC dbo.sentMessageToConference 3, @conf, "U r lovely couple))"
EXEC dbo.sentMessageToConference 2, @conf, "Idiot"
EXEC dbo.leaveFromConference 2, @conf
EXEC dbo.sentMessageToConference 1, @conf, "Idiot"
EXEC dbo.leaveFromConference 1, @conf
EXEC dbo.sentMessageToConference 3, @conf, "Oh, silly"
EXEC dbo.leaveFromConference 3, @conf

SELECT * FROM getDialogsPage(1, 1, 10)
SELECT * FROM getConferenceChatPage(1, @conf, 1, 10)

EXEC deleteAllMessagesFromConferenceChat 1, @conf
SELECT * FROM getDialogsPage(1, 1, 10)

SELECT * FROM [conference]
SELECT * FROM getMessages