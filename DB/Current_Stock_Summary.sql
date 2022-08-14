IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Current_Stock_Summary'))
drop procedure Current_Stock_Summary
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[Current_Stock_Summary]
    (
	  @branchId int
    )
As 
    Begin
       select SUM(cast(rsltr as decimal(18,0))*rspack) as TotalStocksalePrice, Sum(cast(rsctn as decimal(18,0))*rspack) as TotalStockPurchasePrice 
	   from OilProducts
	   where branchId=@branchId
	
    End
