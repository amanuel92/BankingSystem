--creates tables for managers 

CREATE TABLE IF NOT EXISTS `BankDatabase`.`Managers` (
  `ManagerId` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ManagerId`))
ENGINE = InnoDB
AUTO_INCREMENT = 100 --manager id number starts at 100


--create table for employees 

CREATE TABLE IF NOT EXISTS `BankDatabase`.`Employees` (
  `EmployeeId` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `DateHired` DATE NOT NULL,
  `HiredBy` INT NOT NULL,
  PRIMARY KEY (`EmployeeId`),
  INDEX `HiringManager_idx` (`HiredBy` ASC),
  CONSTRAINT `HiringManager`
    FOREIGN KEY (`HiredBy`)
    REFERENCES `BankDatabase`.`Managers` (`ManagerId`)
    ON DELETE NO ACTION     
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 200  --employee id number starts at 200 (under 800 employees)

--create table for customers 
CREATE TABLE IF NOT EXISTS `BankDatabase`.`Customers` (
  `CustomerId` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `DateJoined` DATE NOT NULL,
  `NumofAccounts` INT NOT NULL,
  `AddedBy` INT NOT NULL,
  PRIMARY KEY (`CustomerId`),
  INDEX `AddedBy_idx` (`AddedBy` ASC),
  CONSTRAINT `AddedByEmployees`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `BankDatabase`.`Employees` (`EmployeeId`)   
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AddedByManager`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `BankDatabase`.`Managers` (`ManagerId`)     
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000  --customer id number starts at 1000 

--create table for customer address 
CREATE TABLE IF NOT EXISTS `BankDatabase`.`CustomerAddress` (
  `AdressId` INT NOT NULL AUTO_INCREMENT,
  `CostumerId` INT NOT NULL,
  `StreetAdress` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Zip` INT NOT NULL,
  `DateFrom` DATE NOT NULL,
  `DateTo` DATE NULL,
  PRIMARY KEY (`AdressId`),
  INDEX `CustomerOfAdsress_idx` (`CostumerId` ASC),
  INDEX `Zip_idx` (`Zip` ASC),
  CONSTRAINT `CustomerOfAddress`
    FOREIGN KEY (`CostumerId`)
    REFERENCES `BankDatabase`.`Customers` (`CustomerId`)  
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `Zip`
    FOREIGN KEY (`Zip`)
    REFERENCES `BankDatabase`.`ZipCode` (`ZipCode`)      
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 100000  --address id number starts at 100000

--create table for zip code with matching cities 
CREATE TABLE IF NOT EXISTS `BankDatabase`.`ZipCode` (
  `ZipCode` INT NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ZipCode`))
ENGINE = InnoDB


--create table for customer accounts 
CREATE TABLE IF NOT EXISTS `BankDatabase`.`Accounts` (
  `AccountNum` VARCHAR(10) NOT NULL,     					  
  `CustomerId` INT NOT NULL,
  `AccountType` VARCHAR(1) NOT NULL,
  `DateOpened` DATE NOT NULL,
  `CreatedBy` INT NOT NULL,
  `Balance` FLOAT NULL,
  PRIMARY KEY (`AccountNum`),
  INDEX `CostumerId_idx` (`CustomerId` ASC),
  INDEX `AccountOpenedBy_idx` (`CreatedBy` ASC),
  CONSTRAINT `CostumerofAccount`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `BankDatabase`.`Customers` (`CustomerId`)     
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `AccountOpenedByEmployee`
    FOREIGN KEY (`CreatedBy`)
    REFERENCES `BankDatabase`.`Employees` (`EmployeeId`)     
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AccountOpenedByManager`
    FOREIGN KEY (`CreatedBy`)
    REFERENCES `BankDatabase`.`Managers` (`ManagerId`)      
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

--create table for customer transaction 
CREATE TABLE IF NOT EXISTS `BankDatabase`.`Transactions` (
  `TransactionId` INT NOT NULL AUTO_INCREMENT,
  `AccountNum` VARCHAR(10) NOT NULL,
  `TransactionDate` DATE NOT NULL,
  `TransactionTime` TIME NOT NULL,
  `TransactionType` CHAR(1) NOT NULL,
  `HandeledBy` INT NOT NULL,
  `TransactionAmount` FLOAT NOT NULL,
  PRIMARY KEY (`TransactionId`),
  INDEX `TransactionOnAccount_idx` (`AccountNum` ASC),
  INDEX `TransactionHandeledBy_idx` (`HandeledBy` ASC),
  CONSTRAINT `TransactionOnAccount`
    FOREIGN KEY (`AccountNum`)
    REFERENCES `BankDatabase`.`Accounts` (`AccountNum`)      
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `TransactionHandeledBy`
    FOREIGN KEY (`HandeledBy`)
    REFERENCES `BankDatabase`.`Employees` (`EmployeeId`)     
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000000    --transaction id number starts at 1000000 






