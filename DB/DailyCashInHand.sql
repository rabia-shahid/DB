IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.DailyCashInHand'))
drop procedure DailyCashInHand
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePermissions]    Script Date: 22/06/2022 1:40:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[DailyCashInHand]
(@user varchar(50)=null,
@periodID int = null, 
@isDashboard INT = 0)
    As
Begin
  
  IF @isDashboard = 1 
	BEGIN
CREATE TABLE tmpDailyCashInHand (
branchName VARCHAR(250),
branchId INT ,
Cashinhand decimal(18, 2),
expense	INT,
CashReceived INT,	
ATM	decimal(18, 2),
JazzCash decimal(18, 2),
paymenttocompany INT,	
totalcars INT,	
Credit decimal(18, 2)
)
		declare @imbranchid int
		declare tmpCursor cursor FOR 
		Select Distinct id from Branches 
		open tmpCursor FETCH NEXT from tmpCursor into @imbranchid
		while @@FETCH_STATUS = 0
		BEGIN
		INSERT INTO tmpDailyCashInHand
		Select 
		(Select [name] from Branches where id= @imbranchid),
		@imbranchid as branchId,
	     ISNULL(Sum(NetAmount),0) Cashinhand,

(select ISNULL(cast(sum(amount) as varchar(20)),0) as expenses from Expense_Detail
 WHERE periodID=@periodID and branchId=@imbranchid) as expense,
 (select isNULL(sum(cr),0) as CashReceived from customer_ledger WHERE detail='Cash received from customer'
  and periodID=@periodID and branchId = @imbranchid) as CashReceived,
  (SELECT ISNULL(Sum(NetAmount),0)
  FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b 
   WHERE periodID=@periodID and paymentmethod='Cash-ATM' and branchId = @imbranchid)  tbl	WHERE num = 1) ATM, 
   (SELECT (ISNULL(Sum(NetAmount),0)) JazzCash FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
   WHERE  periodID=@periodID and paymentmethod='Jazz-Cash' and branchId = @imbranchid) tbl	WHERE num = 1) as JazzCash,
   (select (ISNULL(Sum(dr),0)) from supplier_ledger where periodid = @periodID and branchId =@imbranchid) as paymenttocompany,
   (SELECT COUNT (1)  from carinfo where periodid=@periodID and branchId = @imbranchid) as totalcars,
   (SELECT (ISNULL(Sum(NetAmount),0)) Credit FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
   WHERE  periodID=@periodID and paymentmethod='Credit' and branchId = @imbranchid) tbl	WHERE num = 1) as Credit 
   
   FROM 
  (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b
    WHERE  periodID=@periodID and paymentmethod='Cash' and branchId = @imbranchid) tbl WHERE num = 1
	FETCH NEXT from tmpCursor into @imbranchid
	END
	Close tmpCursor
	Deallocate tmpCursor
	Select * from tmpDailyCashInHand
	DROP TABLE tmpDailyCashInHand
	END

	ELSE
	BEGIN
	if @user = 'All'
		begin
     SELECT ISNULL(Sum(NetAmount),0) Cashinhand,

(select ISNULL(cast(sum(amount) as varchar(20)),0) as expenses from Expense_Detail
 WHERE periodID=@periodID) as expense,
 (select isNULL(sum(cr),0) as CashReceived from customer_ledger WHERE detail='Cash received from customer'
  and periodID=@periodID) as CashReceived,
  (SELECT ISNULL(Sum(NetAmount),0)
  FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b 
   WHERE periodID=@periodID and paymentmethod='Cash-ATM')  tbl	WHERE num = 1) ATM, 
   (SELECT (ISNULL(Sum(NetAmount),0)) JazzCash FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
   WHERE  periodID=@periodID and paymentmethod='Jazz-Cash') tbl	WHERE num = 1) as JazzCash,
   (select (ISNULL(Sum(dr),0)) from supplier_ledger where periodid = @periodID) as paymenttocompany,
   (SELECT COUNT (1)  from carinfo where periodid=@periodID) as totalcars,
   (SELECT (ISNULL(Sum(NetAmount),0)) Credit FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
   WHERE  periodID=@periodID and paymentmethod='Credit') tbl	WHERE num = 1) as Credit FROM 
  (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b
    WHERE  periodID=2 and paymentmethod='Cash' and branchId = 1) tbl	WHERE num = 1
	
		end
	
	
	
	else
		begin
			SELECT ISNULL(Sum(NetAmount),0) Cashinhand,
			(select ISNULL(cast(sum(amount) as varchar(20)),0) as expenses from Expense_Detail
			 WHERE userid=''+@user+'' and periodID=@periodID) as expense,
			 (select isNULL(sum(cr),0) as CashReceived from customer_ledger WHERE detail='Cash received from customer'
			  and userid=''+@user+'' and periodID=@periodID) as CashReceived,(SELECT ISNULL(Sum(NetAmount),0)
			  FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b 
			   WHERE  periodID=@periodID and paymentmethod='Cash-ATM' and employee=''+@user+'')  tbl	WHERE num = 1) ATM, 
			   
    (SELECT (ISNULL(Sum(NetAmount),0)) Credit FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
   WHERE  periodID=@periodID and paymentmethod='Jazz-Cash') tbl	WHERE num = 1) as JazzCash,
   
   (select (ISNULL(Sum(dr),0)) from supplier_ledger where periodid = @periodID) as paymenttocompany,
    (SELECT COUNT (1)  from carinfo where periodid=@periodID) as totalcars,
   
			   (SELECT (ISNULL(Sum(NetAmount),0)) Credit FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b  
			   WHERE  paymentmethod='Credit' and employee=''+@user+'' and periodID=@periodID) tbl	WHERE num = 1) as Credit FROM 
			  (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num FROM printinvoice b
				WHERE paymentmethod='Cash' and employee=''+@user+'' and periodID=@periodID) tbl	WHERE num = 1
			    
		end
		END
End
