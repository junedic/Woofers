/*
drop table bookedAppointments;

drop table appointments;

drop table dogs;

drop table customers;

drop table employees;

drop table races;

drop table services;
*/

CREATE TABLE mitarbeiter
(
        mitarbeiter_id  int unsigned auto_increment NOT NULL UNIQUE ,
        nachname      varchar(255) NOT NULL ,
        vorname         varchar(255) NOT NULL ,
        telefonnummer       mediumint unsigned NOT NULL ,
        email        varchar(255) NOT NULL ,
        PRIMARY KEY  (mitarbeiter_id)
);

CREATE TABLE dienstleistung
(
        dienstleistung_id  int unsigned auto_increment NOT NULL UNIQUE ,
        dienstleistung     ENUM(
                        'Schneiden',
                        'Waschen',
                        'Entfilzen',
                        'Entlausen',
                        'Massage'
                    ) NOT NULL UNIQUE ,
        preis       tinyint unsigned NOT NULL ,
        PRIMARY KEY (dienstleistung_id)
);

CREATE TABLE kunde
(
        kunden_id int unsigned auto_increment NOT NULL UNIQUE ,
        nachname     varchar(255) NOT NULL ,
        vorname       varchar(255) NOT NULL ,
        telefonnummer      mediumint unsigned NOT NULL ,
        email       varchar(255),
        PRIMARY KEY (kunden_id)
);

CREATE TABLE rasse
(
        rasse_id     int unsigned auto_increment NOT NULL UNIQUE ,
        rasse        ENUM(
                        'Golden Retriever',
                        'Chihuahua',
                        'Rottweiler',
                        'Bulldogge',
                        'Dogo Argentino'
                    ) NOT NULL UNIQUE,
                    PRIMARY KEY (rasse_id)
);

CREATE TABLE hund
(
        hund_id      int unsigned auto_increment NOT NULL UNIQUE ,
        kunden_id int unsigned NOT NULL ,
        rasse_id     int unsigned ,
        name        varchar(255) NOT NULL ,
        geschlecht         ENUM('m', 'f') NOT NULL ,
        geburtsjahr      year NOT NULL ,
        FOREIGN KEY (kunden_id) references kunde(kunden_id) ON DELETE CASCADE ON UPDATE CASCADE , # hund ohne kunde sinnlos, hund muss mit korrektem kunden verknuept sein
        FOREIGN KEY (rasse_id) references rasse(rasse_id) ON DELETE SET NULL ON UPDATE CASCADE , # hund ohne rasse sinnvoll, da sonst kundendaten verloren gehen koennen
        PRIMARY KEY (hund_id)
);

CREATE TABLE termin
(
        termin_id  int unsigned auto_increment NOT NULL UNIQUE ,
        mitarbeiter_id     int unsigned ,
        hund_id          int unsigned ,
        kunden_id     int unsigned ,
        datum            date NOT NULL ,
        zeit            time NOT NULL ,
        FOREIGN KEY (mitarbeiter_id) references mitarbeiter(mitarbeiter_id) ON DELETE SET NULL ON UPDATE CASCADE, #termindaten aus der vergangenheit erhalten
        FOREIGN KEY (hund_id) references hund(hund_id) ON DELETE SET NULL ON UPDATE CASCADE, #termindaten aus der vergangenheit erhalten
        FOREIGN KEY (mitarbeiter_id) references hund(kunden_id) ON DELETE SET NULL ON UPDATE CASCADE, #termindaten aus der vergangenheit erhalten
        PRIMARY KEY (termin_id)
);

CREATE TABLE gebuchterTermin
(
        termin_id  int unsigned NOT NULL ,
        dienstleistung_id      int unsigned ,
        FOREIGN KEY (termin_id) references termin(termin_id) ON DELETE CASCADE ON UPDATE CASCADE, # ohne termin kein gebuchter termin, muessen matchen sonst tabelle sinnlos
        FOREIGN KEY (dienstleistung_id) references dienstleistung(dienstleistung_id) ON DELETE SET NULL ON UPDATE CASCADE, # termin ohne dienstleistung sinnvoll, fuer archiv daten
        PRIMARY KEY (termin_id, dienstleistung_id)
);
