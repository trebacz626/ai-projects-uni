create table Members (
    nickname varchar(100) primary key,
    name varchar(100) not null,
    surname varchar(100) not null,
    data_of_birth date not null,
    address varchar(100) not null,
    e_mail varchar(100) not null,
    phone_no varchar(50) not null
);
create table Sections(
    name varchar(100) primary key,
    leader varchar(100) not null references Members(nickname)
);
create table SectionMembers(
    nickname varchar(100) references Members(nickname),
    section_name varchar(100) references Sections(name),
    primary key (nickname, section_name)
);
create table Bike_types(name varchar(100) primary key,);
create table Bikes(
    bike_id number(10) primary key,
    bike_name varchar(100) not null,
    production_date date not null,
    model varchar(100),
    bike_owner varchar(100) not null references Members(nickname),
    bike_type varchar(100) not null references Bike_types(name),
    manufacturer varchar(100) references Manufacturers(name),
    unique key(bike_name, bike_owner)
);
create table Manufacturers(name varchar(100) primary key);
create table Part_types(name varchar(100) primary key);
create table Parts(
    name varchar(100) not null,
    manufacturer varchar(100) not null reference Manufacturers(name),
    part_type varchar(100) not null references Part_types(name),
    primary key (name, manufacturer)
);
create table Bike_parts(
    bike_id number(10) not null references Bikes(bike_id),
    name varchar(100),
    manufacturer varchar(100),
    foreign key (name, manufacturer) references Parts(name, manufacturer),
    primary key (bike_id, name, manufacturer)
);
create table Functions(
    name varchar(100) primary key,
    number_of_members number(2)
);
create table Cadence(
    start_with date,
    end_at date,
    function_name varchar(100) not null references Functions(name),
    nickname varchar(100) not null references Members(nickname),
    primary key (start_with, function_name, nickname)
);
create table Trips(
    name varchar(100) primary key,
    start_at date not null,
    start_location varchar(100) not null,
    end_location varchar(100) not null,
    total_distance number(5, 2) not null,
    cost_of_participation number(6, 2) not null,
    trip_type char(1) not null check(trip_type in ('O', 'M')),
    end_date date,
    daily_distance number(5, 2)
);
create table Trips_declarations (
    is_fee_paid char(1) not null check(is_fee_paid in ('Y', 'N')),
    nickname varchar(100) references Members(nickname),
    trip_name varchar(100) references Trips(trip_name),
    primary key (nickname, trip_name)
);