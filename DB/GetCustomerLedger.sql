IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.GetCustomerLedger'))
drop procedure GetCustomerLedger
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  procedure [dbo].[GetCustomerLedger]
@Name varchar(100),
@branchId int
As
Begin
	
select cid,[Date],[Dr],[Cr],customer_ledger.[Balance],Name,detail from customer_ledger join customer on customer.customerid = customer_ledger.cid
where customer.name = @name 
and Customer.branchId = case when  @branchId > 0 then @branchId else Customer.branchId  end
order by date desc         
End
