drop table if exists UserFavs;
drop table if exists UserDonations;
drop table if exists Users;
drop table if exists Animals;
drop table if exists Shelters;

create table Shelters (
	id int generated always as identity,
	name varchar(63),
	passWord varchar(63),
	address varchar(63),
	city varchar(63),
	postalCode varchar(6),
	email varchar(63),
	telephoneNr int,
	speciality varchar(63),
	primary key(id)
);

create table Animals (
	id int generated always as identity,
	shelterId int,
	name varchar(63),
	age int,
	sex varchar(63),
	species varchar(63),
	status varchar(63),
	foreign key(shelterId) references Shelters(id),
	primary key(id)
);

create table Users (
	id int generated always as identity,
	userName varchar(63),
	passWord varchar(63),
	city varchar(63),
	primary key(id)
);

create table UserFavs (
	id int generated always as identity,
	idUser int,
	idAnimal int,
	foreign key(idUser) references Users(id),
	foreign key(idAnimal) references Animals(id),
	primary key(id)
);

create table UserDonations (
	id int generated always as identity,
	idUser int,
	idShelter int,
	idAnimal int,
	foreign key(idUser) references Users(id),
	foreign key (idShelter) references Shelters(id),
	foreign key(idAnimal) references Animals(id),
	primary key(id)
);

insert into Shelters(name, address, city, postalCode, email, telephoneNr, speciality) 
values('Reptielenopvang Zwanenburg', '', 'Zwanenburg', '', '', 0, 'Reptielen'),
('Het Knagertje', '', 'Den Haag', '', '', 0, 'Knaagdieren'),
('Animal Home', '', 'Zoetermeer', '', '', 0, 'Konijnen'),
('Frettig Gestoord', '', 'Utrecht', '', '', 0, 'Fretten');

insert into Animals(shelterId, name, age, sex, species, status)
values ((select id from Shelters where name = 'Reptielenopvang Zwanenburg'), '14389', 6, 'f', 'Koningspython', 'no-longer-available'),
((select id from Shelters where name = 'Frettig Gestoord'), 'Fred', 2, 'm', 'Fret', 'available'),
((select id from Shelters where name = 'Animal Home'), 'Stampertje', 3, 'm', 'Konijn', 'available'),
((select id from Shelters where name = 'Animal Home'), 'Vlekkie', 2, 'f', 'Konijn', 'available'),
((select id from Shelters where name = 'Reptielenopvang Zwanenburg'), '12321', 2, 'x', 'Regenboogboa', 'no-longer-available'),
((select id from Shelters where name = 'Het Knagertje'), 'M2324', 1, 'f', 'Kleurmuis', 'avaiable'),
((select id from Shelters where name = 'Het Knagertje'), 'C2139', 3, 'm', 'Chinchilla', 'avaiable');