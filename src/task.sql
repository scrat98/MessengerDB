create view dbo.vRandomNumber
as
  select rand() as RandomNumber
go

IF OBJECT_ID('getRandomPassword', N'FN' ) IS NOT NULL   
    DROP FUNCTION getRandomPassword
GO
CREATE FUNCTION dbo.getRandomPassword(@length int)
RETURNS VARCHAR(255)
AS
BEGIN
    IF @length < 6 SET @length = 6

    DECLARE @alphabet VARCHAR(52) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    DECLARE @numbers VARCHAR(10) = '0123456789'
    DECLARE @pass VARCHAR(255) = ''
    DECLARE @rndCh VARCHAR(1)
    DECLARE @pos INT
    DECLARE @rnd REAL

    WHILE (LEN(@pass) < 3)
    BEGIN
    	SELECT @rnd = RandomNumber FROM dbo.vRandomNumber
        SELECT @pos = convert(int, @rnd * 52)
        SET @pass = CONCAT(@pass, substring(@alphabet, @pos, 1));
    END

    WHILE (LEN(@pass) < 6)
    BEGIN
        SELECT @rnd = RandomNumber FROM dbo.vRandomNumber
        SELECT @pos = convert(int, @rnd * 10)
        SET @pass = CONCAT(@pass, substring(@numbers, @pos, 1));
    END

    WHILE (LEN(@pass) < @length)
    BEGIN
        SELECT @rnd = RandomNumber FROM dbo.vRandomNumber
        SELECT @pos = convert(int, @rnd * 255)
        SELECT @rndCh = CHAR(@pos)
        SET @pass = CONCAT(@pass, @rndCh);
    END

    RETURN @pass;
END
GO

CREATE TRIGGER CheckPhoneOnUserModify
ON dbo.[user]
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT COUNT(phone) FROM inserted WHERE phone NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') > 0
    BEGIN
        rollback tran
    END
END
GO