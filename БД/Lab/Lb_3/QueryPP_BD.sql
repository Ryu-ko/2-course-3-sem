CREATE TABLE Books
          (     
		Autor   nvarchar(50)  primary key,              
      Book_type  nvarchar(50) foreign key references Books(Autor), 
      Book_size int default 50 
			check  ( Book_size between 50 and 1000),  
                Book_name  nvarchar(50)                                     
          ) on FG1;
