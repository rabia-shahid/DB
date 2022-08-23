IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.stp_PostReturn'))
drop procedure stp_PostReturn
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================================
-- Entity Name:	stp_PostReturn 
-- Description:	This stored procedure is intended for Sales return
-- ==========================================================================================


CREATE PROCEDURE stp_PostReturn 
@InvoiceNumber INT = 0,
@ReturnBarcode VARCHAR(200) = '',
@UserId INT = 0
--@NetAmount decimal(18, 2) = 0,
--@CustomerName VARCHAR(250) = ''

AS 
BEGIN

--Invoice
select * INTO #Invoice from printinvoice where invoiceid = @InvoiceNumber 
and 
barcode= 
CASE WHEN @ReturnBarcode = '' THEN barcode 
ELSE  @ReturnBarcode END

DECLARE 	
@ReceiveAmount decimal(18, 2),
@ProductTotal decimal(18, 2),
@NetAmount decimal(18, 2),
@CustomerName VARCHAR(250) 

Select TOP 1 @ReceiveAmount = ReceiveAmount, @ProductTotal=ProductTotal, @NetAmount=NetAmount,@CustomerName =CustomerName from #Invoice

--Cash Received
select * INTO #CashReceived from CashReceived where REPLACE(detail,'Sale Invoice #','') = @InvoiceNumber order by row_id desc

--Insertion Into Cash Received
IF EXISTS (SELECT 1 FROM #CashReceived)
BEGIN
	DECLARE @CID INT
	Select TOP 1 @CID = cid from #CashReceived
	IF @ReturnBarcode = ''
	BEGIN
		Insert into CashReceived(bnk_code,cid,userid,amount,detail,[date])
		values(0,@cid,@UserId,-@ReceiveAmount,'Sale Invoice # ' + CAST(@InvoiceNumber AS VARCHAR(200)),GETDATE())
	END
	ELSE 
	BEGIN
		Insert into CashReceived(bnk_code,cid,userid,amount,detail,[date])
		values(0,@cid,@UserId,-@ProductTotal,'Sale Invoice # ' + + CAST(@InvoiceNumber AS VARCHAR(200)),GETDATE())
	END
	
END

--Getting previous bank balance from BankTransacton
select bnk_code,balance INTO #Bank from [Bank] where IsDefault=1

IF EXISTS (SELECT 1 FROM #Bank) 
BEGIN
	DECLARE 
	@bankCode INT, 
	@balance INT,
	@currentBalance INT
	select @bankCode = bnk_code,@balance = balance from [Bank] where IsDefault=1
	IF @ReturnBarcode = ''
	BEGIN
		SET @currentBalance = @balance - @NetAmount
	END
	ELSE
	BEGIN
		SET @currentBalance = @balance - @ProductTotal
	END

	update [Bank]  set userid = @UserId ,balance= @currentBalance where bnk_code= @bankCode

	IF @ReturnBarcode = ''
	BEGIN
		insert into BankTransacton(bnk_code,date,slip,deposit,withdraw,balance,remarks,userid)
		values(@bankCode,GETDATE(),'Sale invoice #' + +CAST(@InvoiceNumber AS VARCHAR(200)),0,@NetAmount,@currentBalance,'Sale invoice #' +CAST(@InvoiceNumber AS VARCHAR(200)),@userid)
	END
	ELSE
	BEGIN
		insert into BankTransacton(bnk_code,date,slip,deposit,withdraw,balance,remarks,userid)
		values(@bankCode,GETDATE(),'Sale invoice #' + +CAST(@InvoiceNumber AS VARCHAR(200)),0,@ProductTotal,@currentBalance,'Sale invoice #' + CAST(@InvoiceNumber AS VARCHAR(200)),@userid)
	END
END

--Getting previous customer balance from Customer
select balance,customerid INTO #Customer from [Customer] with (nolock) where [name]=@CustomerName 

IF EXISTS (SELECT 1 FROM #Customer)
BEGIN
	DECLARE @CustomerId INT,
	@PreBalance decimal(18, 2),
	@CBalance decimal(18, 2)
	SELECT @CustomerId = customerid, @PreBalance=balance FROM [Customer] with (nolock) where [name]=@CustomerName 
	SET @CBalance = @PreBalance - @NetAmount
	
	UPDATE [Customer]  set userid = @UserId, balance= @CBalance where CustomerID=@CustomerId

	Insert into customer_ledger(cid,dr,cr,detail,balance,date,userid)
	Values(@CustomerId,0.00,@ProductTotal,'Sale Return against invoice #' + CAST(@InvoiceNumber AS VARCHAR(200)),@CBalance,GETDATE(),@userid)
END

IF EXISTS (SELECT 1 FROM #Invoice) 
BEGIN
	DECLARE @Count INT
	Select @Count = COUNT(1) from #Invoice
	Select * INTO #Invoice2 FROM #Invoice

	DECLARE @tempId INT,
	@barcode VARCHAR(250),
	@Qty decimal(18, 2),
	@stock decimal(18, 2),
	@rsctn INT,
	@TotalPrice decimal(18, 2)

	WHILE (@Count > 0)
	BEGIN

		Insert into SaleReturn (InvoiceID,CustomerName,ProductName,Quantity,ProductPrice,TotalBill,NetAmount,ReceiveAmount,BalanceAmount,Date,employee,disc,ispending,barcode,productid,cellno,vehicleno,producttotal,totalpurchaseprice,paymentmethod,userid) 
		SELECT TOP 1 @InvoiceNumber, CustomerName,ProductName,Quantity,ProductPrice,TotalBill,NetAmount,ReceiveAmount,BalanceAmount, GETDATE(),employee,disc,0,barcode,productid,cellno,vehicleno,producttotal,totalpurchaseprice,paymentmethod,@UserId FROM #Invoice

		Select TOP 1 @tempId = Id, @barcode=barcode, @Qty=Quantity from #Invoice2
		
		select @stock=CAST(Qty as decimal(18, 2)) from [OilProducts] with (nolock) where code=@barcode
		Select @rsctn=rsltr from [OilProducts] with (nolock) where code=@barcode
		SET @stock = @stock + @Qty
		SET @TotalPrice = CAST(@stock * CAST(@rsctn as decimal(18, 2)) as decimal(18, 2))

		update [OilProducts]  set userid = @UserId,Qty=@stock, rspack=@stock, totalprice = @TotalPrice where code=@barcode
		
		DELETE FROM #Invoice2 where id = @tempId
		SET @Count = @Count - 1
	END
	

END

IF @ReturnBarcode = ''
BEGIN
	delete from printinvoice where invoiceid = @InvoiceNumber
END
ELSE 
BEGIN
	delete from printinvoice where invoiceid = @InvoiceNumber and barcode=@ReturnBarcode
END

DROP TABLE #Invoice
DROP TABLE #Bank
DROP TABLE #Customer
DROP TABLE #CashReceived

END