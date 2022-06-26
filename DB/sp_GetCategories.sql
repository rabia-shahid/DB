IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_GetCategories'))
drop procedure sp_GetCategories

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Get_Categories
-- Create date:	26/06/2022 
-- Description:	This stored procedure is intended to fetch product categories 
-- ==========================================================================================
CREATE PROCEDURE sp_GetCategories 

AS
BEGIN
Select Id, [Name] from Categories
END

