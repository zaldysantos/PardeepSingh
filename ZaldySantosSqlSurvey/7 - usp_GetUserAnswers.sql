
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT survey answers
CREATE PROCEDURE usp_GetUserAnswers
	@surveyId int,
	@participantId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT i.title AS [Survey Title]
		,p.[name] AS [User Name]
		,q.question AS [Question]
		,d.answer AS [Answer]
	FROM dbo.SurveyDetails AS d
		LEFT OUTER JOIN dbo.SurveyInfo AS i ON i.id = @surveyId AND i.flag = 0
		LEFT OUTER JOIN dbo.SurveyQuestions AS q ON q.id = d.questionId AND q.flag = 0
		LEFT OUTER JOIN dbo.SurveyHeader AS h ON h.surveyId = @surveyId AND h.flag = 0
		LEFT OUTER JOIN dbo.Participants AS p ON p.id = (CASE WHEN @participantId = 0 THEN p.id ELSE @participantId END) AND p.flag = 0
	WHERE d.headerId = h.id
		AND d.flag = 0
	ORDER BY 2,1,3
END
GO
