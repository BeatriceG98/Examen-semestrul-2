create extension if not exists postgis;

create table if not exists aeroport(
fid serial primary key,
geom geometry(Polygon, 4326) not null,
nume varchar(100) not null,
tara varchar(50) not null,
oras varchar(50) not null
);

create table if not exists terminal(
fid serial primary key,
geom geometry(Polygon, 4326) not null,
nume varchar(100) not null,
tip varchar(50) not null,
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists turn_control(
fid serial primary key,
geom geometry(Point, 4326) not null,
fid_aeroport int unique not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists hangar(
fid serial primary key,
geom geometry(Polygon, 4326) not null,
capacitate_avioane int not null,
tip varchar(50),
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists piste(
fid serial primary key,
geom geometry(Polygon, 4326) not null,
cod_pista varchar(20) not null,
stare_activ boolean not null,
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists cale_acces(
fid serial primary key,
geom geometry(Linestring, 4326) not null,
tip varchar(50) not null,
nume varchar(50)null,
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists parcare(
fid serial primary key,
geom geometry(Polygon, 4326) not null,
nume varchar (50) not null,
tip varchar(50) not null,
capacitate int not null,
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists angajati(
id serial primary key,
nume varchar(100) not null,
functie varchar(100) not null,
tura varchar(30) not null,
fid_aeroport int not null,
foreign key (fid_aeroport) references aeroport(fid)
);

create table if not exists angajati_terminal(
id serial primary key,
id_angajati int not null,
fid_terminal int not null,
foreign key (id_angajati) references angajati(id),
foreign key (fid_terminal) references terminal(fid)
);

create table if not exists angajati_turn(
id serial primary key,
id_angajati int not null,
fid_turn_control int not null,
foreign key (id_angajati) references angajati(id),
foreign key (fid_turn_control) references turn_control(fid)
);

create table if not exists angajati_hangar(
id serial primary key,
id_angajati int not null,
fid_hangar int not null,
foreign key (id_angajati) references angajati(id),
foreign key (fid_hangar) references hangar(fid)
);

create table if not exists poarta_imbarcare(
fid serial primary key,
geom geometry(Point, 4326) not null,
nr_poarta int not null,
deschisa boolean not null,
fid_terminal int not null,
foreign key (fid_terminal) references terminal(fid)
);

create table if not exists pasager(
id serial primary key,
nume varchar(50) not null,
nationalitate varchar(50),
tip_bilet varchar(30)
);

create table if not exists pasager_poarta(
id serial primary key,
id_pasager int not null,
fid_poarta_imbarcare int not null,
foreign key (id_pasager) references pasager(id),
foreign key (fid_poarta_imbarcare) references poarta_imbarcare(fid)
);






INSERT INTO pasager (nume, nationalitate, tip_bilet) VALUES
('Andrei Popescu',     'română',       'plecare'),
('John Smith',         'britanică',    'sosire'),
('Maria Ionescu',      'română',       'tranzit'),
('Chen Li',            'chineză',      'plecare'),
('Sergey Ivanov',      'rusă',         'sosire'),
('Akira Sato',         'japoneză',     'plecare'),
('Pierre Dupont',      'franceză',     'plecare'),
('Alina Gheorghe',     'română',       'sosire'),
('Juan Martinez',      'spaniolă',     'tranzit'),
('Anna Müller',        'germană',      'plecare'),
('Ahmed Hassan',       'egipteană',    'plecare'),
('Olga Petrenko',      'ucraineană',   'sosire'),
('David Brown',        'americană',    'tranzit'),
('Fatima Zahra',       'marocană',     'plecare'),
('Elisa Rossi',        'italiană',     'tranzit'),
('Paul Dubois',        'franceză',     'plecare'),
('Luisa González',     'spaniolă',     'sosire'),
('Martin Fischer',     'germană',      'plecare'),
('Vasile Popa',        'română',       'sosire'),
('Kim Min-jun',        'coreeană',     'plecare'),
('Sandra Nowak',       'poloneză',     'tranzit'),
('Hanna Jensen',       'daneză',       'plecare'),
('Omar Khalil',        'arabă',        'tranzit'),
('Elena Ionescu',      'română',       'sosire'),
('Lars Svensson',      'suedeză',      'plecare');




INSERT INTO angajati (nume, functie, tura, fid_aeroport) VALUES
('Popescu Mihai',      'controlor trafic',     'zi',      1),
('Ionescu Elena',      'operator check-in',    'noapte',  1),
('Stanciu Radu',       'agent securitate',     'zi',      1),
('Petrescu Ana',       'tehnician pista',      'noapte',  1),
('Tanase Mircea',      'inginer hangar',       'zi',      1),
('George Smith',       'operator bagaje',      'noapte',  1),
('Petre Ion',          'pompier ISU',          'zi',      1),
('Sebastian Müller',   'pilot testare',        'zi',      1),
('Zhang Wei',          'operator catering',    'noapte',  1),
('Ivan Ivanov',        'agent securitate',     'zi',      1),
('Cristina Pop',       'asistent handling',    'noapte',  1),
('Vasile Stoica',      'supervizor terminal',  'zi',      1),
('Maria Toma',         'inginer electric',     'zi',      1),
('David Johnson',      'tehnician IT',         'noapte',  1),
('Laura Oprea',        'curatenie terminal',   'zi',      1);



INSERT INTO angajati_terminal (id_angajati, fid_terminal) VALUES
(2,3),
(4,7),
(6,5),
(9,2),
(10,1),
(12,3),
(15,4);

INSERT INTO angajati_hangar (id_angajati, fid_hangar) VALUES
(5, 2),
(13, 3),
(14, 6),
(11, 5),
(7, 11);

INSERT INTO angajati_turn (id_angajati, fid_turn_control) VALUES
(1, 1),
(8, 1),
(3, 1); 


INSERT INTO pasager_poarta (id_pasager, fid_poarta_imbarcare) VALUES
(1, 21), 
(2, 12), 
(3, 26), 
(4, 18), 
(5,79), 
(6, 21), 
(7, 21),
(8, 79), 
(9, 26), 
(10, 92), 
(11, 92), 
(12, 8), 
(13, 13), 
(14, 93),
(15, 55), 
(16, 102), 
(17, 85), 
(18, 102), 
(19, 82), 
(20, 102),
(21, 79), 
(22, 18), 
(23, 81), 
(24, 79), 
(25, 18);