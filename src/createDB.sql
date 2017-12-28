IF EXISTS (SELECT name 
FROM master.dbo.sysdatabases
WHERE name = 'messenger')
BEGIN
	DROP DATABASE messenger;
END
GO

CREATE DATABASE messenger;
GO

USE messenger
GO

CREATE TABLE messenger.dbo.[media] (
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[src] varchar(255) NOT NULL,
		[create_date] datetime DEFAULT GETDATE(),
		[modify_date] datetime DEFAULT GETDATE()
		)
GO
SET IDENTITY_INSERT dbo.[media] ON
INSERT INTO [media] ([id], [src]) VALUES(0, '')
SET IDENTITY_INSERT dbo.[media] OFF

CREATE TABLE messenger.dbo.[user] (
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[login] varchar(255) NOT NULL UNIQUE,
		[password] varchar(255) NOT NULL,
		[name] varchar(255) NOT NULL,
		[user_img] int NOT NULL FOREIGN KEY REFERENCES [media](id) DEFAULT 0,
		[git] varchar(255) NOT NULL DEFAULT '',
		[skype] varchar(255) NOT NULL DEFAULT '',
		[phone] varchar(255) NOT NULL DEFAULT '',
		[email] varchar(255) NOT NULL UNIQUE,
		[user_p_1] varchar(255) NOT NULL DEFAULT '',
		[user_p_2] varchar(255) NOT NULL DEFAULT '',
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO
SET IDENTITY_INSERT dbo.[user] ON
INSERT INTO [user] ([id], [login], [password], [name], [email]) 
VALUES(0, 'notification', 'notification', 'notification', 'notification')
SET IDENTITY_INSERT dbo.[user] OFF

CREATE TABLE messenger.dbo.[message](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[from_user_id] int FOREIGN KEY REFERENCES [user](id) DEFAULT 0,
		[data] text NOT NULL,
		[media_id] int NOT NULL FOREIGN KEY REFERENCES [media](id) DEFAULT 0,
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

CREATE TABLE messenger.dbo.[dialog](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[user_id] int NOT NULL FOREIGN KEY REFERENCES [user](id),
		[chat_code] varchar(255) NOT NULL,
		[last_message_id] int FOREIGN KEY REFERENCES [message](id),
		[last_update] datetime,
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

CREATE TABLE messenger.dbo.[conference](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[name] varchar(255) NOT NULL,
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

CREATE TABLE messenger.dbo.[users_in_conference](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[conference_id] INT NOT NULL FOREIGN KEY REFERENCES [conference](id),
		[user_id] INT NOT NULL FOREIGN KEY REFERENCES [user](id),
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

CREATE TABLE messenger.dbo.[direct_chat](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[user_id] INT NOT NULL FOREIGN KEY REFERENCES [user](id), 
		[to_user_id] INT NOT NULL FOREIGN KEY REFERENCES [user](id),
		[message_id] INT NOT NULL FOREIGN KEY REFERENCES [message](id),
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

CREATE TABLE messenger.dbo.[conference_chat](
		[id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		[user_id] INT NOT NULL FOREIGN KEY REFERENCES [user](id), 
		[conference_id] INT NOT NULL FOREIGN KEY REFERENCES [conference](id),
		[message_id] INT NOT NULL FOREIGN KEY REFERENCES [message](id),
		[create_date] datetime DEFAULT GETDATE(),
        [modify_date] datetime DEFAULT GETDATE()
		)
GO

SELECT * FROM messenger.dbo.[user]
GO

SELECT * FROM messenger.dbo.[media]
GO

SELECT * FROM messenger.dbo.[dialog]
GO

SELECT * FROM messenger.dbo.[conference]
GO

SELECT * FROM messenger.dbo.[users_in_conference]
GO

SELECT * FROM messenger.dbo.[message]
GO

SELECT * FROM messenger.dbo.[direct_chat]
GO

SELECT * FROM messenger.dbo.[conference_chat]
GO