
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Ramp')
Begin
	CREATE TABLE Ramp (
		RampNo int IDENTITY(1,1) PRIMARY KEY,
		BranchId int
	);
END

drop table RampSaleDetail
drop table RampSaleHeader

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'RampSaleHeader')
Begin
	CREATE TABLE RampSaleHeader (
    SaleHeaderId int IDENTITY(1,1) PRIMARY KEY,
	BranchId int,
	RampNo int,
	VehicleNo varchar(100),
	VehicleName varchar(100),
	OilMilage numeric(8,2),
	CurrentMilage numeric(8,2),
	DueMilage numeric(8,2),
	AverageMilage numeric(8,2),
	NextDate varchar(30),
	Worker varchar(100),
	CustomerName varchar(100),
	CustomerPhoneNo varchar(100),
	TotalAmount numeric(8,2),
	DiscountAmount varchar(20),
	NetAmount varchar(20),
	ReceivedAmount varchar(20),
	BalanceAmount varchar(20),
	CreateDate datetime
);
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'RampSaleDetail')
Begin
	CREATE TABLE RampSaleDetail (
    SaleDetailId int IDENTITY(1,1) PRIMARY KEY,
	SaleHeaderId int FOREIGN KEY REFERENCES RampSaleHeader(SaleHeaderId),
	BarCode varchar(100),
	ProductId int,
	SaleQuantity numeric(8,2)
);
End