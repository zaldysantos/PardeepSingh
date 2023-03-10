SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- INSERT user
CREATE PROCEDURE usp_AddParticipant 
	@name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.Participants([name]) 
	VALUES(@name);
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT user
CREATE PROCEDURE usp_GetParticipant 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM dbo.Participants WITH(NOLOCK)
	WHERE id = (CASE WHEN @id = 0 THEN id ELSE @id END) 
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- UPDATE user
CREATE PROCEDURE usp_UpdateParticipant 
	@id int,
	@name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.Participants 
	SET [name] = @name
	WHERE id = @id
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- flag user as deleted (doesn't really delete, for history purposes)
CREATE PROCEDURE usp_DeleteParticipant 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.Participants 
	SET flag = 1
	WHERE id = @id
		AND flag = 0;
END
GO; 