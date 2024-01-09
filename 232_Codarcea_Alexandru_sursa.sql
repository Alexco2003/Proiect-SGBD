--4

CREATE SEQUENCE sala_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE sponsor_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE echipament_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE locatie_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE angajat_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE vestiar_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE antrenament_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE clasa_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE membru_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE abonament_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE SALA (
  id_sala INT DEFAULT sala_seq.NEXTVAL PRIMARY KEY,
  nume_sala VARCHAR(50)
);

CREATE TABLE SPONSOR (
  id_sponsor INT DEFAULT sponsor_seq.NEXTVAL PRIMARY KEY,
  nume_sponsor VARCHAR(50)
);

CREATE TABLE CONTRACT_SPONSOR (
  id_sala INT,
  id_sponsor INT,
  data_contract DATE,
  PRIMARY KEY (id_sala, id_sponsor),
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
  FOREIGN KEY (id_sponsor) REFERENCES SPONSOR(id_sponsor)
);

CREATE TABLE ECHIPAMENT (
  id_echipament INT DEFAULT echipament_seq.NEXTVAL PRIMARY KEY,
  nume VARCHAR(50),
  id_sala INT,
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE LOCATIE (
  id_adresa INT DEFAULT locatie_seq.NEXTVAL PRIMARY KEY,
  oras_locatie VARCHAR(50),
  tara_locatie VARCHAR(50),
  id_sala INT,
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE ANGAJAT (
  id_angajat INT DEFAULT angajat_seq.NEXTVAL PRIMARY KEY,
  nume_angajat VARCHAR(50),
  id_sala INT,
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE INGRIJITOR (
  id_angajat INT PRIMARY KEY REFERENCES ANGAJAT(id_angajat)
);

CREATE TABLE ANTRENOR (
id_angajat INT PRIMARY KEY REFERENCES ANGAJAT(id_angajat),
specializare VARCHAR(50)
);

CREATE TABLE VESTIAR (
  id_vestiar INT DEFAULT vestiar_seq.NEXTVAL PRIMARY KEY,
  tip_vestiar CHAR(1),
  capacitate INT,
  id_sala INT,
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
  CONSTRAINT ck_capacitate CHECK (capacitate >= 25)
);

CREATE TABLE INGRIJESTE (
  id_ingrijitor INT,
  id_vestiar INT,
  PRIMARY KEY (id_ingrijitor, id_vestiar),
  FOREIGN KEY (id_ingrijitor) REFERENCES INGRIJITOR(id_angajat),
  FOREIGN KEY (id_vestiar) REFERENCES VESTIAR(id_vestiar)
);

CREATE TABLE PROGRAME (
  id_antrenament INT DEFAULT antrenament_seq.NEXTVAL PRIMARY KEY,
  nume VARCHAR(50),
  timp_start DATE,
  timp_final DATE,
  id_angajat INT,
  FOREIGN KEY (id_angajat) REFERENCES ANTRENOR(id_angajat)
);

CREATE TABLE CLASA (
  id_clasa INT DEFAULT clasa_seq.NEXTVAL PRIMARY KEY,
  data DATE
);

CREATE TABLE FOLOSESTE (
  id_antrenament INT,
  id_clasa INT,
  PRIMARY KEY (id_antrenament, id_clasa),
  FOREIGN KEY (id_antrenament) REFERENCES PROGRAME(id_antrenament),
  FOREIGN KEY (id_clasa) REFERENCES CLASA(id_clasa)
);

CREATE TABLE MEMBRU (
  id_membru INT DEFAULT membru_seq.NEXTVAL PRIMARY KEY,
  nume VARCHAR(50),
  data_nasterii DATE,
  id_sala INT,
  FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE ABONAMENT (
  id_abonament INT DEFAULT abonament_seq.NEXTVAL PRIMARY KEY,
  tip_abonament VARCHAR(50),
  pret DECIMAL(10, 2),
  id_membru INT,
  FOREIGN KEY (id_membru) REFERENCES MEMBRU(id_membru),
  CONSTRAINT uc_id_membru UNIQUE (id_membru)
);

CREATE TABLE FORMULAR (
  id_clasa INT,
  id_antrenor INT,
  id_membru INT,
  PRIMARY KEY (id_clasa, id_antrenor, id_membru),
  FOREIGN KEY (id_clasa) REFERENCES CLASA(id_clasa),
  FOREIGN KEY (id_antrenor) REFERENCES ANTRENOR(id_angajat),
  FOREIGN KEY (id_membru) REFERENCES MEMBRU(id_membru)
);


--5

INSERT INTO SALA (nume_sala) VALUES ('World Class'); --SALA1
INSERT INTO SALA (nume_sala) VALUES ('Fit Gym'); --SALA2
INSERT INTO SALA (nume_sala) VALUES ('Fitness Zone'); --SALA3
INSERT INTO SALA (nume_sala) VALUES ('Gym Plus'); --SALA4
INSERT INTO SALA (nume_sala) VALUES ('Power Fitness'); --SALA5
SELECT * FROM SALA;

INSERT INTO SPONSOR (nume_sponsor) VALUES ('Nike');
INSERT INTO SPONSOR (nume_sponsor) VALUES ('Adidas');
INSERT INTO SPONSOR (nume_sponsor) VALUES ('Reebok');
INSERT INTO SPONSOR (nume_sponsor) VALUES ('Puma');
INSERT INTO SPONSOR (nume_sponsor) VALUES ('Under Armour');

SELECT * FROM SPONSOR;  

INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (3, 3, TO_DATE('2023-03-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (4, 4, TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (5, 5, TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (1, 2, TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (2, 3, TO_DATE('2023-07-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (3, 4, TO_DATE('2023-08-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (4, 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (5, 1, TO_DATE('2023-10-01', 'YYYY-MM-DD'));

SELECT * FROM CONTRACT_SPONSOR; 

INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Bicicleta stationara', 1);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Stepper', 1);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Benzi de alergare', 1);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Banca pentru abdomene', 1);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Trambulina', 1);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Haltere', 2);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Bara de tractiuni', 2);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Greutati', 2);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Banca de antrenament', 2);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Sfoara', 2);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Gantere', 3);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Saltele de yoga', 3);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Benzi elastice', 3);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Minge medicinala', 3);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Sac de box', 3);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Bara olimpica', 4);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Discuri', 4);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Helcometru', 4);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Extensii de picioare', 4);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Impins la piept inclinat', 4);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Inele', 5);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Scandura de echilibru', 5);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Ghete pentru sarituri', 5);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Squat-rack', 5);
INSERT INTO ECHIPAMENT (nume, id_sala) VALUES ('Coarda de sarit', 5);

SELECT * FROM ECHIPAMENT; 

INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Bucuresti', 'Romania', 1);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('New York', 'Statele Unite', 1);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Timisoara', 'Romania', 2);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Iasi', 'Romania', 3);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Marseille', 'Franța', 3);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Hamburg', 'Germania', 3);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Berna', 'Elveția', 3);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Craiova', 'Romania', 4);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Nantes', 'Franța', 4);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Cologne', 'Germania', 4);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Oradea', 'Romania', 5);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Bordeaux', 'Franța', 5);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Stuttgart', 'Germania', 5);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('London', 'Marea Britanie', 5);
INSERT INTO LOCATIE (oras_locatie, tara_locatie, id_sala) VALUES ('Beijing', 'China', 5);

SELECT * FROM LOCATIE; 

INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Popescu Ion', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Ionescu Maria', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Georgescu Andrei', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Constantin Elena', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Dumitru Radu', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Popa Ana', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Gheorghe Alexandru', 1);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Mihai Ioana', 2);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Apostol Stefan', 2);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Radulescu Andreea', 2);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Stancu Daniel', 2);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Petrescu Gabriela', 2);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Dragomir Valentin', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Preda Adriana', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Neagu Bogdan', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Gavrilă Elena', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Dobrescu Ionut', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Cojocaru Mihaela', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Stanescu Andrei', 3);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Popovici Raluca', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Avram Mihai', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Florea Alexandra', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Munteanu Bogdana', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Voinea Alexandru', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Constantinescu Diana', 4);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Moldovan Ionel', 5);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Diaconu Gabriela', 5);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Stoica Adrian', 5);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Gheorghiu Maria', 5);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Iacob Andrei', 5);
INSERT INTO ANGAJAT (nume_angajat, id_sala) VALUES ('Stan Mirela', 5);

SELECT * FROM ANGAJAT; 

--SALA1
INSERT INTO INGRIJITOR (id_angajat) VALUES (1);
INSERT INTO INGRIJITOR (id_angajat) VALUES (2);
INSERT INTO INGRIJITOR (id_angajat) VALUES (3);
--SALA2
INSERT INTO INGRIJITOR (id_angajat) VALUES (8);
INSERT INTO INGRIJITOR (id_angajat) VALUES (9);
--SALA3
INSERT INTO INGRIJITOR (id_angajat) VALUES (13);
INSERT INTO INGRIJITOR (id_angajat) VALUES (14);
INSERT INTO INGRIJITOR (id_angajat) VALUES (15);
INSERT INTO INGRIJITOR (id_angajat) VALUES (16);
--SALA4
INSERT INTO INGRIJITOR (id_angajat) VALUES (20);
INSERT INTO INGRIJITOR (id_angajat) VALUES (21);
INSERT INTO INGRIJITOR (id_angajat) VALUES (22);
--SALA5
INSERT INTO INGRIJITOR (id_angajat) VALUES (26);
INSERT INTO INGRIJITOR (id_angajat) VALUES (27);

SELECT * FROM INGRIJITOR; 

--SALA1
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (4, 'Fitness');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (5, 'Yoga');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (6, 'Pilates');
--SALA2
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (10, 'Crossfit');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (11, NULL);
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (12, 'Aerobic');
--SALA3
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (17, 'Crossfit');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (18, 'Aerobic');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (19, 'Powerlifting');
--SALA4
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (23, 'Bodybuilding');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (24, 'Aerobic');
--SALA5
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (28, 'Yoga');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (29, 'Fitness');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (30, 'Aerobic');
INSERT INTO ANTRENOR (id_angajat, specializare) VALUES (31, NULL);

SELECT * FROM ANTRENOR; 

--SALA1
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 50, 1);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 60, 1);
--SALA2
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 40, 2);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 30, 2);
--SALA3
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 100, 3);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 80, 3);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 120, 3);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 90, 3);
--SALA4
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 40, 4);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 35, 4);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 55, 4);
--SALA5
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 70, 5);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 60, 5);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('M', 90, 5);
INSERT INTO VESTIAR (tip_vestiar, capacitate, id_sala) VALUES ('F', 80, 5);

SELECT * FROM VESTIAR; 

--SALA1
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (1, 1);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (2, 2);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (3, 1);
--SALA2
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (8, 4);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (9, 3);
--SALA3
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (13, 5);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (14, 6);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (15, 7);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (16, 8);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (16, 7);
--SALA4
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (20, 9);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (21, 10);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (22, 11);
--SALA5
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (26, 12);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (27, 13);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (26, 14);
INSERT INTO INGRIJESTE (id_ingrijitor, id_vestiar) VALUES (27, 15);

SELECT * FROM INGRIJESTE; 

--SALA1
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Antrenament cardio', TO_DATE('2023-05-18 09:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-05-18 10:00', 'YYYY-MM-DD HH24:MI'), 4);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Antrenament functional', TO_DATE('2023-06-30 16:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-06-30 17:30', 'YYYY-MM-DD HH24:MI'), 4);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Yoga relaxare', TO_DATE('2023-08-12 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-08-12 11:00', 'YYYY-MM-DD HH24:MI'), 5);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Pilates postural', TO_DATE('2023-09-24 15:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-24 16:30', 'YYYY-MM-DD HH24:MI'), 6);
--SALA2
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Antrenament de bază', TO_DATE('2023-11-05 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-05 15:00', 'YYYY-MM-DD HH24:MI'), 10);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Yoga ashtanga', TO_DATE('2023-12-17 18:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-12-17 19:30', 'YYYY-MM-DD HH24:MI'), 12);
--SALA3
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Crossfit challenge', TO_DATE('2024-01-29 13:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-01-29 14:30', 'YYYY-MM-DD HH24:MI'), 17);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Aerobic step up', TO_DATE('2024-03-11 16:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-03-11 17:00', 'YYYY-MM-DD HH24:MI'), 18);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Aerobic dance party', TO_DATE('2024-04-22 19:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-04-22 20:30', 'YYYY-MM-DD HH24:MI'), 19);
--SALA4
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Pilates sculpting', TO_DATE('2024-06-03 11:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-06-03 12:30', 'YYYY-MM-DD HH24:MI'), 23);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Functional circuit', TO_DATE('2024-07-15 15:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-07-15 16:00', 'YYYY-MM-DD HH24:MI'), 24);
--SALA5
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Aerobic intens', TO_DATE('2024-08-26 17:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-08-26 18:30', 'YYYY-MM-DD HH24:MI'), 28);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Aerobic dance mix', TO_DATE('2024-10-07 20:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-10-07 21:00', 'YYYY-MM-DD HH24:MI'), 29);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Pilates core', TO_DATE('2024-11-18 12:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-11-18 13:00', 'YYYY-MM-DD HH24:MI'), 30);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Yoga vinyasa', TO_DATE('2024-12-30 14:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-12-30 15:30', 'YYYY-MM-DD HH24:MI'), 31);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Antrenament functional', TO_DATE('2025-02-10 16:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-02-10 17:30', 'YYYY-MM-DD HH24:MI'), 31);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Yoga relaxare', TO_DATE('2025-03-23 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-03-23 11:00', 'YYYY-MM-DD HH24:MI'), 31);
INSERT INTO PROGRAME (nume, timp_start, timp_final, id_angajat) VALUES ('Pilates postural', TO_DATE('2025-05-04 15:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-05-04 16:30', 'YYYY-MM-DD HH24:MI'), 31);

SELECT * FROM PROGRAME; 

INSERT INTO CLASA (data) VALUES (TO_DATE('2023-05-18', 'YYYY-MM-DD'));
INSERT INTO CLASA (data) VALUES (TO_DATE('2023-05-19', 'YYYY-MM-DD'));
INSERT INTO CLASA (data) VALUES (TO_DATE('2023-05-20', 'YYYY-MM-DD'));
INSERT INTO CLASA (data) VALUES (TO_DATE('2023-05-21', 'YYYY-MM-DD'));
INSERT INTO CLASA (data) VALUES (TO_DATE('2023-05-22', 'YYYY-MM-DD'));

SELECT * FROM CLASA; 

INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (11, 1);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (12, 2);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (18, 1);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (12, 3);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (3, 2);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (7, 4);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (8, 3);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (15, 5);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (9, 1);
INSERT INTO FOLOSESTE (id_antrenament, id_clasa) VALUES (3, 4);

SELECT * FROM FOLOSESTE; 

INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Popescu Ion', TO_DATE('1990-03-15', 'YYYY-MM-DD'), 1);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Radu Maria', TO_DATE('1985-07-22', 'YYYY-MM-DD'), 1);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Ionescu Andrei', TO_DATE('1995-11-05', 'YYYY-MM-DD'), 1);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Georgescu Ana', TO_DATE('1988-09-18', 'YYYY-MM-DD'), 1);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Stanescu Mihaela', TO_DATE('1992-06-27', 'YYYY-MM-DD'), 1);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Dumitru Dan', TO_DATE('1991-02-10', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Gheorghiu Elena', TO_DATE('1987-04-25', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Mihai Andrei', TO_DATE('1994-08-12', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Florescu Alina', TO_DATE('1989-01-03', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Stefanescu Ioana', TO_DATE('1993-12-08', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Diaconu Ionut', TO_DATE('1990-05-20', 'YYYY-MM-DD'), 2);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Popa George', TO_DATE('1986-10-17', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Gavril Alexandra', TO_DATE('1995-09-02', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Marinescu Adrian', TO_DATE('1991-06-14', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Barbu Gabriela', TO_DATE('1988-03-28', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Constantinescu Ana', TO_DATE('1993-11-10', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Dobre Radu', TO_DATE('1992-07-06', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Andrei Mihaela', TO_DATE('1987-04-19', 'YYYY-MM-DD'), 3);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Iacob Marius', TO_DATE('1990-09-12', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Voicu Ana', TO_DATE('1986-05-25', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Cristescu Andrei', TO_DATE('1992-12-03', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Munteanu Elena', TO_DATE('1989-02-15', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Alexandrescu Ana', TO_DATE('1994-11-07', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Popescu Ioan', TO_DATE('1993-07-01', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Dinu Mihaela', TO_DATE('1988-03-22', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Ionescu Florin', TO_DATE('1991-06-09', 'YYYY-MM-DD'), 4);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Andrei Catalin', TO_DATE('1990-01-29', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Stan Maria', TO_DATE('1987-08-14', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Gheorghe Mihai', TO_DATE('1992-04-05', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Dumitrescu Elena', TO_DATE('1989-10-23', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Stefan Maria', TO_DATE('1994-03-11', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Popa Ionut', TO_DATE('1993-12-02', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Radu Alexandra', TO_DATE('1988-07-16', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Marin Florina', TO_DATE('1991-05-03', 'YYYY-MM-DD'), 5);
INSERT INTO MEMBRU (nume, data_nasterii, id_sala) VALUES ('Dobre Andrei', TO_DATE('1996-02-27', 'YYYY-MM-DD'), 5);

SELECT * FROM MEMBRU; 

--SALA1
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 100.00, 1);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Silver', 150.00, 2);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Gold', 200.00, 3);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 250.00, 4);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 300.00, 5);
--SALA2
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 120.00, 6);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Silver', 170.00, 7);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Gold', 220.00, 8);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 270.00, 9);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 320.00, 10);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 320.00, 11);
--SALA3
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 110.00, 12);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Silver', 160.00, 13);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Gold', 210.00, 14);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 260.00, 15);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 310.00, 16);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 310.00, 17);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 110.00, 18);
--SALA4
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Silver', 180.00, 19);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Gold', 230.00, 20);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 280.00, 21);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 330.00, 22);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 330.00, 23);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 330.00, 24);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 330.00, 25);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 140.00, 26);
--SALA5
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Silver', 190.00, 27);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Gold', 240.00, 28);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 290.00, 29);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 290.00, 30);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Platinum', 290.00, 31);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 340.00, 32);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 130.00, 33);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Diamond', 340.00, 34);
INSERT INTO ABONAMENT (tip_abonament, pret, id_membru) VALUES ('Abonament Bronze', 130.00, 35);

SELECT * FROM ABONAMENT; 

--SALA1
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 4, 1);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 4, 2);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 4, 3);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 4, 4);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 4, 5);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (2, 6, 3);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (2, 6, 4);
--SALA2
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 6);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 7);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 8);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 9);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 10);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 11, 11);
--SALA3
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 18, 12);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 18, 13);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 18, 14);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 18, 15);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 17, 16);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 17, 17);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 19, 18);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 19, 12);
--SALA4
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 23, 19);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 23, 20);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 23, 21);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (4, 23, 22);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 24, 23);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 24, 24);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 24, 25);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 24, 19);
--SALA5
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 28, 27);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (3, 28, 28);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (2, 29, 29);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (2, 29, 30);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 30, 31);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (1, 30, 32);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 31, 33);
INSERT INTO FORMULAR (id_clasa, id_antrenor, id_membru) VALUES (5, 31, 34);

SELECT * FROM FORMULAR; 


--6

CREATE OR REPLACE PROCEDURE afisare_informatii_sala 
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
IS
    TYPE tablou_indexat IS TABLE OF VARCHAR(50) INDEX BY PLS_INTEGER;
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    TYPE tablou_vector IS VARRAY(20) OF VARCHAR(50);

    v_lista_angajati tablou_indexat := tablou_indexat();
    v_lista_membrii tablou_imbricat := tablou_imbricat();
    v_lista_locatii tablou_vector := tablou_vector();
    
    v_nume_sala VARCHAR(50);

BEGIN
   
    SELECT nume_sala 
    INTO v_nume_sala 
    FROM sala 
    WHERE id_sala = v_id_sala;

    FOR angajat IN (SELECT id_angajat, nume_angajat FROM angajat WHERE id_sala = v_id_sala)
    LOOP
        v_lista_angajati(angajat.id_angajat) := angajat.nume_angajat;
    END LOOP;

    FOR membru IN (SELECT id_membru FROM membru WHERE id_sala = v_id_sala)
    LOOP
        v_lista_membrii.extend;
        v_lista_membrii(v_lista_membrii.last) := membru.id_membru;
    END LOOP;

    FOR locatie IN (SELECT oras_locatie FROM locatie WHERE id_sala = v_id_sala)
    LOOP
        v_lista_locatii.extend;
        v_lista_locatii(v_lista_locatii.last) := locatie.oras_locatie;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Informatii despre sala ' || v_nume_sala || ':');

    DBMS_OUTPUT.PUT_LINE('Lista angajati:');
    FOR i IN v_lista_angajati.first .. v_lista_angajati.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_angajati(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Lista membrii (id-urile):');
    FOR i IN v_lista_membrii.first .. v_lista_membrii.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_membrii(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Lista locatii (orasele):');
    FOR i IN v_lista_locatii.first .. v_lista_locatii.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_locatii(i));
    END LOOP;
   
END afisare_informatii_sala;
/

DROP PROCEDURE afisare_informatii_sala;

BEGIN
 afisare_informatii_sala;
END;
/

BEGIN
 afisare_informatii_sala(1);
END;
/

BEGIN
 afisare_informatii_sala(2);
END;
/

BEGIN
 afisare_informatii_sala(4);
END;
/


--7

CREATE OR REPLACE PROCEDURE afisare_informatii_vestiare
    (v_id_sala sala.id_sala%TYPE DEFAULT 1) 
IS
    v_nume_sala sala.nume_sala%TYPE;
    v_id_vestiar vestiar.id_vestiar%TYPE;
    v_tip CHAR(1);
    v_capacitate INT;
    v_id_ingrijitor INT;
    v_nume_angajat VARCHAR(50);
    
    CURSOR c_vestiar IS
     SELECT id_vestiar, tip_vestiar, capacitate
     FROM vestiar
     WHERE id_sala=v_id_sala;

    CURSOR c_ingrijitor (vestiar_id vestiar.id_vestiar%TYPE) IS
     SELECT id_ingrijitor, nume_angajat
     FROM ingrijeste i, angajat a
     WHERE i.id_vestiar = vestiar_id and a.id_angajat=i.id_ingrijitor;

BEGIN
   
   SELECT nume_sala 
    INTO v_nume_sala 
    FROM sala 
    WHERE id_sala = v_id_sala;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Informatii despre vestiarele salii ' || v_nume_sala || ':');
    
   OPEN c_vestiar;
   
   LOOP
    FETCH c_vestiar INTO v_id_vestiar, v_tip, v_capacitate;
    EXIT WHEN c_vestiar%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Vestiarul ' || v_id_vestiar || ' de tipul ' || v_tip || ' si cu capacitatea ' || v_capacitate || '.');
    DBMS_OUTPUT.PUT_LINE('Lista ingrijitorilor: ');
    
    FOR ingrijitor_i IN c_ingrijitor(v_id_vestiar) LOOP
        DBMS_OUTPUT.PUT_LINE(ingrijitor_i.id_ingrijitor || '. '|| ingrijitor_i.nume_angajat);
    END LOOP;
    
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
   CLOSE c_vestiar;
   
END afisare_informatii_vestiare;
/


DROP PROCEDURE afisare_informatii_vestiare;

BEGIN
 afisare_informatii_vestiare;
END;
/

BEGIN
 afisare_informatii_vestiare(1);
END;
/

BEGIN
 afisare_informatii_vestiare(2);
END;
/

BEGIN
 afisare_informatii_vestiare(4);
END;
/


--8

CREATE OR REPLACE FUNCTION suma_bani
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
RETURN abonament.pret%TYPE IS
    v_suma abonament.pret%TYPE;
    exceptie1 EXCEPTION;
    exceptie2 EXCEPTION;
BEGIN
    BEGIN
        SELECT SUM(a.pret)
        INTO v_suma
        FROM abonament a
        JOIN membru m ON m.id_membru = a.id_membru
        JOIN sala s ON s.id_sala = m.id_sala
        WHERE s.id_sala = v_id_sala;
        
        IF v_suma <= 1000 THEN
            RAISE exceptie1;
        END IF;
        
        IF v_suma <= 2000 THEN
            RAISE exceptie2;
        END IF;
        
    EXCEPTION
        WHEN exceptie1 THEN
            DBMS_OUTPUT.PUT_LINE('Sala este in faliment!');
        WHEN exceptie2 THEN
            DBMS_OUTPUT.PUT_LINE('Sala este aproape de faliment!');
    END;

    RETURN v_suma;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Alta eroare!');
        
END suma_bani;
/


DROP FUNCTION suma_bani;


BEGIN
 DBMS_OUTPUT.PUT_LINE(suma_bani);
END;
/

BEGIN
 DBMS_OUTPUT.PUT_LINE(suma_bani(1));
END;
/

BEGIN
 DBMS_OUTPUT.PUT_LINE(suma_bani(2));
END;
/

BEGIN
 DBMS_OUTPUT.PUT_LINE(suma_bani(5));
END;
/


--9

CREATE OR REPLACE PROCEDURE afisare_antrenorul_anului
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
IS
    v_nume_angajat angajat.nume_angajat%type;
    BEGIN
    
        SELECT a1.nume_angajat
        INTO v_nume_angajat
        FROM angajat a1
        JOIN antrenor a2 ON a1.id_angajat = a2.id_angajat
        JOIN programe p ON p.id_angajat = a1.id_angajat
        JOIN foloseste f ON f.id_antrenament = p.id_antrenament
        JOIN sala s ON s.id_sala = a1.id_sala
        WHERE s.id_sala = v_id_sala
        GROUP BY a1.nume_angajat
        HAVING COUNT(*) = (
                            SELECT MAX(cnt)
                            FROM (
                                SELECT COUNT(*) as cnt
                                FROM angajat a3
                                JOIN antrenor a4 ON a3.id_angajat = a4.id_angajat
                                JOIN programe p2 ON p2.id_angajat = a3.id_angajat
                                JOIN foloseste f2 ON f2.id_antrenament = p2.id_antrenament
                                JOIN sala s2 ON s2.id_sala = a3.id_sala
                                GROUP BY s2.nume_sala, a3.nume_angajat
                                )
                            );

        
        DBMS_OUTPUT.PUT_LINE('Antrenorul anului este ' || v_nume_angajat || '.');
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Nu exista antrenori eligibili pentru castigarea titlului in sala cu id-ul dat.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi antrenori eligibili pentru castigarea titlului. Va rugam frumos contactati managerul salii respective.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END afisare_antrenorul_anului;
/

DROP PROCEDURE afisare_antrenorul_anului;

BEGIN
 afisare_antrenorul_anului;
END;
/

BEGIN
 afisare_antrenorul_anului(1);
END;
/

BEGIN
 afisare_antrenorul_anului(2);
END;
/

BEGIN
 afisare_antrenorul_anului(5);
END;
/


--10

CREATE OR REPLACE TRIGGER trig_contract
    BEFORE INSERT OR UPDATE OR DELETE ON contract_sponsor
BEGIN
 IF (TO_CHAR(SYSDATE, 'DY') IN ('Sun', 'Sat'))
    OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 14)
 THEN
    RAISE_APPLICATION_ERROR(-20001,'Contractele se pot modifica doar de luni pana vineri, in intervalul orar 8-14.');
 END IF;
END;
/

DROP TRIGGER trig_contract;

INSERT INTO CONTRACT_SPONSOR (id_sala, id_sponsor, data_contract) VALUES (1, 5, TO_DATE('2023-01-01', 'YYYY-MM-DD'));

UPDATE contract_sponsor
SET data_contract = TO_DATE('2024-01-03', 'YYYY-MM-DD')
WHERE id_sala = 1 and id_sponsor = 5;

DELETE FROM contract_sponsor
WHERE id_sala = 1 and id_sponsor = 5;

SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;


--11

select * from vestiar;
select * from sala;

CREATE TABLE  info_sala_capacitate (
  id_sala INT PRIMARY KEY,
  nume_sala VARCHAR(50),
  capacitate_totala INT
);

drop table info_sala_capacitate;

INSERT INTO info_sala_capacitate (id_sala, nume_sala, capacitate_totala) VALUES (1, 'World Class', 110 );
select * from info_sala_capacitate;

CREATE TABLE vestiar_copie AS
SELECT *
FROM vestiar;

drop table vestiar_copie;

select * from vestiar_copie;

CREATE OR REPLACE PROCEDURE modific_capacitate_totala
 (v_id_sala info_sala_capacitate.id_sala%TYPE,
 v_capacitate_totala info_sala_capacitate.capacitate_totala%TYPE) AS
BEGIN
 UPDATE info_sala_capacitate
 SET capacitate_totala = NVL (capacitate_totala, 0) + v_capacitate_totala
 WHERE id_sala = v_id_sala;
END;
/

CREATE OR REPLACE TRIGGER trig_capacitate
 AFTER DELETE OR UPDATE OR INSERT OF capacitate ON vestiar_copie
 FOR EACH ROW
BEGIN
 IF DELETING THEN
 modific_capacitate_totala (:OLD.id_sala, -1*:OLD.capacitate);
 ELSIF UPDATING THEN
 modific_capacitate_totala(:OLD.id_sala,:NEW.capacitate-:OLD.capacitate);
 ELSE
 modific_capacitate_totala(:NEW.id_sala, :NEW.capacitate);
 END IF;
END;
/

SELECT * FROM info_sala_capacitate WHERE id_sala=1;


INSERT INTO vestiar_copie (id_vestiar, tip_vestiar, capacitate, id_sala)
VALUES (16, 'M', 90, 1);

SELECT * FROM info_sala_capacitate WHERE id_sala=1;


SELECT * FROM info_sala_capacitate WHERE id_sala=1;
UPDATE vestiar_copie
SET capacitate = capacitate + 1000
WHERE id_vestiar=16;

SELECT * FROM info_sala_capacitate WHERE id_sala=1;


DELETE FROM vestiar_copie
WHERE id_vestiar=16;

SELECT * FROM info_sala_capacitate WHERE id_sala=1;


DROP PROCEDURE modific_capacitate_totala;
DROP TRIGGER trig_capacitate;


--12

CREATE OR REPLACE TRIGGER trig_global
AFTER CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
  v_mesaj VARCHAR2(100);
BEGIN
  v_mesaj := 'Atenție! Acțiune LDD asupra bazei de date la data: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
  DBMS_OUTPUT.PUT_LINE(v_mesaj);
END;
/

DROP TRIGGER trig_global;

CREATE TABLE contract_sponsor_copie AS
SELECT *
FROM contract_sponsor;

ALTER TABLE contract_sponsor_copie ADD (valoare INT);

DROP TABLE contract_sponsor_copie;


--13

CREATE OR REPLACE PACKAGE pachet AS
 PROCEDURE afisare_informatii_sala (v_id_sala sala.id_sala%TYPE DEFAULT 1);
 PROCEDURE afisare_informatii_vestiare (v_id_sala sala.id_sala%TYPE DEFAULT 1);
 FUNCTION suma_bani (v_id_sala sala.id_sala%TYPE DEFAULT 1) RETURN abonament.pret%TYPE;
 PROCEDURE afisare_antrenorul_anului (v_id_sala sala.id_sala%TYPE DEFAULT 1);
END pachet;
/

CREATE OR REPLACE PACKAGE BODY pachet AS
 PROCEDURE afisare_informatii_sala 
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
 IS
    TYPE tablou_indexat IS TABLE OF VARCHAR(50) INDEX BY PLS_INTEGER;
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    TYPE tablou_vector IS VARRAY(20) OF VARCHAR(50);

    v_lista_angajati tablou_indexat := tablou_indexat();
    v_lista_membrii tablou_imbricat := tablou_imbricat();
    v_lista_locatii tablou_vector := tablou_vector();
    
    v_nume_sala VARCHAR(50);

 BEGIN
   
    SELECT nume_sala 
    INTO v_nume_sala 
    FROM sala 
    WHERE id_sala = v_id_sala;

    FOR angajat IN (SELECT id_angajat, nume_angajat FROM angajat WHERE id_sala = v_id_sala)
    LOOP
        v_lista_angajati(angajat.id_angajat) := angajat.nume_angajat;
    END LOOP;

    FOR membru IN (SELECT id_membru FROM membru WHERE id_sala = v_id_sala)
    LOOP
        v_lista_membrii.extend;
        v_lista_membrii(v_lista_membrii.last) := membru.id_membru;
    END LOOP;

    FOR locatie IN (SELECT oras_locatie FROM locatie WHERE id_sala = v_id_sala)
    LOOP
        v_lista_locatii.extend;
        v_lista_locatii(v_lista_locatii.last) := locatie.oras_locatie;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Informatii despre sala ' || v_nume_sala || ':');

    DBMS_OUTPUT.PUT_LINE('Lista angajati:');
    FOR i IN v_lista_angajati.first .. v_lista_angajati.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_angajati(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Lista membrii (id-urile):');
    FOR i IN v_lista_membrii.first .. v_lista_membrii.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_membrii(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Lista locatii (orasele):');
    FOR i IN v_lista_locatii.first .. v_lista_locatii.last
    LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_lista_locatii(i));
    END LOOP;
   
 END afisare_informatii_sala;


 PROCEDURE afisare_informatii_vestiare
    (v_id_sala sala.id_sala%TYPE DEFAULT 1) 
 IS
    v_nume_sala sala.nume_sala%TYPE;
    v_id_vestiar vestiar.id_vestiar%TYPE;
    v_tip CHAR(1);
    v_capacitate INT;
    v_id_ingrijitor INT;
    v_nume_angajat VARCHAR(50);
    
    CURSOR c_vestiar IS
     SELECT id_vestiar, tip_vestiar, capacitate
     FROM vestiar
     WHERE id_sala=v_id_sala;

    CURSOR c_ingrijitor (vestiar_id vestiar.id_vestiar%TYPE) IS
     SELECT id_ingrijitor, nume_angajat
     FROM ingrijeste i, angajat a
     WHERE i.id_vestiar = vestiar_id and a.id_angajat=i.id_ingrijitor;

BEGIN
   
   SELECT nume_sala 
    INTO v_nume_sala 
    FROM sala 
    WHERE id_sala = v_id_sala;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Informatii despre vestiarele salii ' || v_nume_sala || ':');
    
   OPEN c_vestiar;
   
   LOOP
    FETCH c_vestiar INTO v_id_vestiar, v_tip, v_capacitate;
    EXIT WHEN c_vestiar%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Vestiarul ' || v_id_vestiar || ' de tipul ' || v_tip || ' si cu capacitatea ' || v_capacitate || '.');
    DBMS_OUTPUT.PUT_LINE('Lista ingrijitorilor: ');
    
    FOR ingrijitor_i IN c_ingrijitor(v_id_vestiar) LOOP
        DBMS_OUTPUT.PUT_LINE(ingrijitor_i.id_ingrijitor || '. '|| ingrijitor_i.nume_angajat);
    END LOOP;
    
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
   CLOSE c_vestiar;
   
 END afisare_informatii_vestiare;
 
 FUNCTION suma_bani
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
 RETURN abonament.pret%TYPE IS
    v_suma abonament.pret%TYPE;
    exceptie1 EXCEPTION;
    exceptie2 EXCEPTION;
 BEGIN
    BEGIN
        SELECT SUM(a.pret)
        INTO v_suma
        FROM abonament a
        JOIN membru m ON m.id_membru = a.id_membru
        JOIN sala s ON s.id_sala = m.id_sala
        WHERE s.id_sala = v_id_sala;
        
        IF v_suma <= 1000 THEN
            RAISE exceptie1;
        END IF;
        
        IF v_suma <= 2000 THEN
            RAISE exceptie2;
        END IF;
        
    EXCEPTION
        WHEN exceptie1 THEN
            DBMS_OUTPUT.PUT_LINE('Sala este in faliment!');
        WHEN exceptie2 THEN
            DBMS_OUTPUT.PUT_LINE('Sala este aproape de faliment!');
    END;

    RETURN v_suma;

 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Alta eroare!');
        
 END suma_bani;

PROCEDURE afisare_antrenorul_anului
    (v_id_sala sala.id_sala%TYPE DEFAULT 1)
IS
    v_nume_angajat angajat.nume_angajat%type;
    BEGIN
    
        SELECT a1.nume_angajat
        INTO v_nume_angajat
        FROM angajat a1
        JOIN antrenor a2 ON a1.id_angajat = a2.id_angajat
        JOIN programe p ON p.id_angajat = a1.id_angajat
        JOIN foloseste f ON f.id_antrenament = p.id_antrenament
        JOIN sala s ON s.id_sala = a1.id_sala
        WHERE s.id_sala = v_id_sala
        GROUP BY a1.nume_angajat
        HAVING COUNT(*) = (
                            SELECT MAX(cnt)
                            FROM (
                                SELECT COUNT(*) as cnt
                                FROM angajat a3
                                JOIN antrenor a4 ON a3.id_angajat = a4.id_angajat
                                JOIN programe p2 ON p2.id_angajat = a3.id_angajat
                                JOIN foloseste f2 ON f2.id_antrenament = p2.id_antrenament
                                JOIN sala s2 ON s2.id_sala = a3.id_sala
                                GROUP BY s2.nume_sala, a3.nume_angajat
                                )
                            );

        
        DBMS_OUTPUT.PUT_LINE('Antrenorul anului este ' || v_nume_angajat || '.');
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Nu exista antrenori eligibili pentru castigarea titlului in sala cu id-ul dat.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi antrenori eligibili pentru castigarea titlului. Va rugam frumos contactati managerul salii respective.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
 END afisare_antrenorul_anului;

END pachet;
/

drop package pachet;


EXECUTE pachet.afisare_informatii_sala(1);
EXECUTE pachet.afisare_informatii_vestiare(1);
DECLARE
  v_rezultat abonament.pret%TYPE;
BEGIN
  v_rezultat := pachet.suma_bani(1);
  DBMS_OUTPUT.PUT_LINE(v_rezultat);
END;
/
EXECUTE pachet.afisare_antrenorul_anului(1);


--14

CREATE OR REPLACE PACKAGE pachet_premium AS
  TYPE informatii_membru IS RECORD (
    id_membru membru.id_membru%TYPE,
    nume_membru membru.nume%TYPE,
    tip_abonament abonament.tip_abonament%TYPE,
    pret_abonament abonament.pret%TYPE
  );
  
  TYPE lista_nume IS VARRAY(10) OF membru.nume%TYPE;

  TYPE informatii_antrenor IS RECORD (
    id_antrenor angajat.id_angajat%TYPE,
    nume_antrenor angajat.nume_angajat%TYPE,
    specializare_antrenor antrenor.specializare%TYPE,
    id_clasa clasa.id_clasa%TYPE,
    lista_membrii lista_nume
  );

  FUNCTION numar_clase_membru (v_id_membru membru.id_membru%TYPE) RETURN NUMBER;
  
  TYPE lista_clase IS VARRAY(100) OF clasa.id_clasa%TYPE;

  FUNCTION data_minima_clase (v_lista_clase lista_clase) RETURN DATE;

  PROCEDURE afisare_informatii_membru(v_informatii_membru informatii_membru);
  
  PROCEDURE afisare_informatii_antrenor(v_informatii_antrenor informatii_antrenor);
  
END pachet_premium;
/

CREATE OR REPLACE PACKAGE BODY pachet_premium AS

  FUNCTION numar_clase_membru (v_id_membru membru.id_membru%TYPE) RETURN NUMBER IS
    v_numar_clase NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_numar_clase
    FROM FORMULAR f
    WHERE f.id_membru=v_id_membru;
    RETURN v_numar_clase;
  END numar_clase_membru;

  FUNCTION data_minima_clase (v_lista_clase lista_clase) RETURN DATE IS
    v_data_minima DATE;
  BEGIN
    SELECT MIN(data)
    INTO v_data_minima
    FROM clasa c
    WHERE c.id_clasa IN (SELECT * FROM TABLE(v_lista_clase));
    RETURN v_data_minima;
  END data_minima_clase;

  PROCEDURE afisare_informatii_membru(v_informatii_membru informatii_membru) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('ID Membru: ' || v_informatii_membru.id_membru);
    DBMS_OUTPUT.PUT_LINE('Nume Membru: ' || v_informatii_membru.nume_membru);
    DBMS_OUTPUT.PUT_LINE('Tip Abonament: ' || v_informatii_membru.tip_abonament);
    DBMS_OUTPUT.PUT_LINE('Pret Abonament: ' || v_informatii_membru.pret_abonament);
  END afisare_informatii_membru;

  PROCEDURE afisare_informatii_antrenor(v_informatii_antrenor informatii_antrenor) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('ID Antrenor: ' || v_informatii_antrenor.id_antrenor);
    DBMS_OUTPUT.PUT_LINE('Nume Antrenor: ' || v_informatii_antrenor.nume_antrenor);
    DBMS_OUTPUT.PUT_LINE('Specializare Antrenor: ' || v_informatii_antrenor.specializare_antrenor);
    DBMS_OUTPUT.PUT_LINE('ID Clasa: ' || v_informatii_antrenor.id_clasa);
    DBMS_OUTPUT.PUT_LINE('Lista Membrii:');
  
  FOR i IN 1..v_informatii_antrenor.lista_membrii.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('  ' || v_informatii_antrenor.lista_membrii(i));
  END LOOP;
END afisare_informatii_antrenor;


END pachet_premium;
/

drop package pachet_premium;

DECLARE
  v_id_membru membru.id_membru%TYPE := 3;
  v_numar_clase NUMBER;
BEGIN
  v_numar_clase := pachet_premium.numar_clase_membru(v_id_membru);
  DBMS_OUTPUT.PUT_LINE('Numărul de clase la care participă membrul respectiv: ' || v_numar_clase);
END;

DECLARE
  v_lista_clase pachet_premium.lista_clase;
  v_data_minima DATE;
BEGIN
  v_lista_clase := pachet_premium.lista_clase(1, 2, 3);
  v_data_minima := pachet_premium.data_minima_clase(v_lista_clase);
  DBMS_OUTPUT.PUT_LINE('Data cea mai apropiată dintre clasele respective: ' || TO_CHAR(v_data_minima, 'DD-MON-YYYY'));
END;

DECLARE
  v_informatii_membru pachet_premium.informatii_membru;
BEGIN
  v_informatii_membru.id_membru := 1;
  v_informatii_membru.nume_membru := 'Popescu Ion';
  v_informatii_membru.tip_abonament := 'Abonament Bronze';
  v_informatii_membru.pret_abonament := 100;
  
  pachet_premium.afisare_informatii_membru(v_informatii_membru);
END;

DECLARE
  v_informatii_antrenor pachet_premium.informatii_antrenor;
BEGIN
  v_informatii_antrenor.id_antrenor := 4;
  v_informatii_antrenor.nume_antrenor := 'Constantin Elena';
  v_informatii_antrenor.specializare_antrenor := 'Fitness';
  v_informatii_antrenor.id_clasa := 1;
  v_informatii_antrenor.lista_membrii := pachet_premium.lista_nume('Popescu Ion', 'Radu Maria', 'Ionescu Andrei', 'Georgescu Ana', 'Stanescu Mihaela');
  
  pachet_premium.afisare_informatii_antrenor(v_informatii_antrenor);
END;
