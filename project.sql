create table customer(
	cid varchar(5) primary key check(cid like 'C%'),
	fname varchar(15) not null,
	lname varchar(15),
	gender varchar(1) check(gender in('M','F')) not null,
	house_no varchar(20) not null,
	street varchar(20) not null,
	city varchar(20) not null,
	cust_type varchar(10) check(cust_type in('Regular','Business')) not null
);

create table customer_contact(
	cid varchar(5) references customer(cid) on delete set null,
	phone_number numeric(10,0) unique check(phone_number>999999999),
	primary key(cid,phone_number)
);

create table staff(
	sid varchar(5) primary key check(sid like 'S%'),
	fname varchar(15) not null,
	lname varchar(15),
	salary numeric(7,2) check(salary>0) not null,
	dob date check(dob<(current_date - 20)) not null,
	date_of_joining date check(date_of_joining between '2021-03-15' and current_date) not null,
	gender varchar(1) check(gender in('M','F')) not null,
	staff_type varchar(10) check(staff_type in('Worker','Manager')) not null
);

create table staff_contact(
	sid varchar(5) references staff(sid) on delete set null,
	phone_number numeric(10,0) unique check(phone_number>999999999),
	primary key(sid,phone_number)
);

create table product(
	pid varchar(5) primary key check(pid like 'P%'),
	pname varchar(30) not null,
	brand varchar(20) not null,
	cost numeric(10,2) check(cost>=0),
	sell_price numeric(10,2) check(sell_price>0) not null,
	avl_qty int
);

create table bill(
	bid varchar(5) primary key check(bid like 'B%'),
	cid varchar(5) references customer(cid) on delete set null,
	sid varchar(5) references staff(sid) on delete set null,
	date_of_purchase date check(date_of_purchase between '2021-03-15' and current_date) not null
);

create table bill_details(
	bid varchar(5) references bill(bid) on delete set null,
	pid varchar(5) references product(pid) on delete set null,
	qty_purchased int not null,
	primary key (bid,pid)
);

create table shipper(
	sh_id varchar(6) primary key check (sh_id like 'SH%'),
	shipper_name varchar(25)
);

create table shipper_contact(
	sh_id varchar(6) references shipper(sh_id) not null,
	phone_number numeric(10,0) unique check(phone_number>999999999),
	primary key(sh_id,phone_number)
);

create table ships(
	bid varchar(5) references bill(bid),
	sh_id varchar(6) references shipper(sh_id) not null,
	status varchar(10) check(status in('Pending','Done')),
	dispatch_date date,
	delivery_date date check(delivery_date>=dispatch_date),
	primary key(bid)
);

insert into customer VALUES
('C0001','Mohan','Lal','M','H-16 Anandita','Bakrol','Anand','Regular'),
('C0002','Ram','Sharma','M','B-34 Pramukh Greens','Chala','Vapi','Regular'),
('C0003','Shyam','Chaudhary','M','106-Ram Swaroop','Vidyanagar','Bhavanagar','Business'),
('C0004','Ankit','Singh','M','602-Green View','CG road','Ahmedabad','Regular'),
('C0005','Mrunali','Patel','F','P-50 Rajhans','Karamsad','Anand','Business'),
('C0006','Ayushi','Singh','F','104-Shiv Puja appt.','Bardoli','Surat','Business'),
('C0007','Rohit','Das','M','902 - City Tower','Sihor','Bhavnagar','Regular'),
('C0008','Aarti','Joshi','F','H-12 NeelKamal','Sabarmati','Ahmedabad','Business'),
('C0009','Anand','Nandwana','M','304-Sunshine Heights','Upleta','Rajkot','Regular'),
('C0010','Kirti','Shah','F','Plot no. 1502','Kamrej','Surat','Regular');

insert into customer_contact VALUES
('C0001',7854125898),
('C0001',9985789241),
('C0002',8782475569),
('C0003',8080457798),
('C0004',9924478563),
('C0004',9458773276),
('C0005',7086459924),
('C0005',7470848256),
('C0006',9945786632),
('C0007',7475112398),
('C0007',9978911245),
('C0008',9924466314),
('C0008',7872445635),
('C0009',6124554798),
('C0010',9947784824),
('C0010',6445708094);

insert into staff VALUES
('S0001','Raj','Malhotra',95000,'1978-05-23','2021-03-15','M','Manager'),
('S0002','Anurag','Srivastav',25000,'1987-06-12','2021-04-25','M','Worker'),
('S0003','Vaishali','Joshi',20000,'1990-04-09','2021-03-29','F','Worker'),
('S0004','Diya','Patel',20000,'1981-06-17','2022-02-11','F','Worker'),
('S0005','Het','Shah',30000,'1985-03-22','2022-09-07','M','Worker'),
('S0006','Anupam','Jain',90000,'1981-03-21','2021-03-15','M','Manager');

insert into staff_contact values
('S0001',9898745212),
('S0001',9447152365),
('S0002',7474133256),
('S0003',7887465210),
('S0003',9887985423),
('S0004',8788741125),
('S0005',8485997882),
('S0005',9998447123),
('S0006',9447144526),
('S0006',6557412258);

select * from bill;
insert into bill VALUES
('B0001','C0001','S0001','2021-05-18'),
('B0002','C0002','S0006','2021-07-24'),
('B0003','C0003','S0001','2021-07-14'),
('B0004','C0004','S0006','2021-09-03'),
('B0005','C0005','S0001','2021-10-16'),
('B0006','C0004','S0001','2021-12-07'),
('B0007','C0001','S0006','2022-01-23'),
('B0008','C0006','S0006','2022-01-26'),
('B0009','C0007','S0001','2022-03-19'),
('B0010','C0008','S0001','2022-04-27'),
('B0011','C0002','S0001','2022-05-02'),
('B0012','C0009','S0006','2022-06-24'),
('B0013','C0010','S0006','2022-09-03'),
('B0014','C0002','S0006','2022-10-15'),
('B0015','C0008','S0001','2022-11-29');

insert into product values

--fan
('P0001', 'Racer - fan', 'Usha', 1475, 1700, 30),                                 
('P0002', 'Wendy Electric - fan', 'Orient', 2350, 2700, 10),      
('P0003', 'Festiva - fan', 'Havells', 1750, 1900, 10),            
('P0004', 'Edge HS - fan', 'Bajaj', 1000, 1200, 25),              
('P0005', 'Hill Briz - fan', 'Crompton', 1100, 1400, 50),

--bulbs
('P0006', 'B22D - bulb', 'Syska', 100, 140, 80),              
('P0007', 'Dyna Ray - bulb', 'Crompton', 70, 90, 150),           
('P0008', 'Stellar Bright - bulb', 'Phillips', 225, 260, 140),              
('P0009', 'RGB LED - bulb', 'Panasonic', 555, 615, 20),              
('P0010', 'InverterX- bulb', 'Orient', 360, 400, 60),

--switches
('P0011', 'Roma - switch', 'Panasonic', 95, 120, 200),
('P0012', 'Mylinc 16A - switch', 'Legrand', 200, 230, 350),
('P0013', 'Electric 10A - switch', 'Orient', 275, 350, 50),
('P0014', 'ORO 16AX - switch', 'Havells', 270, 285, 170),
('P0015', 'Roma - switch', 'Anchor', 95, 120, 100),

--tubelights
('P0016', 'Ivora LED - tubelight', 'Bajaj', 275, 300, 100),
('P0017', 'Cool White - tubelight', 'Phillips', 825, 900, 200),
('P0018', 'Astra Line 20W - tubelight', 'Crompton', 375, 450, 150),
('P0019', 'NU+ 18W - tubelight', 'Havells', 250, 275, 170),
('P0020', 'Straight LED - tubelight', 'Syska', 325, 400, 150);

insert into bill_details VALUES
--1 -- bid -- 1,7
('B0001','P0001',80),
('B0001','P0020',150),
('B0001','P0006',20),
('B0001','P0011',40),
('B0001','P0012',25),
('B0007','P0001',30),
('B0007','P0019',10),
('B0007','P0010',50),

--2 -- bid -- 2,11,14
('B0002','P0002',20),
('B0002','P0005',20),
('B0002','P0008',30),
('B0002','P0009',100),
('B0011','P0014',40),
('B0011','P0015',50),
('B0011','P0018',10),
('B0014','P0019',15),
('B0014','P0001',20),
('B0014','P0003',50),

--3
('B0003', 'P0020', 10),
('B0003', 'P0006', 25),

--4 (2) 4,6
('B0004','P0002',100),
('B0004','P0014',75),
('B0004','P0020',80),
('B0006','P0005',50),
('B0006','P0014',20),
('B0006','P0003',40),

--5
('B0005', 'P0003', 10),
('B0005', 'P0018', 10),
('B0005', 'P0004', 10),

--6
('B0006', 'P0019', 5),
('B0006', 'P0007', 20),
('B0006', 'P0004', 15),

--7
('B0003', 'P0015', 8),
('B0003', 'P0010', 10),

--8 (2) 10,15
('B0010','P0009',25),
('B0010','P0004',20),
('B0010','P0007',40),
('B0010','P0010',100),
('B0015','P0006',50),
('B0015','P0017',110),

--9
('B0003', 'P0005', 50),

--10
('B0003', 'P0008', 20);

--not purchased products 16, 13.

insert into shipper VALUES
('SH0001','Store'),
('SH0002','Ekart-Logistics'),
('SH0003','Anjani-Services');

insert into shipper_contact values
('SH0001',9658778542),
('SH0001',8876431259),
('SH0002',7746839562),
('SH0003',9977864315),
('SH0003',9988664312);

insert into ships VALUES
('B0003','SH0001','Done','2021-07-15','2021-07-16'),
('B0007','SH0003','Done','2022-01-23','2022-01-25'),
('B0009','SH0003','Done','2022-03-20','2022-03-24'),
('B0012','SH0002','Done','2022-06-24','2022-06-26');
insert into ships values('B0014','SH0001','Pending','2022-10-16');
insert into ships values('B0015','SH0003','Pending');

--1) retrieve customer details who purchased during the tenure 27th April 2022 to 15th Oct 2022.
select cid,fname,lname,gender,house_no,street,city from customer natural join bill
		where date_of_purchase between '2022-04-27' and '2022-10-15';

--2) find customer id, name who bought fan.
select distinct(cid),fname,lname from customer natural join (bill natural join bill_details)
where pid in(select pid from product where pname like '%fan%');

--3) retrieve female customers who purchased of total >=25,000 lacs.
create view temp as (select pid, cid,bid , (sell_price*qty_purchased) as total
					 from bill natural join (bill_details natural join product));
select customer.cid, fname,lname from customer natural join temp where gender='F' and total >25000;
drop view temp;

--or

with temqp as(select pid, cid,bid , (sell_price*qty_purchased) as total from bill natural join
			  (bill_details natural join product)) select customer.cid, fname,lname,total from
			  customer natural join temqp where gender='F' and total >25000;
			  
--4) give a hike of 15% to workers who are in the shop for more than 1 year.
update staff set salary=salary*1.15 where (current_date-date_of_joining)/365 >=1 and staff_type='Worker';
select * from staff;

--5) retrieve phone numbers of customers which are of business class.
select cid,fname,lname,phone_number from customer natural join customer_contact where cust_type='Business';

--6) retrieve bills made by manager Anupam of billprice > 1 lac.
create view temp2 as (select pid, cid, bid , (sell_price*qty_purchased) as total
					  from bill natural join (bill_details natural join product));
select bid from temp2 natural join staff where fname='Anupam' and total > 100000;
drop view temp2;

--7) retrieve bulb names with available quantity less than 25.
select pname,brand from product where avl_qty <25 and pname like '%bulb%';

--8) retrieve contact details of staff with age > 35 and staff_type='worker' and gender = M.
select sid,fname,lname,phone_number from staff natural join staff_contact
					  where (current_date-dob)/365 >=35 and gender='M' and staff_type='Worker';
		
--9) retrieve products that didn't got sold since start of shop.
select distinct(product.pid),pname,brand from product,bill_details WHERE
product.pid not in(select bill_details.pid from bill_details);

--10) retrieve total amount recieved on selling products of brand crompton.
select distinct(pid),pname,sum(qty_purchased*sell_price) as total
from product natural join bill_details where brand='Crompton' group by pid;

--11) retrieve bill id and bill amount of those bills that are remaining to be delivered but have been dispatched.	
with temp(bid,total) as(select bid, sum(qty_purchased*sell_price) as total from bill_details natural join product
						group by bid)
	select temp.bid,temp.total from temp natural join ships where delivery_date is null and dispatch_date is not null;
	
--12) retrieve contact details of business class customers whose delivery is pending.
with temp as(select bid, cid,fname,lname from customer natural join bill where cust_type='Business'
							  and bid in(select bid from ships where delivery_date is null))
	select bid, fname,lname, phone_number from customer_contact natural join temp;