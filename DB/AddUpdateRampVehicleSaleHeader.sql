USE [ilube]
GO
/****** Object:  StoredProcedure [dbo].[GetRampVehicleSaleHeader]    Script Date: 11/06/2022 3:51:01 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter procedure [dbo].[AddUpdateRampVehicleSaleHeader]
	@BranchId int,
	@RampNo int,
	@VehicleNo varchar(100), 
	@VehicleName varchar(100), 
	@OilMilage numeric(8,2), 
	@CurrentMilage numeric(8,2), 
	@DueMilage numeric(8,2), 
	@AverageMilage numeric (8, 2), 
	@NextDate varchar(30), 
	@Worker varchar(100), 
	@CustomerName varchar(100), 
	@CustomerPhoneNo varchar(100)

AS

Begin

	if Not Exists (Select 1 from RampSaleHeader where RampNo = @RampNo and BranchId=@BranchId)
	Begin
		Insert into RampSaleHeader (BranchId, RampNo, VehicleNo, VehicleName, OilMilage, CurrentMilage, DueMilage, AverageMilage, NextDate, Worker, CustomerName, CustomerPhoneNo)
		values (@BranchId, @RampNo, @VehicleNo, @VehicleName, @OilMilage, @CurrentMilage,@DueMilage, @AverageMilage, @NextDate, @Worker, @CustomerName, @CustomerPhoneNo)
	End
	else
	Begin
		update RampSaleHeader
		set vehicleNo=@VehicleNo, 
		VehicleName=@VehicleName, 
		OilMilage=@OilMilage, 
		CurrentMilage=@CurrentMilage, 
		DueMilage= @dueMilage,
		AverageMilage=@AverageMilage, 
		NextDate=@NextDate, 
		Worker=@Worker, 
		CustomerName=@CustomerName, 
		CustomerPhoneNo=@CustomerPhoneNo
		where RampNo = @RampNo
		and BranchId=@BranchId
	End
END

