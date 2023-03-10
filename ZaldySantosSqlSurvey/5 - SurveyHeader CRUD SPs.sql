SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- INSERT survey data (user)
CREATE PROCEDURE usp_AddSurveyHeader
	@surveyId int,
	@participantId int
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM dbo.SurveyHeader WHERE surveyId = @surveyId AND participantId = @participantId AND flag = 0)
		BEGIN
			INSERT INTO dbo.SurveyHeader(surveyId,participantId) 
			VALUES(@surveyId,@participantId);
		END
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT survey data (user)
CREATE PROCEDURE usp_GetSurveyHeader 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM dbo.SurveyHeader WITH(NOLOCK)
	WHERE id = @id 
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- UPDATE survey data (user)
CREATE PROCEDURE usp_UpdateSurveyHeader 
	@id int,
	@surveyId int,
	@participantId int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyHeader
	SET surveyId = @surveyId
		,participantId = @participantId
	WHERE id = @id
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- flag survey data (user) as deleted (doesn't really delete, for history purposes)
CREATE PROCEDURE usp_DeleteSurveyHeader 
	@id int,
	@surveyId int,
	@participantId int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyHeader
	SET flag = 1
	WHERE id = (CASE WHEN @id = 0 THEN id ELSE @id END)
		AND surveyId = (CASE WHEN @surveyId = 0 THEN surveyId ELSE @surveyId END)
		AND participantId = (CASE WHEN @participantId = 0 THEN participantId ELSE @participantId END)
		AND flag = 0
END
GO;