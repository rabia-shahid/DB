IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Barcode_SelectAll'))
drop procedure Barcode_SelectAll
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================================================================
-- Entity Name:	Barcode_SelectAll
-- Description:	This stored procedure is intended to get all products with barcodes
-- ==========================================================================================

CREATE procedure [dbo].[Barcode_SelectAll]
@branchid int = 0

As
Begin
		delete from barcodes
		insert into barcodes(barcode,itemname,articleno,qty, branchId) Select code,name,rsltr,qty, branchId	From OilProducts;
		WITH TempEmp (barcode,duplicateRecCount)
			AS
			(
			SELECT barcode,ROW_NUMBER() OVER(PARTITION by barcode ORDER BY barcode) 
			AS duplicateRecCount
			FROM dbo.barcodes
			)
			--Now Delete Duplicate Rows
			DELETE FROM TempEmp
			WHERE duplicateRecCount > 1 
			 --if ( @Column = 'All' and @value = 'All') 
				--begin

					select ROW_NUMBER() OVER (ORDER BY barcode) as number, * from barcodes where LEN(barcode) <=6 AND ISNULL(branchId, 0) = @branchid
			--	end
			--else if ( @Column = 'Product Name' ) 
			--	begin
			--		select * from barcodes where LEN(barcode) <=6 and ItemName like '%' + @value + '%'
			--	end
			--else if ( @Column = 'Barcode' ) 
			--	begin
			--		select * from barcodes where LEN(barcode) <=6 and barcode like '%' + @value + '%'
			--	end
		 
		
End