USE [ilube]
GO
/****** Object:  StoredProcedure [dbo].[DailySaleInv]    Script Date: 04/08/2022 9:58:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[DailySaleInv]
(
      @txtdate varchar(50),
      @txttodate varchar(50),
      @rptbit int,
      @txtyear varchar(50) = null,
	  @branchId int
)
    As
Begin
		if @rptbit=1
		begin
			SELECT InvoiceID,TotalBill,disc,NetAmount,ReceiveAmount,BalanceAmount,saleDATE,employee,paymentmethod,vehicleno,customername FROM (
			   SELECT b.*,
			   ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num
			   FROM printinvoice b
			   --convert(varchar(10),date, 101) + right(convert(varchar(32),date,100),8)
			   WHERE CONVERT(varchar,date,101) between  Convert(varchar,@txtdate,101) and  Convert(varchar,@txttodate,101)
			   and b.branchId=@branchId
			) tbl
			WHERE num = 1
		end
		else if @rptbit=2
		begin
			SELECT InvoiceID,TotalBill,disc,NetAmount,ReceiveAmount,BalanceAmount,saleDATE,employee,paymentmethod,vehicleno,customername FROM (
			   SELECT b.*,
			   ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num
			   FROM printinvoice b
			   where month(date) = ''+@txtdate+'' and year(date) = ''+@txtyear+''
			   and b.branchId=@branchId
			) tbl
			WHERE num = 1
		end
		else if @rptbit=3
		begin
			SELECT InvoiceID,TotalBill,disc,NetAmount,ReceiveAmount,BalanceAmount,saleDATE,employee,paymentmethod,vehicleno,customername FROM (
			   SELECT b.*,
			   ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num
			   FROM printinvoice b
			   where year(date) = ''+@txtdate+''
			   and b.branchId=@branchId
			) tbl
			WHERE num = 1
		end

End
