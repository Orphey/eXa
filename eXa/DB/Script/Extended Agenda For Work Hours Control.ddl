-- *********************************************
-- * SQL SQLite generation                     
-- *--------------------------------------------
-- * DB-MAIN version: 9.1.4              
-- * Generator date: Jun 14 2011              
-- * Generation date: Sun Jul 10 00:13:50 2011 
-- * LUN file: C:\Users\ben\Documents\Visual Studio 2010\Projects\eXaForWork\eXa\DB\DBMainFile\Extended Agenda For Work Hours Control.lun 
-- * Schema: Modèle conceptuel/0.1 
-- ********************************************* 


-- Database Section
-- ________________ 


-- Tables Section
-- _____________ 

create table CapitalJour (
     ID numeric(1) not null,
     Value char(1) not null,
     constraint ID_CapitalJour primary key (ID) --,
--     check(exists(select * from TypeJour
--                  where TypeJour.Typ_ID = ID)) 
);

--comment on table CapitalJour is 'Somme des jours de Congés, jours éducation etc..';

create table Jour (
     ID numeric(10) not null,
     HeureArrivee date,
     HeureDepart date,
     NombreHeures numeric(5,3),
     Per_ID numeric(1) not null,
     Jou_ID numeric(10) not null,
     constraint ID_Jour primary key (ID) --,
--     check(exists(select * from Lieu_Jour
--                  where Lieu_Jour.L_J_ID = ID)) 
 --,
--     check(exists(select * from Type_Journee
--                  where Type_Journee.T_J_ID = ID)) 
,
     foreign key (Per_ID) references Personne,
     foreign key (Jou_ID) references Semaine);

--comment on table Jour is 'Jour. Représente un jour de travail sur une semaine.';

create table Jour_Projet (
     J_J_ID numeric(10) not null,
     ID numeric(10) not null,
     constraint ID_Jour_Projet primary key (J_J_ID, ID),
     foreign key (ID) references Projet,
     foreign key (J_J_ID) references Jour);

create table Lieu (
     ID numeric(1) not null,
     Libelle char(1) not null,
     constraint ID_Lieu primary key (ID));

create table Lieu_Jour (
     L_J_ID numeric(10) not null,
     ID numeric(1) not null,
     constraint ID_Lieu_Jour primary key (ID, L_J_ID),
     foreign key (ID) references Lieu,
     foreign key (L_J_ID) references Jour);

create table Personne (
     ID numeric(1) not null,
     Nom varchar(128) not null,
     Prenom varchar(128) not null,
     constraint ID_Personne primary key (ID));

create table Projet (
     ID numeric(10) not null,
     Libelle varchar(128) not null,
     constraint ID_Projet primary key (ID));

--comment on table Projet is 'Projet CRB sur lequel le travail de la journée à porté.';

create table Semaine (
     ID numeric(10) not null,
     Numero numeric(2) not null,
     Annee numeric(4) not null,
     constraint ID_Semaine primary key (ID));

--comment on table Semaine is 'Semaine, Représente une semaine de l''année.';

create table Type_Journee (
     T_J_ID numeric(10) not null,
     ID numeric(10) not null,
     Matin char(2) not null,
     constraint ID_Type_Journee primary key (ID, T_J_ID),
     foreign key (ID) references TypeJour,
     foreign key (T_J_ID) references Jour);

--comment on column Type_Journee.Matin is 'AM ou PM';

create table TypeJour (
     ID numeric(10) not null,
     Libelle varchar(25) not null,
     Typ_ID numeric(1),
     constraint ID_TypeJour primary key (ID),
     foreign key (Typ_ID) references CapitalJour);

--comment on table TypeJour is 'Type de journée, Congé education, Congé, Férié, travail ou maladie.';


-- Index Section
-- _____________ 

create unique index ID_CapitalJour
     on CapitalJour (ID);

create unique index ID_Jour
     on Jour (ID);

create index FKPersonne_Jour
     on Jour (Per_ID);

create index FKJour_Semaine
     on Jour (Jou_ID);

create unique index ID_Jour_Projet
     on Jour_Projet (J_J_ID, ID);

create index FKJou_Pro
     on Jour_Projet (ID);

create unique index ID_Lieu
     on Lieu (ID);

create unique index ID_Lieu_Jour
     on Lieu_Jour (ID, L_J_ID);

create index FKLie_Jou
     on Lieu_Jour (L_J_ID);

create unique index ID_Personne
     on Personne (ID);

create unique index ID_Projet
     on Projet (ID);

create unique index ID_Semaine
     on Semaine (ID);

create unique index ID_Type_Journee
     on Type_Journee (ID, T_J_ID);

create index FKTyp_Jou
     on Type_Journee (T_J_ID);

create unique index ID_TypeJour
     on TypeJour (ID);

create index FKTypeJournee_Somme
     on TypeJour (Typ_ID);

