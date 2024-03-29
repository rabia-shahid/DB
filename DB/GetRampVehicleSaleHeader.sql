IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.GetRampVehicleSaleHeader'))
drop procedure GetRampVehicleSaleHeader
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetRampVehicleSaleHeader]
	@BranchId int,
	@RampNo int

AS

Begin

	if @RampNo <> -1
	Begin
		select * ,
		AllRampVehicles = STUFF(
                 (SELECT ',' + cast(R.rampno as varchar) +'*' +R.VehicleNo FROM RampSaleHeader R where r.BranchId=RSH.BranchId FOR XML PATH ('')), 1, 1, ''
               ) 
		from RampSaleHeader RSH
		where RSH.branchId=@BranchId
		and RSH.rampNo=@RampNo
	End
	else
	Begin
		select top 1 * ,
		AllRampVehicles = STUFF(
                 (SELECT ',' + cast(R.rampno as varchar) +'*' +R.VehicleNo FROM RampSaleHeader R where r.BranchId=RSH.BranchId FOR XML PATH ('')), 1, 1, ''
               ) 
		from RampSaleHeader RSH
		where RSH.branchId=@BranchId
		order by RampNo asc
	end
END