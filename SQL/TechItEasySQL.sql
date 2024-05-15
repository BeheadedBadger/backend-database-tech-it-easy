drop table if exists Users;
drop table if exists compatibleproducts;
drop table if exists products;

create table products (
	id int generated always as identity,
	brand varchar(63),
	name varchar(63),
	price int,
	currentStock int,
	productType varchar(63),
	
	refreshRate int,
	screenType varchar(63),
	screenSize int,
	
	adjustable boolean,
	maxWeight int,
	
	primary key(id)
);

create table compatibleProducts (
	productId int,
	compatibleProductsId int,	
	foreign key(productId) references products(id),
	foreign key(compatibleProductsId) references products(id)
);

insert into products(brand, name, price, currentStock, productType) 
values('Samsung', 'UE50CU7172', 400, 5, 'TV'),
('Samsung', 'BN59-01242C', 20, 12, 'Remote'),
('Samsung', 'AKSjfa-12312312', 20, 12, 'Remote'),
('LG', 'Magic Remote MR21GC', 20, 14, 'Remote'),
('LG', '32LQ63006LA', 500, 4, 'TV'),
('MyWall', 'TVM-W39284', 50, 3, 'Wall mount');

update products
set refreshRate = 60,
	screenType = 'HDR',
	screenSize = 55
where productType = 'TV' and 
	  name = 'UE50CU7172' and
	  brand = 'Samsung';

update products
set refreshRate = 60,
	screenType = 'HDR',
	screenSize = 55
where productType = 'TV' and 
	  name = '32LQ63006LA' and
	  brand = 'LG';
 
update products 
set adjustable = true,
	maxweight = 60
where productType = 'Wall mount' and
	  name = 'TVM-W39284' and
	  brand = 'MyWall';

insert into compatibleProducts(productId, compatibleProductsId)
values ((select id from products where brand = 'Samsung' and productType = 'TV' and name = 'UE50CU7172'), 
		(select id from products where brand = 'Samsung' and productType = 'Remote' and name = 'BN59-01242C')),
		((select id from products where brand = 'Samsung' and productType = 'TV' and name = 'UE50CU7172'), 
		 (select id from products where brand = 'Samsung' and productType = 'Remote' and name = 'AKSjfa-12312312')),
		((select id from products where brand = 'Samsung' and productType = 'TV' and name = 'UE50CU7172'), 
		 (select id from products where brand = 'MyWall' and productType = 'Wall mount' and name = 'TVM-W39284')),
		((select id from products where brand = 'LG' and productType = 'TV' and name = '32LQ63006LA'),
		 (select id from products where brand = 'LG' and productType = 'Remote' and name = 'Magic Remote MR21GC')),
		((select id from products where brand = 'LG' and productType = 'TV' and name = '32LQ63006LA'),
		 (select id from products where brand = 'MyWall' and productType = 'Wall mount' and name = 'TVM-W39284'));
		
select * from compatibleProducts;

create table users (
	username varChar(63),
	password varChar(63)
);

insert into users (username, password) 
values ('Ali', 'adsfjkd'), ('Ben', 'afsadfasdfs'), ('Cynthia', 'jdhfuerhiuer'), ('Dennis', 'fyjdashajej'), ('Edward', '8r7e89r32'), ('Frank', '32ehaewkjrh324uir'), ('Gerald', '1234324q23');

SELECT concat ('the ', p.productType, ' ', p.brand, ' ', p.name, ' is compatible with the ', (select productType from products where id = c.compatibleProductsId), ' ', (select brand from products where id = c.compatibleProductsId), ' ', (select name from products where id = c.compatibleProductsId)) info
FROM compatibleProducts c
INNER JOIN Products p ON p.id = c.productId;