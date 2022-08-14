IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.ProfitLossReport'))
drop procedure ProfitLossReport
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[ProfitLossReport]
    (
      @startDate varchar(50),
      @endDate varchar(100),
	  @branchId int
    )
As 

Begin
    
	declare @sale varchar(20)
	declare @purchase varchar(20)
	declare @discount varchar(20)
	declare @expense varchar(20)
	declare @totalStockPurchasePrice varchar(20)

	
	select @sale=(Sum(producttotal)),
	@purchase=Sum(producttotalpurchase)   
	from printinvoice 
	where  branchId=@branchId
	and CONVERT(varchar,date,101) between  Convert(varchar,@startDate,101) and  Convert(varchar,@endDate,101)

	SELECT @discount=  ISNULL(Sum(disc),0) 
	FROM (SELECT b.*,ROW_NUMBER() OVER (PARTITION BY invoiceid ORDER BY productname) as num 
		  FROM printinvoice b 
		  WHERE branchId=@branchId
		  and CONVERT(varchar,date,101) between  Convert(varchar,@startDate,101) and  Convert(varchar,@endDate,101)
		  ) tbl 
	WHERE num = 1


	select @expense=sum(amount) 
	from expense_detail 
	where branchId=@branchId
	and CONVERT(varchar,expensedate,101) between  Convert(varchar,@startDate,101) and  Convert(varchar,@endDate,101)
	

	select @totalStockPurchasePrice= Sum(cast(rsctn as decimal(18,0))*rspack) 
	from OilProducts
	where branchId=@branchId

	select isnull(@sale,0) as sale, isnull(@purchase,0) as purchase, isnull(@discount,0) as discount, isnull(@expense,0) as expense,
	@totalStockPurchasePrice as totalStockPurchasePrice
	
End


