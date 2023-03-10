SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- INSERT survey data (answer)
CREATE PROCEDURE usp_AddSurveyDetail
	@headerId int,
	@questionId int,
	@answer int
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM dbo.SurveyDetails WHERE headerId = @headerId AND questionId = @questionId AND flag = 0)
		BEGIN
			INSERT INTO dbo.SurveyDetails(headerId,questionId,answer) 
			VALUES(@headerId,@questionId,@answer);
		END
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT survey data (answer)
CREATE PROCEDURE usp_GetSurveyDetail
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * 
	FROM dbo.SurveyDetails WITH(NOLOCK)
	WHERE id = @id 
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- flag survey data (answer) as deleted (doesn't really delete, for history purposes)
CREATE PROCEDURE usp_UpdateSurveyDetail 
	@id int,
	@headerId int,
	@questionId int,
	@answer int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyDetails
	SET headerId = @headerId
		,questionId = @questionId
		,answer = @answer
	WHERE id = @id
		AND flag = 0;
END
GO;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE usp_DeleteSurveyDetail 
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.SurveyDetails
	SET flag = 1
	WHERE id = @id
		AND flag = 0
END
GO;