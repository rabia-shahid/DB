IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.GetRampVehicleSaleDetail'))
drop procedure GetRampVehicleSaleDetail
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetRampVehicleSaleDetail]
	@SaleHeaderId int

AS

Begin

	select OP.id as ProductId,RSD.saleQuantity as saleQuantity,op.code,op.name, op.Qty, rsltr,rsctn,packing,apigrade,OP.isThirdScheduleOrder
	from RampSaleDetail RSD
	inner join OilProducts OP on RSD.BarCode=OP.code
	where SaleHeaderId=@SaleHeaderId
END

