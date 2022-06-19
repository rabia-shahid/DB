IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.DeleteRampVehicleSale'))
drop procedure DeleteRampVehicleSale
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[DeleteRampVehicleSale]
	@RampNo int,
	@BranchId int

AS

Begin

	delete D
	from RampSaleDetail D
	inner join RampSaleHeader H on D.SaleHeaderId = H.SaleHeaderId
	where H.RampNo=@RampNo and H.BranchId= @BranchId

	delete H
	from RampSaleHeader H
	where H.RampNo=@RampNo and H.BranchId= @BranchId
	
END

