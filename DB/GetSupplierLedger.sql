IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.GetSupplierLedger'))
drop procedure GetSupplierLedger
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[GetSupplierLedger]
@Name varchar(100),
@branchId int

As
Begin
	select sid,[Date],[Dr],[Cr],Supplier_Ledger.[Balance],Name,detail from Supplier_Ledger join supplier on supplier.SupplierID = Supplier_Ledger.sid
where supplier.name = @name
and supplier.branchId = case when  @branchId > 0 then @branchId else supplier.branchId  end 
order by date desc
End
