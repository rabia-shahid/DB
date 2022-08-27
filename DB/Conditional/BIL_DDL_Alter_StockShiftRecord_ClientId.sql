if Exists (select  * from sys.tables where name='StockShiftRecord')
Begin
		Alter Table StockShiftRecord
		Alter column clientId varchar(100)
End