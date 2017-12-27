use messenger
go

DECLARE @result int;  
EXEC @result = dbo.addUser "login", "pass", "name", "email"
PRINT @result

SELECT * FROM getDialogsPage(1, 1, 10)