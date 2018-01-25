USE messenger
GO

CREATE TRIGGER CheckPasswordOnUserModify
ON dbo.[user]
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @pass VARCHAR(255)

    SELECT @pass = [password] FROM inserted

    if (LEN(@pass) < 6)
        rollback tran

    if (@pass LIKE '%[^a-zA-Z0-9]%')
        rollback tran

    DECLARE @k1 INT
    DECLARE @k2 INT
    SET @k2 = 0
    SET @k1 = 0

    declare @i int
    SET @i = 0
    DECLARE @ch CHAR

    while @i <= LEN(@pass)
    begin
        SET @i = @i + 1

        select @ch = substring(@pass, @i, 1)

        IF (ascii(@ch) > 64 AND ascii(@ch) < 91)
            SET @k1 = @k1 + 1;

--         if (@ch LIKE '%[A-Z]%')
--             SET @k1 = @k1 + 1

        if (@ch LIKE '%[0-9]%')
            SET @k2 = @k2 + 1
    end

    if (@k1 < 2 OR @k2 < 1)
        rollback tran
END
GO