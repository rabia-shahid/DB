IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.OilProducts_Insert'))
drop procedure OilProducts_Insert
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Products_Insert
-- Create date:	1/6/2010 8:42:43 PM
-- Description:	This stored procedure is intended for inserting values to Products table
-- ==========================================================================================
CREATE procedure [dbo].[OilProducts_Insert]
	
	@CategoryID int,
	@name varchar(50),
	@apigrade varchar(50),
	@packing varchar(50),
	@rsltr varchar(50),
	@rspack varchar(50),
	@rsctn varchar(50),
	@description varchar(50),
	@qty decimal(18,2),
	@totalprice decimal(18,2),
	--@date varchar(100),
	@code varchar(50),
	@minlimit int,
	@profitmargin int,
	@indentprice decimal(18,2),
	@branchid int,
	@isThirdScheduleOrder BIT = 0,
	@ProductCategoryId INT
As
BEGIN
DECLARE @intErrorCode INT
Begin tran
	Insert Into OilProducts
		([CategoryID],[Name],[apigrade],[packing],[rsltr],[rspack],[rsctn],[description],[qty],[totalprice],[code],[date],[minlimit],profitmargin,indentprice,branchid, isThirdScheduleOrder, ProductCategoryId)
	Values
		(@CategoryID,@name,@apigrade,@packing,@rsltr,@rspack,@rsctn,@description,@qty,@totalprice,@code,GETDATE(),@minlimit,@profitmargin,@indentprice,@branchid, @isThirdScheduleOrder, @ProductCategoryId)
	
	Declare @ReferenceID int
	Declare @CustomerID int
	Select @ReferenceID = SCOPE_IDENTITY()
	
	Insert Into OilProductsLog
		([productid],[CategoryID],[Name],[apigrade],[packing],[rsltr],[rspack],[rsctn],[description],[qty],[totalprice],[Date],[code],[minlimit],profitmargin,indentprice,branchid, isThirdScheduleOrder, ProductCategoryId)
	Values
		(@ReferenceID,@CategoryID,@name,@apigrade,@packing,@rsltr,@rspack,@rsctn,@description,@qty,@totalprice,GETDATE(),@code,@minlimit,@profitmargin,@indentprice,@branchid, @isThirdScheduleOrder, @ProductCategoryId)

SELECT @intErrorCode = @@ERROR

commit tran
IF (@intErrorCode <> 0) BEGIN
PRINT 'Unexpected error occurred!'
    ROLLBACK TRAN
END
ELSE
BEGIN
	SELECT @ReferenceID
END
END