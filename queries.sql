--1) retrieve customer details who purchased during the tenure 27th April 2022 to 15th Oct 2022.
select cid,fname,lname,gender,house_no,street,city from customer natural join bill
		where date_of_purchase between '2022-04-27' and '2022-10-15';

--2) find customer id, name who bought fan.
select distinct(cid),fname,lname from customer natural join (bill natural join bill_details)
where pid in(select pid from product where pname like '%fan%');

--3) retrieve female customers who purchased of total >=2 lacs.
create view temp as (select pid, cid,bid , (sell_price*qty_purchased) as total
					 from bill natural join (bill_details natural join product));
select customer.cid, fname,lname from customer natural join temp where gender='F' and total >25000;

--or

with temqp as(select pid, cid,bid , (sell_price*qty_purchased) as total from bill natural join
			  (bill_details natural join product)) select customer.cid, fname,lname,total from
			  customer natural join temqp where gender='F' and total >25000;
			  
--4) give a hike of 15% to workers who are in the shop for more than 1 year.
update staff set salary=salary*1.15 where (current_date-date_of_joining)/365 >=1 and staff_type='Worker';
select * from staff;

--5) retrieve phone numbers of customers which are of business class.
select cid,fname,lname,phone_number from customer natural join customer_contact where cust_type='Business';

--6) retrieve bills made by manager Anupam  of billprice > 1 lac.
create view temp2 as (select pid, cid, bid , (sell_price*qty_purchased) as total
					  from bill natural join (bill_details natural join product));
select bid from temp2 natural join staff where fname='Anupam' and total > 100000;

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
with temp(cid,fname,lname) as(select cid,fname,lname from customer natural join bill where cust_type='Business'
							  and bid in(select bid from ships where delivery_date is null))
	select fname,lname, phone_number from customer_contact natural join temp;