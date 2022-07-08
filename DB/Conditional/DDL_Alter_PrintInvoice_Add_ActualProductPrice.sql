if not Exists (Select 1 from sys.columns  where object_id=Object_Id('printinvoice') and name='actualProductPrice')
Begin
Alter table printinvoice
add actualProductPrice numeric(8,2)
End

