IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Vehicle_SelectAll_All'))
drop procedure Vehicle_SelectAll_All
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================================
-- Entity Name:	Vehicle_SelectAll_All 
-- Description:	This stored procedure is intended to get all vehicles
-- ==========================================================================================

CREATE procedure [dbo].[Vehicle_SelectAll_All]
(
	@branchid int,
	@page varchar(30)='sale'
)
As
Begin
	if @page ='sale'
	Begin
		Select *
		From carinfo CI
		where branchid = @branchid
		and Not Exists (select 1 from RampSaleHeader RSH where RSH.BranchId=CI.branchId and RSH.VehicleNo=CI.carnumber)
	End
	else
	Begin
		Select *
		From carinfo CI
		where branchid = @branchid
	End
End