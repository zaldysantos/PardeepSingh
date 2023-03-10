SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- INSERT survey info
CREATE PROCEDURE usp_AddSurveyInfo
	@title nvarchar(50),
	@description nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.SurveyInfo(title,[description]) 
	VALUES(@title,@description);
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT survey info
CREATE PROCEDURE usp_GetSurveyInfo 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM dbo.SurveyInfo WITH(NOLOCK)
	WHERE id = (CASE WHEN @id = 0 THEN id ELSE @id END) 
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- UPDATE survey info
CREATE PROCEDURE usp_UpdateSurveyInfo 
	@id int,
	@title nvarchar(50),
	@description nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyInfo 
	SET title = @title
		,[description] = @description
	WHERE id = @id
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- flag survey info as deleted (doesn't really delete, for history purposes)
CREATE PROCEDURE usp_DeleteSurveyInfo 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyInfo 
	SET flag = 1
	WHERE id = @id
		AND flag = 0;
END
GO;