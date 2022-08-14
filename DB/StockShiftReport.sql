IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.StockShiftReport'))
drop procedure StockShiftReport
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[StockShiftReport]
(
      @column varchar(10),
      @value varchar(10)
)
    As
Begin
	Select Date,Personname,Barcode,productid,productname,quantity,productprice,branchname From stockshiftrecord
	

End
