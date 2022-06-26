IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.AddUpdateRampVehicleSaleHeader'))
drop procedure AddUpdateRampVehicleSaleHeader
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AddUpdateRampVehicleSaleHeader]
	@BranchId int,
	@RampNo int,
	@VehicleNo varchar(100), 
	@VehicleName varchar(100), 
	@OilMilage numeric(8,2)=null, 
	@CurrentMilage numeric(8,2) =null, 
	@DueMilage numeric(8,2) =null, 
	@AverageMilage numeric (8, 2) =null, 
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

