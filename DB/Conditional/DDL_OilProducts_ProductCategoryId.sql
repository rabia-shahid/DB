IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'ProductCategoryId'
          AND Object_ID = Object_ID(N'OilProducts'))
BEGIN
    ALTER TABLE OilProducts
	ADD ProductCategoryId INT NOT NULL DEFAULT 0 
END


