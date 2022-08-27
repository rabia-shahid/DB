
if Not Exists (select 1 from Supplier where name ='Dummy')
Begin
	insert into Supplier(Name, City, LastUpdated, Address, ContactNumber, balance,email, fax, website, userId, branchId)
	select 'Dummy','Lahore', GETDATE(),'','',0,'','','',0,0
End