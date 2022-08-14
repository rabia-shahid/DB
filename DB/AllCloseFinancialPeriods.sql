IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.AllCloseFinancialPeriods'))
drop procedure AllCloseFinancialPeriods
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[AllCloseFinancialPeriods]
(
@branchId int
)
As
BEGIN
	select * from financialclosing 
	where branchid=@branchId
	order by periodid desc 

END
