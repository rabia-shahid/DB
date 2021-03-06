IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Vehicle_SelectAll_Name'))
drop procedure Vehicle_SelectAll_Name
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Vehicle_SelectAll_Name]
(
	@vehicleNo varchar(100),
	@branchid int,
	@page varchar(30)='sale'
)
As
Begin
	if @page ='sale'
	Begin
		Select *
		From carinfo CI
		where [carnumber] like '%'+ @vehicleno +'%' and branchid = @branchid
		and Not Exists (select 1 from RampSaleHeader RSH where RSH.BranchId=CI.branchId and RSH.VehicleNo=CI.carnumber)
	End
	else
	Begin
		Select *
		From carinfo CI
		where [carnumber] like '%'+ @vehicleno +'%' and branchid = @branchid
	End
End
