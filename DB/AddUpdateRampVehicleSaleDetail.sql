IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.AddUpdateRampVehicleSaleDetail'))
drop procedure AddUpdateRampVehicleSaleDetail
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[AddUpdateRampVehicleSaleDetail]
	@BranchId int,
	@RampNo int,
	@Barcodes varchar(1000),
	@ProductIds varchar(1000), 
	@ProductSaleQuantities varchar(1000)

AS

Begin

	SELECT  ROW_NUMBER() OVER (ORDER BY value) rowNo,* into #tempBarCodes FROM string_split(@Barcodes, ',')
	SELECT  ROW_NUMBER() OVER (ORDER BY value) rowNo,* into #tempProductIds FROM string_split(@ProductIds, ',')
	SELECT  ROW_NUMBER() OVER (ORDER BY value) rowNo,* into #tempProductQuantities FROM string_split(@ProductSaleQuantities, ',')

	declare @saleHederId int
	select @saleHederId=saleheaderid from RampSaleHeader where BranchId=@BranchId and RampNo=@RampNo;
	
	delete from RampSaleDetail where SaleHeaderId = @saleHederId 
	
	if Not Exists (Select 1 from RampSaleDetail where SaleHeaderId = @saleHederId )
	Begin
		Insert into RampSaleDetail (SaleHeaderId, BarCode, ProductId, SaleQuantity)
		select @saleHederId, B.value as Barcode, P.value as ProductId,Q.value as SaleQuantity
		from #tempBarCodes B
		left join #tempProductIds P on B.rowNo=P.rowNo
		left join #tempProductQuantities Q on B.rowNo=Q.rowNo
		where isnull(B.value,'') <> ''
	End
	
END

