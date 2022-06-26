IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Categories')
BEGIN
	INSERT INTO Categories
	Select 'Oil'
	WHERE NOT EXISTS (SELECT NAME FROM Categories where [Name] = 'Oil')

	INSERT INTO Categories
	Select 'Other'
	WHERE NOT EXISTS (SELECT NAME FROM Categories where [Name] = 'Other')

END

