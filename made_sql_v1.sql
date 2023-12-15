create table Centru(
	id_centru INT UNIQUE PRIMARY KEY,
    nume_centru varchar(40) UNIQUE,
    adresa varchar(50),
	program varchar(30)
);

create table Angajat(
	id_angajat INT PRIMARY KEY,
	cnp varchar(16) UNIQUE,
    nume varchar(20),
    prenume varchar(20),
    adresa varchar(50),
    nr_telefon varchar(15),
    email varchar(30),
    iban varchar(30),
    numar_contract INT,
    functie varchar(20),
    salariu_lunar INT,
    username varchar(20) UNIQUE,
    parola varchar(33),
    id_centru INT,    
    foreign key (id_centru) references Centru(id_centru)
);

create table Medic(
	id_medic INT PRIMARY KEY,
   
    cod_parafa varchar(30),
    titlu_stiintific varchar(30),
    post_didactic varchar(30),
    procent INT,
    
    foreign key (id_medic) references Angajat(id_angajat)
    
);

create table AsistentMedical(
	id_asistent INT PRIMARY KEY,
    tip varchar(30),
    grad varchar(20),
    foreign key (id_asistent) references Angajat(id_angajat)
);

create table Specializare(
	nume_specializare varchar(30) PRIMARY KEY

);

create table Specializare_Medic (
    nume_specializare VARCHAR(30),
    id_medic INT,
	grad varchar(20),
    PRIMARY KEY (nume_specializare, id_medic)
);

alter table Specializare_Medic add constraint foreign key (nume_specializare) references Specializare(nume_specializare);
alter table Specializare_Medic add constraint foreign key (id_medic) references Medic(id_medic);

create table Functie_Dept(
   functie varchar(20) PRIMARY KEY,
   dept varchar(30)
  
);
alter table Angajat add constraint foreign key (functie) references Functie_Dept(functie);

create table Competenta(
	nume_competenta varchar(30) PRIMARY KEY
);

create table Competenta_Medic(
	nume_competenta varchar(30),
    id_medic INT,
	PRIMARY KEY (nume_competenta, id_medic),
    FOREIGN KEY (nume_competenta) references Competenta(nume_competenta),
    FOREIGN KEY (id_medic) references Medic(id_medic)
);

create table ServiciuMedical(
	id_serviciu INT PRIMARY KEY,
    nume_serviciu varchar(20),
    pret INT,
    durata_min INT

);


create table Serviciu_Competenta(
	id_serviciu INT,
    nume_competenta varchar(30),
    PRIMARY KEY(id_serviciu,nume_competenta),
    FOREIGN KEY (id_serviciu) references ServiciuMedical(id_serviciu),
    FOREIGN KEY (nume_competenta) references Competenta(nume_competenta)

);

create table Serviciu_Specializare(
	id_serviciu INT,
    nume_specializare varchar(30),
    PRIMARY KEY(id_serviciu,nume_specializare),
    FOREIGN KEY (id_serviciu) references ServiciuMedical(id_serviciu),
    FOREIGN KEY (nume_specializare) references Specializare(nume_specializare)

);

create table Centru_Serviciu(
	id_centru INT,
    id_serviciu INT,
    PRIMARY KEY(id_centru, id_serviciu),
    FOREIGN KEY (id_centru) references Centru(id_centru),
    FOREIGN KEY (id_serviciu) references ServiciuMedical(id_serviciu)

);

create table Pacient(
	id_pacient INT PRIMARY KEY,
    nume varchar(20),
    prenume varchar(20),
    CNP varchar(16) UNIQUE,
    nr_telefon varchar(15),
    email varchar(30)
);

create table Receptioner(
	id_receptioner INT PRIMARY KEY,
    FOREIGN KEY (id_receptioner) references Angajat(id_angajat)
);

create table Programare(
	id_programare INT PRIMARY KEY,
    ora time,
    data_programare date,
    id_medic INT,
    id_serviciu INT,
    id_receptioner INT,
    id_pacient INT,
    finalizat bool,
    
    FOREIGN KEY (id_medic) references Medic(id_medic),
    FOREIGN KEY (id_serviciu) references ServiciuMedical(id_serviciu),
    FOREIGN KEY (id_receptioner) references Receptioner(id_receptioner),
    FOREIGN KEY (id_pacient) references Pacient(id_pacient)
    
);

create table Raport(
	id_raport INT PRIMARY KEY,
    id_pacient INT,
    id_programare INT,
    id_asistent INT,
    detalii_raport varchar(300),
    data_completare DATE,
    FOREIGN KEY (id_pacient) references Pacient(id_pacient),
    FOREIGN KEY (id_asistent) references AsistentMedical(id_asistent),
	FOREIGN KEY (id_programare) references Programare(id_programare)
);

create table BonuriFiscale(
	id_bon INT PRIMARY KEY,
    id_raport INT,
    suma_platita INT,
    data_emitere DATE,
    FOREIGN KEY (id_raport) references Raport(id_raport)

);

create table Orar(
    id_angajat INT,
    ziua_saptamanii varchar(20),
    moment_inceput TIME,
    moment_sfarsit TIME,
	id_centru INT,
    
    PRIMARY KEY(id_angajat,ziua_saptamanii),
    FOREIGN KEY (id_angajat) references Angajat(id_angajat),
    FOREIGN KEY (id_centru) references Centru(id_centru)
);

create table Concediu(
    id_angajat INT,
    data_inceput DATE,
    data_sfarsit DATE,
    motiv varchar(100),

	PRIMARY KEY(id_angajat,data_inceput),
	FOREIGN KEY (id_angajat) references Angajat(id_angajat)
);

create table VenitLunarTotal(
	id_centru INT PRIMARY KEY,
    suma DECIMAL(10, 2),
    an_luna_zi DATE,
    FOREIGN KEY (id_centru) references Centru(id_centru)
);

create table CheltuialaLunarTotal(
	id_centru INT PRIMARY KEY,
    suma DECIMAL(10, 2),
    an_luna_zi DATE,
	FOREIGN KEY (id_centru) references Centru(id_centru)
);





