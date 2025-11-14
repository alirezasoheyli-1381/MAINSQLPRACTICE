use test01

drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

/*"PROBLEM STATEMENT: 
Write an sql query to merge products per customer for each day as shown in expected output."*/						
						
-- challenge 1					
SELECT distinct dates,STRING_AGG(cast(product_id as varchar) ,',') AS AllEmployeeNames
FROM orders
group by customer_id,dates
union 
select dates,cast (product_id as varchar) from orders



drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);
insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');

-- challenge 2
select [value],sum([good]) as good,sum([wrong]) as wrong,sum([regular]) as regular
from (
	select * from auto_repair
	where indicator = 'level') as fl
	pivot(	
		count([value])
		for value in ([good],[regular],[wrong])) as pv
join (select  * from auto_repair
where indicator = 'velocity') as T on T.client = pv.client and T.auto = pv.auto and T.repair_date = pv.repair_date
group by [value]


