USE messenger
GO

CREATE OR ALTER VIEW getMessages
AS
SELECT * FROM dbo.[message]
GO

CREATE OR ALTER VIEW getMedia
AS
SELECT * FROM dbo.[media]
GO

CREATE OR ALTER VIEW getUsers
AS
SELECT * FROM dbo.[user]
GO