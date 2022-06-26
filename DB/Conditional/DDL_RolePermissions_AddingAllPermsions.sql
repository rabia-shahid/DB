--Multi-Execution Secure
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bAddEmployee'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bAddEmployee BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bViewEmployee'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bViewEmployee BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bAddCustomer'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bAddCustomer BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bViewCustomer'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bViewCustomer BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bAddSupplier'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bAddSupplier BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bViewSupplier'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bViewSupplier BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bAddProduct'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bAddProduct BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bViewProduct'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bViewProduct BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bTransactions'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bTransactions BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bSalesReturn'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bSalesReturn BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bStockShift'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bStockShift BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bAddExpenses'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bAddExpenses BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bViewExpenses'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bViewExpenses BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bPaySupplier'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bPaySupplier BIT NOT NULL DEFAULT 0
END

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'bPayCustomer'
          AND Object_ID = Object_ID(N'RolePermissions'))
BEGIN
    ALTER TABLE RolePermissions
	ADD bPayCustomer BIT NOT NULL DEFAULT 0
END
