IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.GetCustomer'))
drop procedure GetCustomer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Customer_SelectRow
-- Create date:	1/6/2010 8:11:04 PM
-- Description:	This stored procedure is intended for selecting a specific row from Customer table
-- ==========================================================================================
Create procedure [dbo].[GetCustomer]
	@CustomerID int =0,
	@branchid int,
	@name varchar(100)='',
	@cellNo varchar(100)=''
As
Begin
	Select *
	From Customer
	Where
		branchid = @branchid
	and CustomerID = case when @CustomerID <> 0 then @CustomerID else CustomerID end
	and Name = case when @name <> '' then @name else Name end
	and ContactNumber = case when @cellNo <> '' then @cellNo else ContactNumber end
End
