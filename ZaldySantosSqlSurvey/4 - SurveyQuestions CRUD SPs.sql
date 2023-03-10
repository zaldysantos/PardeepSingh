SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- INSERT question item
CREATE PROCEDURE usp_AddSurveyQuestion
	@surveyId int,
	@question nvarchar(max),
	@choice1 nvarchar(max),
	@choice2 nvarchar(max),
	@choice3 nvarchar(max),
	@choice4 nvarchar(max),
	@choice5 nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.SurveyQuestion(surveyId,question,choice1,choice2,choice3,choice4,choice5) 
	VALUES(@surveyId,@question,@choice1,@choice2,@choice3,@choice4,@choice5);
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT all question items
CREATE PROCEDURE usp_GetSurveyQuestions 
	@surveyId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM dbo.SurveyQuestions WITH(NOLOCK)
	WHERE surveyId = @surveyId 
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- UPDATE question item
CREATE PROCEDURE usp_UpdateSurveyQuestion 
	@id int,
	@question nvarchar(max),
	@choice1 nvarchar(max),
	@choice2 nvarchar(max),
	@choice3 nvarchar(max),
	@choice4 nvarchar(max),
	@choice5 nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyQuestions
	SET question = @question
		,choice1 = @choice1
		,choice2 = @choice2
		,choice3 = @choice3
		,choice4 = @choice4
		,choice5 = @choice5
	WHERE id = @id
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- flag question item as deleted (doesn't really delete, for history purposes)
CREATE PROCEDURE usp_DeleteSurveyQuestion 
	@id int,
	@surveyId int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyQuestions
	SET flag = 1
	WHERE id = (CASE WHEN @id = 0 THEN id ELSE @id END)
		AND surveyId = (CASE WHEN @surveyId = 0 THEN surveyId ELSE @surveyId END)
		AND flag = 0
END
GO;