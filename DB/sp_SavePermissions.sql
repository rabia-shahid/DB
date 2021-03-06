IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_SavePermissions'))
drop procedure sp_SavePermissions
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePermissions]    Script Date: 22/06/2022 1:40:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[sp_SavePermissions]
@bEmployee bit,
@bAddEmployee bit,
@bViewEmployee bit,
@bCustomer bit,
@bAddCustomer bit,
@bViewCustomer bit,
@bSupplier bit,
@bAddSupplier bit,
@bViewSupplier bit,
@bProducts bit,
@bAddProducts bit,
@bViewProducts bit,
@bTransactions bit,
@bSales bit,
@bSalesReturn bit,
@bPurchases bit,
@bStockShift bit,
@bExpenses bit,
@bAddExpenses bit,
@bViewExpenses bit,
@bPayments bit,
@bPaySupplier bit,
@bPayCustomer bit,
@bSettings bit,
@iRoleId int
as
begin
if not exists (select 1 from RolePermissions where iRoleId = @iRoleId)
begin
insert into RolePermissions (iRoleId, bEmployee, bAddEmployee, bViewEmployee, 
bCustomer,bAddCustomer, bViewCustomer, bSupplier, bAddSupplier, bViewSupplier, 
bProducts, bAddProduct, bViewProduct, bTransactions, bSales, bSalesReturn, bPurchases, bStockShift, 
bExpenses, bAddExpenses, bViewExpenses, bPayments,bPaySupplier, bPayCustomer, bSettings) 
values (@iRoleId, @bEmployee, @bAddEmployee, @bViewEmployee, @bCustomer, @bAddCustomer, @bViewCustomer, 
@bSupplier, @bAddSupplier, @bViewSupplier, @bProducts, @bAddProducts, @bViewProducts, @bTransactions, @bSales, @bSalesReturn, 
@bPurchases, @bStockShift, @bExpenses, @bAddExpenses, @bViewExpenses, @bPayments, @bPaySupplier, @bPayCustomer, @bSettings)
end
else
begin
update RolePermissions set 
bEmployee = @bEmployee,
bAddEmployee = @bAddEmployee,
bViewEmployee = @bViewEmployee,
bCustomer = @bCustomer,
bAddCustomer = @bAddCustomer,
bViewCustomer = @bViewCustomer,
bSupplier = @bSupplier,
bAddSupplier = @bAddSupplier,
bViewSupplier = @bViewSupplier,
bProducts = @bProducts,
bAddProduct = @bAddProducts,
bViewProduct = @bViewProducts,
bTransactions = @bTransactions,
bSales = @bSales,
bSalesReturn = @bSalesReturn,
bPurchases = @bPurchases,
bStockShift = @bStockShift,
bExpenses = @bExpenses,
bAddExpenses = @bAddExpenses,
bViewExpenses = @bViewExpenses,
bPayments = @bPayments,
bPaySupplier = @bPaySupplier,
bPayCustomer = @bPayCustomer,
bSettings = @bSettings
where iRoleId = @iRoleId
end

end
