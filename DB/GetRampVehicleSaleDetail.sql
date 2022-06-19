USE [ilube]
GO
/****** Object:  StoredProcedure [dbo].[Account_Head_insert]    Script Date: 09/06/2022 10:40:44 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetRampVehicleSaleDetail]
	@SaleHeaderId int

AS

Begin

	select OP.id as ProductId,RSD.saleQuantity as saleQuantity,op.code,op.name, op.Qty ,rsctn,packing,apigrade
	from RampSaleDetail RSD
	inner join OilProducts OP on RSD.BarCode=OP.code
	where SaleHeaderId=@SaleHeaderId
END

