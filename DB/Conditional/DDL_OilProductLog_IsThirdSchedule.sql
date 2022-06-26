IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'isThirdScheduleOrder'
          AND Object_ID = Object_ID(N'OilProductsLog'))
BEGIN
    ALTER TABLE OilProductsLog
	ADD isThirdScheduleOrder BIT NOT NULL DEFAULT 0
END