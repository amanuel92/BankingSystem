
---proc to adding new customers
--i.e call AddCustomer('sam', 'hemes', 101, 22303, 'dumfries', '3342 depem st', 'VA','2009-11-12')

create procedure AddCustomer (in fname varchar(45),  
in lname varchar(45),  
in addedby int, 
in zipcode int,  
in city varchar(45),  
in streetaddress varchar(45), 
in state varchar(45), 
in datefrom date 
) 
begin  
insert into Customers (Fname, Lname, DateJoined, NumofAccounts, AddedBy)  
values 
(fname, lname, curdate(), 0, addedby); 
insert ignore into ZipCode (ZipCode, City)  
values 
(zipcode, city);  
insert into CustomerAddress (CostumerId, StreetAdress, State, Zip, DateFrom) 
values 
((select MAX(CustomerId) from Customers), streetaddress, state, zipcode, datefrom); 
end;


--opening an account for customer
--i.e call AddAccount ('3456765456',1000, 'c', 102)

create procedure AddAccount (in accountnum varchar(10),
in cust_id int,
in account_type varchar(1),
in openedby int)
begin
insert into Accounts (AccountNum, CustomerId, AccountType, DateOpened, CreatedBy, Balance)
values 
(accountnum, cust_id, account_type, curdate(), openedby, 00.00);
update Customers set NumofAccounts = NumofAccounts + 1 where CustomerId=cust_id;
end;

--deposit on account 
--i.e call DepositonAccount('3456765456', 1000, 102, 100.00);

create procedure DepositonAccount (in accountnum varchar(10),
in cus_id int,
in handeled_by int,
in amount float) 
begin
update Accounts set Balance = Balance + amount where AccountNum like accountnum and CustomerId = cus_id;
insert into Transactions (AccountNum, TransactionDate, TransactionTime, TransactionType, HandeledBy, TransactionAmount)
values 
(accountnum, curdate(), current_time(), 'd', handeled_by, amount);
end;

--withdraw on account 
--i.e call WithdrawonAccount ('3456765456', 1000, 102, 50.00);

create procedure WithdrawonAccount (in accountnum varchar(10),
in cus_id int,
in handeled_by int,
in amount float) 
begin 
update Accounts set Balance = Balance - amount where AccountNum=accountnum and CustomerId = cus_id;
insert into Transactions (AccountNum, TransactionDate, TransactionTime, TransactionType, HandeledBy, TransactionAmount)
values 
(accountnum, curdate(), current_time(), 'w', handeled_by, amount);
end;







