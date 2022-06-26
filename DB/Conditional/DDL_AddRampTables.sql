drop table RampSaleDetail
drop table RampSaleHeader
drop table Ramp

CREATE TABLE Ramp (
    RampNo int IDENTITY(1,1) PRIMARY KEY,
	BranchId int
);

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
	DiscountAmount numeric(8,2),
	NetAmount numeric(8,2),
	ReceivedAmount numeric(8,2),
	BalanceAmount numeric(8,2),
	CreateDate datetime
);

CREATE TABLE RampSaleDetail (
    SaleDetailId int IDENTITY(1,1) PRIMARY KEY,
	SaleHeaderId int FOREIGN KEY REFERENCES RampSaleHeader(SaleHeaderId),
	BarCode varchar(100),
	ProductId int,
	SaleQuantity numeric(8,2)
);