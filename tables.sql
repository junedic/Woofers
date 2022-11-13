CREATE TABLE employees
(
        employee_id  int unsigned auto_increment NOT NULL UNIQUE ,
        surname      varchar(255) NOT NULL ,
        name         varchar(255) NOT NULL ,
        mobile       mediumint unsigned NOT NULL ,
        email        varchar(255) NOT NULL ,
        PRIMARY KEY  (employee_id)
);

CREATE TABLE services
(
        service_id  int unsigned auto_increment NOT NULL UNIQUE ,
        service     ENUM(
                        'Schneiden',
                        'Waschen',
                        'Entfilzen',
                        'Entlausen',
                        'Massage'
                    ) NOT NULL UNIQUE ,
        price       tinyint unsigned NOT NULL ,
        PRIMARY KEY (service_id)
);

CREATE TABLE customers
(
        customer_id int unsigned auto_increment NOT NULL UNIQUE ,
        surname     varchar(255) NOT NULL ,
        name        varchar(255) NOT NULL ,
        mobile      mediumint unsigned NOT NULL ,
        email       varchar(255),
        PRIMARY KEY (customer_id)
);

CREATE TABLE races
(
        race_id     int unsigned auto_increment NOT NULL UNIQUE ,
        race        ENUM(
                        'Golden Retriever',
                        'Chihuahua',
                        'Rottweiler',
                        'Bulldogge',
                        'Dogo Argentino'
                    ) NOT NULL UNIQUE,
                    PRIMARY KEY (race_id)
);

CREATE TABLE dogs
(
        dog_id      int unsigned auto_increment NOT NULL UNIQUE ,
        customer_id int unsigned NOT NULL ,
        race_id     int unsigned NOT NULL ,
        name        varchar(255) NOT NULL ,
        sex         ENUM('m', 'f') NOT NULL ,
        birth       year NOT NULL ,
        FOREIGN KEY (customer_id) references customers(customer_id),
        FOREIGN KEY (race_id) references races(race_id),
        PRIMARY KEY (dog_id)
);

CREATE TABLE appointments
(
        appointment_id  int unsigned auto_increment NOT NULL UNIQUE ,
        employee_id     int unsigned NOT NULL ,
        dog_id          int unsigned NOT NULL ,
        customer_id     int unsigned NOT NULL ,
        date            date NOT NULL ,
        time            time NOT NULL ,
        FOREIGN KEY (employee_id) references employees(employee_id),
        FOREIGN KEY (dog_id) references dogs(dog_id),
        FOREIGN KEY (customer_id) references dogs(customer_id),
        PRIMARY KEY (appointment_id)
);

CREATE TABLE bookedAppointments
(
        appointment_id  int unsigned NOT NULL ,
        service_id      int unsigned NOT NULL ,
        FOREIGN KEY (appointment_id) references appointments(appointment_id),
        FOREIGN KEY (service_id) references services(service_id),
        PRIMARY KEY (appointment_id, service_id)
);
