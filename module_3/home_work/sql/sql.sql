drop database if exists furama_study;
create database furama_study ;
use furama_study ;
create table division (
id int primary key,
name varchar(45)
);
create table education_degree (
id int primary key,
name varchar(45)
);
create table `position` (
id int primary key,
name varchar(45)
);
create table role (
role_id int primary key,
role_name varchar(45)
);
create table user (
usename varchar(255) primary key,
password varchar(255)
);
create table user_role (
role_id int,
username varchar(255),
foreign key (role_id) references role(role_id),
foreign key (username) references user(usename)
);
create table employee(
id int primary key,
name varchar(45),
date_of_birth date,
id_card varchar(45),
salary double,
phone_number varchar(45),
email varchar(45),
address varchar(45),
position_id int,
education_degeee_id int,
division_id int,
username varchar(255),
foreign key (position_id) references  `position`(id),
foreign key (education_degeee_id) references education_degree(id),
foreign key (division_id) references division(id),
foreign key (username) references  user(usename)
);
create table customer_type (
id int primary key auto_increment ,
name varchar(45)
);
create table customer (
id int primary key auto_increment,
customer_type_id int ,
`name` varchar(45),
date_of_birth date ,
gender bit(1),
id_card varchar(45),
phone_number varchar(45),
email varchar(45),
address varchar(45),
foreign key (customer_type_id) references customer_type(id)
);
create table rent_type (
id int primary key ,
`name` varchar(45)
);
create table facility_type(
id int primary key,
`name` varchar(45)
);
create table facility(
id int primary key,
`name` varchar(45),
area int,
cost double ,
max_people int ,
rent_type_id int ,
facility_type_id int ,
standard_room varchar(45),
description_other_covenience varchar(45),
poll_area double,
number_of_floors int ,
facility_free text,
foreign key (rent_type_id) references rent_type(id),
foreign key (facility_type_id) references facility_type(id)
);
create table attach_facility(
id int primary key,
`name` varchar(45),
cost double,
unit varchar(10),
`status` varchar(45)
);
create table contract (
id int primary key ,
start_date datetime,
end_date datetime,
deposit double,
employee_id int,
customer_id int,
facility_id int,
foreign key (employee_id) references employee(id),
foreign key (customer_id) references customer(id),
foreign key (facility_id) references facility(id)
);
create table contract_detail(
id int primary key ,
contract_id int ,
attach_facility_id int,
quantity int,
foreign key (attach_facility_id) references attach_facility(id),
foreign key (contract_id) references contract(id)
);
INSERT INTO customer_type values (1, 'Diamond'),
						      (2, 'Platinium'),
							  (3, 'Gold'),
						      (4, 'Silver'),
						      (5, 'Member');
INSERT INTO customer values (1,5,'Nguy???n Th??? H??o','1970-11-07',0,643431213,0945423362,'thihao07@gmail.com','23 Nguy???n Ho??ng, ???? N???ng'),
						      (2,3,'Ph???m Xu??n Di???u','1992-08-08',1,865342123,0954333333,'xuandieu92@gmail.com','K77/22 Th??i Phi??n, Qu???ng Tr???'),
						      (3,1,'Tr????ng ????nh Ngh???','1990-02-27',1,488645199,0373213122,'nghenhan2702@gmail.com','K323/12 ??ng ??ch Khi??m, Vinh'),
						      (4,1,'D????ng V??n Quan','1981-07-08',	1,543432111,0490039241,'duongquan@gmail.com','K453/12 L?? L???i, ???? N???ng'),
						      (5,4,'Ho??ng Tr???n Nhi Nhi','1995-12-09',0,795453345,0312345678,'nhinhi123@gmail.com','224 L?? Th??i T???, Gia Lai'),
						      (6,4,'T??n N??? M???c Ch??u','2005-12-06',0,732434215,0988888844,'tonnuchau@gmail.com','37 Y??n Th???, ???? N???ng'),
						      (7,1,'Nguy???n M??? Kim','1984-04-08',0,856453123,0912345698,'kimcuong84@gmail.com','K123/45 L?? L???i, H??? Ch?? Minh'),
						      (8,3,'Nguy???n Th??? H??o','1999-04-08',0,965656433,0763212345,'haohao99@gmail.com','55 Nguy???n V??n Linh, Kon Tum'),
						      (9,1,'Tr???n ?????i Danh','1994-07-01',1,432341235,0643343433,'danhhai99@gmail.com','24 L?? Th?????ng Ki???t, Qu???ng Ng??i'),
						      (10,2,'Nguy???n T??m ?????c','1989-07-01',1,344343432,0987654321,'dactam@gmail.com','22 Ng?? Quy???n, ???? N???ng');