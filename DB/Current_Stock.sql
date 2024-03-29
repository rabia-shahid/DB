IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Current_Stock'))
drop procedure Current_Stock
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[Current_Stock]
    (
      @Column varchar(50),
      @value varchar(100),
	  @branchId int
    )
As 
    Begin
        if ( @Column = 'All'
             and @value = 'All'
           ) 
            Select  p.code,
                    p.[name],
                    p.Description,
                    p.apigrade,
                    p.packing,
                    p.rsctn,
                    p.rsltr,
                    p.totalprice,
                    p.rspack,
                    p.qty
            From    OilProducts p
			where branchId=@branchId
	
    End
