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