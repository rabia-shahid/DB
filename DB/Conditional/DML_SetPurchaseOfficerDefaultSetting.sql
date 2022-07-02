IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'RolePermissions') AND 
EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Employee_Roles')
BEGIN
Update RolePermissions
SET bEmployee = 0,
bCustomer = 0, 
bSupplier = 1,
bProducts = 1,
bSales = 0,
bPurchases = 1,
bExpenses = 0,
bPayments = 0,
bSettings = 0,
bAddEmployee = 0,
bViewEmployee = 0,
bAddSupplier = 1,
bViewSupplier = 1,
bAddProduct = 1,
bViewProduct = 1,
bTransactions = 1,
bSalesReturn = 0,
bStockShift = 1,
bAddExpenses = 0,
bViewExpenses = 0,
bPaySupplier = 0,
bPayCustomer = 0
where IroleId IN (Select iRoleId from Employee_Roles where vRole = 'Purchase Officer')
END