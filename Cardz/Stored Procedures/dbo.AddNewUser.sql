CREATE PROCEDURE [dbo].[AddNewUser]
	@pUsername NVARCHAR(50),
	@pPassword NVARCHAR(50),
	@pDisplayName NVARCHAR(50),
	@response NVARCHAR(250) OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @salt UNIQUEIDENTIFIER=NEWID()
	BEGIN TRY

	INSERT INTO dbo.[User] (Username, PasswordHash, Salt, DisplayName)
	VALUES(@pUsername, HASHBYTES('SHA2_512', @pPassword+CAST(@salt AS NVARCHAR(36))), @salt, @pDisplayName)
	
	SET @response='Success'

	END TRY
	BEGIN CATCH
		SET @response=ERROR_MESSAGE()
	END CATCH
END
