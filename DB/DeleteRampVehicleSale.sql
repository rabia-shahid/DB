USE [ilube]
GO
/****** Object:  StoredProcedure [dbo].[Account_Head_insert]    Script Date: 09/06/2022 10:40:44 pm ******/
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

