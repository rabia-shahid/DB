IF  EXISTS (SELECT * FROM sys.objects WHERE   OBJECT_ID = OBJECT_ID('dbo.Split'))
drop function Split
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.Split
(
  @List      nvarchar(max),
  @Delimiter nchar(1)
)
RETURNS @t table (Item nvarchar(max))
AS
BEGIN
  SET @List += @Delimiter;
  ;WITH a(f,t) AS  
  (
    SELECT CAST(1 AS bigint), CHARINDEX(@Delimiter, @List)
    UNION ALL
    SELECT t + 1, CHARINDEX(@Delimiter, @List, t + 1) 
    FROM a WHERE CHARINDEX(@Delimiter, @List, t + 1) > 0
  )  
  INSERT @t SELECT SUBSTRING(@List, f, t - f) FROM a OPTION (MAXRECURSION 0);
  RETURN;  
END
GO	