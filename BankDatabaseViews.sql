--customer and account info in one table 
CREATE VIEW `CustomerAccountsView` AS 
select `Customers`.`CustomerId` AS `CustomerId`,
`Customers`.`Fname` AS `Fname`,
`Customers`.`Lname` AS `Lname`,
`Accounts`.`AccountNum` AS `AccountNum`,
`Accounts`.`AccountType` AS `AccountType`,
`Accounts`.`Balance` AS `Balance` 
from (`Customers` join `Accounts`) 
where (`Customers`.`CustomerId` = `Accounts`.`CustomerId`)

--customer and address in one table 
CREATE VIEW `CustomerAddressView` AS 
select `Customers`.`CustomerId` AS `CustomerId`,
`Customers`.`Fname` AS `Fname`,
`Customers`.`Lname` AS `Lname`,
`CustomerAddress`.`StreetAdress` AS `StreetAdress`,
`ZipCode`.`City` AS `City`,`CustomerAddress`.
`State` AS `State`,
`CustomerAddress`.`Zip` AS `Zip` 
from ((`Customers` join `CustomerAddress`) join `ZipCode`) 
where ((`CustomerAddress`.`Zip` = `ZipCode`.`ZipCode`) and 
(`Customers`.`CustomerId` = `CustomerAddress`.`CostumerId`))
