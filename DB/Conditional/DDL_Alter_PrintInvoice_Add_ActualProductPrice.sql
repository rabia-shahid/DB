if not Exists (Select 1 from sys.columns  where object_id=Object_Id('printinvoice') and name='actualProductPrice')
Begin
Alter table printinvoice
add actualProductPrice numeric(8,2)
End

GO

if not Exists (Select 1 from sys.columns  where object_id=Object_Id('printinvoice') and name='FBR_Invoice')
Begin
Alter table printinvoice
add FBR_Invoice varchar(50)
End


