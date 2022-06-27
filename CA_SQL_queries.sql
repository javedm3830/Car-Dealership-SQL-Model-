
--- Creation of tables

CREATE TABLE [Customer] (
  [CustomerID] int IDENTITY (1,9),
  [cust_name] varchar(100),
  [email] varchar(100),
  [Phone_number] varchar(15),
  [status] varchar(10),
  [GDPRConsent] char(1),
  PRIMARY KEY ([CustomerID])
);

CREATE TABLE [Mechanic] (
  [MechanicID] char(10),
  [Email] Varchar(100),
  [Mechanic_name] varchar(100),
  [Phone_number] varchar(15),
  PRIMARY KEY ([MechanicID])
);

CREATE TABLE [Salesman] (
  [SalesmanID] char(10),
  [Name] varchar(100),
  [Email] varchar(100),
  [Phone_number] varchar(15),
  PRIMARY KEY ([SalesmanID])
);

CREATE TABLE [Car] (
  [CarID] char(12),
  [car_make] varchar(50),
  [car_model] varchar(50),
  [car_year] int,
  [sale_status] char(1),
  PRIMARY KEY ([CarID])
);

CREATE TABLE [Invoice] (
  [InvoiceID] Int IDENTITY(1,1),
  [CarID] char(12),
  [CustomerID] Int,
  [SalesmanID] char(10),
  [Date] Date,
  PRIMARY KEY ([InvoiceID]),
  FOREIGN KEY ([CarID]) REFERENCES Car([CarID]),
  FOREIGN KEY ([CustomerID]) REFERENCES Customer([CustomerID]),
  FOREIGN KEY ([SalesmanID]) REFERENCES Salesman([SalesmanID])

);

CREATE TABLE [ServiceTicket] (
  [ServiceID] Int IDENTITY (1,1),
  [ServiceName] Varchar(100),
  [CustomerID] int,
  [CarID] char(12),
  [MechanicID] char(10),
  [Date] Date,
  PRIMARY KEY ([ServiceID]),
  FOREIGN KEY ([CustomerID]) REFERENCES Customer([CustomerID]),
  FOREIGN KEY ([MechanicID]) REFERENCES Mechanic([MechanicID]),
  FOREIGN KEY ([CarID]) REFERENCES Car([CarID])
);




--- Creating index for faster searches---

CREATE INDEX [Fk] ON  [ServiceTicket] ([MechanicID]);

---Creating stored Procedure for new customer record

Go
CREATE PROCEDURE CreateCustomer  @cust_name varchar(100),@email varchar(100),@Phone_number varchar(15),@Status varchar(10),@GDPRConsent char(1)
AS
Begin
insert into Customer values(@cust_name,@Email,@Phone_number,@Status,@GDPRConsent)
END 

---Creating stored Procedure for new Car record

Go
CREATE PROCEDURE CreateInv  @CarID char(12),@customerID int, @SalesmanID char(10),@Date date
AS
BEGIN
insert into Invoice values(@CarID,@customerID,@SalesmanID,@Date)
END

---- Creating stored procedure for invoice record
Go
CREATE PROCEDURE CreateCar  @CarID char(12),@car_make varchar(50),@car_model varchar(50),@car_Year int,@sale_status char(1)
AS
BEGIN
insert into Car values(@CarID,@car_make,@car_model,@car_year,@sale_status)
END

----Creating stored procedure for new Salesman record

Go
CREATE PROCEDURE createSalesman @SalesmanID char(10),@Name varchar(100),@Email varchar(100),@Phone_number varchar(15)
AS
Begin
insert into Salesman values(@SalesmanID,@Name,@Email,@Phone_number);
End

----Creating stored procedure for new Mechanic record

Go

CREATE PROCEDURE createMecahnic @MechanicID char(10),@Email varchar(100),@Mechanic_name varchar(100),@Phone_number varchar(15)
AS
Begin
insert into Mechanic values(@MechanicID,@Email,@Mechanic_name,@Phone_number);
END

--- Creating stored procedure for service ticket record

Go

CREATE PROCEDURE createServiceTickets @ServiceName varchar(100),@CustomerID int , @CarID char(12),@MechanicID char(10),@Date Date
AS
Begin
insert into ServiceTicket values(@ServiceName,@CustomerID,@CarID,@MechanicID,@Date);
END


----- Executing the stored procedures----for inserting the records in each table 

Exec CreateCustomer @cust_name = 'Alex Smith',@email = 'alex.smith@mail.com',@Phone_number = '9846833748',@status = 'A',@GDPRConsent ='Y';
Exec CreateCustomer @cust_name = 'John Smith',@email = 'john.smith@mail.com',@Phone_number = '4566833748',@status = 'A',@GDPRConsent ='Y';
Exec CreateCustomer @cust_name = 'Andrew Smith',@email = 'andrew.smith@mail.com',@Phone_number = '985673748',@status = 'A',@GDPRConsent ='Y';
Exec CreateCustomer @cust_name = 'James Smith',@email = 'james.smith@mail.com',@Phone_number = '9885322748',@status = 'A',@GDPRConsent ='Y';
Exec CreateCustomer @cust_name = 'Michael Smith1',@email = 'michael.smith@mail.com',@Phone_number = '9489334748',@status = 'A',@GDPRConsent ='N';

select * from Customer

Exec CreateCar @CarID = 'CAR100202',@car_make = 'Honda',@car_model = 'Prius',@car_Year = '2015',@sale_status = '1';
Exec CreateCar @CarID = 'CAR100203',@car_make = 'SEAT',@car_model = 'Caddy',@car_Year = '2018',@sale_status = '1';
Exec CreateCar @CarID = 'CAR100204',@car_make = 'BMW',@car_model = 'GZI',@car_Year = '2014',@sale_status = '1';
Exec CreateCar @CarID = 'CAR100205',@car_make = 'Mercedes',@car_model = 'S-Class',@car_Year = '2020',@sale_status = '1';

select * from Car


Exec CreateInv @CarID = 'CAR100205',@CustomerID = '19',@SalesmanID = 'SM00000003',@Date = '12-03-2022';

Select * from Invoice



Exec createSalesman @SalesmanID = 'SM00000001', @Name = 'Jason Maine', @Email = 'jason.maine@mail.com',@Phone_number ='04686566332';
Exec createSalesman @SalesmanID = 'SM00000002', @Name = 'Rhodey Campbell', @Email = 'rhodey.campbell@mail.com',@Phone_number ='43435746332';
Exec createSalesman @SalesmanID = 'SM00000003', @Name = 'Tony Stark', @Email = 'tony.stark@mail.com',@Phone_number ='67888468762';
Exec createSalesman @SalesmanID = 'SM00000004', @Name = 'Thomas James', @Email = 'thomas.james@mail.com',@Phone_number ='046854792945';
Exec createSalesman @SalesmanID = 'SM00000005', @Name = 'Gerry Richard', @Email = 'gerry.richard@mail.com',@Phone_number ='046853390274';

select * from Salesman

Exec createMecahnic @MechanicID = 'MECH000001', @Email = 'david.roy@mail.com',@Mechanic_name = 'David Roy', @Phone_number = '56848903033';
Exec createMecahnic @MechanicID = 'MECH000002', @Email = 'manish.sharma@mail.com',@Mechanic_name= 'Manish Sharma', @Phone_number = '564356030345';
Exec createMecahnic @MechanicID = 'MECH000003', @Email = 'roy.donnel@mail.com',@Mechanic_name = 'Roy Donnel', @Phone_number = '55454532233';
Exec createMecahnic @MechanicID = 'MECH000004', @Email = 'nand.kishore@mail.com',@Mechanic_name = 'Nand Kishore', @Phone_number = '2457765322';
Exec createMecahnic @MechanicID = 'MECH000005', @Email = 'jackson.anet@mail.com',@Mechanic_name = 'Jackson Anet', @Phone_number = '34568954679';

select * from Mechanic


Exec createServiceTickets @ServiceName ='Yearly Service',@CustomerID = '10', @CarID ='CAR100203',@MechanicID ='MECH000002', @Date = '10-05-2021';
Exec createServiceTickets @ServiceName ='AdHoc Repair',@CustomerID = '19', @CarID ='CAR100205',@MechanicID ='MECH000004', @Date = '11-07-2021';
Exec createServiceTickets @ServiceName ='Warranty Repair',@CustomerID = '28', @CarID ='CAR100201',@MechanicID ='MECH000005', @Date = '01-02-2021';
Exec createServiceTickets @ServiceName ='Yearly Service',@CustomerID = '37', @CarID ='CAR100202',@MechanicID ='MECH000001', @Date = '06-10-2021';
Exec createServiceTickets @ServiceName ='First Service',@CustomerID = '1', @CarID ='CAR100204',@MechanicID ='MECH000003', @Date = '09-03-2022';


select * from ServiceTicket

--------GDPR Masking stored procedure------

Go

Create Procedure UpdateGDPRData @CustomerID int
AS
IF EXISTS (select CustomerID from Customer 
           Where GDPRConsent = 'N' and CustomerID = @CustomerID)
BEGIN
UPDATE Customer
set cust_name = 'GDPR',
   email = 'GDPR',
   Phone_number = 'GDPR'
Where CustomerID = @CustomerID

END

EXEC UpdateGDPRData @CustomerID = '46'       ----Test of GDPR masking flag------


----We can see the Value for personal data such as name, email , phone number are masked as now GDPR in Customer tabel for CustomerID 46 


---Creating stored procedure for updating the status of the customer who didnt have service in 13 months------

Go
Create Procedure UpdateCustStatus
@customerID int
as

         if exists (select CustomerID from ServiceTicket
		 where Datediff(mm,date,getdate())>=13
		 and CustomerID =  @customerID)
		 begin
		 Update Customer
		 set status = 'I'  --------updating I for Inactive -----------and A is for Active to begin with 
		 where CustomerID = @customerID
end

select * from Customer

Execute UpdateCustStatus @CustomerID = '28'  ----------- Testing the Update status as Inactive for customer more than 13 months did service to car

------The value for status column for customerID = 28 is changed to 'I'  which is Inactive...




--Views for Management Information ----

--- Daily Report is the view created to show the list of service ticket with Mechanic working on it and the Car Idfor same

Go
Create View DailyReport
As
select S.ServiceID, m.MechanicID,m.Mechanic_name,s.Date,c.CarID,c.car_model
From ServiceTicket S
Inner join
Mechanic m
on S.MechanicID = m.MechanicID
Inner join Car c
on
S.CarID = c.CarID;

go

select * from DailyReport ------------Testing the view

-------Inactive Customer Data View-----

----- Here we have considered the date field in ServiceTicket field as the date on which the Service was done (same date as service ticket was raised)--------

----- So we can join 3 table considering the ServiceTicket table as bridge again between Car and Customer


go
Create view InactiveCust
As 
Select c.CustomerID,c.cust_name, c.Phone_number,ca.CarID, s.Date 
from ServiceTicket s
inner join 
Customer C
on
s.CustomerID = c.CustomerID
inner join 
Car ca
on
s.CarID = ca.CarID
where datediff(mm, s.Date, getdate()) >=13

go
select * from InactiveCust ----------------This view will show only the list of Inactive customerswho has done service more than 13 months ago from today.

