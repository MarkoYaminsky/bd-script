-- tables
-- Table: bank
CREATE TABLE bank (
    id int NOT NULL,
    name varchar(30) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT bank_pk PRIMARY KEY (id)
);

-- Table: bank_account
CREATE TABLE bank_account (
    id int NOT NULL,
    requisites varchar(40) NOT NULL,
    client_id int NOT NULL,
    person_type_id int NOT NULL,
    bank_id int NOT NULL,
    CONSTRAINT bank_account_pk PRIMARY KEY (id)
);

-- Table: bank_client
CREATE TABLE bank_client (
    client_id int NOT NULL,
    bank_id int NOT NULL,
    CONSTRAINT bank_client_pk PRIMARY KEY (client_id,bank_id)
);

-- Table: bank_department
CREATE TABLE bank_department (
    id int NOT NULL,
    street varchar(60) NOT NULL,
    bank_id int NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT bank_department_pk PRIMARY KEY (id)
);

-- Table: bank_operator
CREATE TABLE bank_operator (
    id int NOT NULL,
    name varchar(40) NOT NULL,
    bank_id int NOT NULL,
    CONSTRAINT bank_operator_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL,
    name varchar(20) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: client
CREATE TABLE client (
    id int NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL,
    name varchar(25) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: person_type
CREATE TABLE person_type (
    id int NOT NULL,
    type varchar(10) NOT NULL,
    CONSTRAINT person_type_pk PRIMARY KEY (id)
);

-- Table: personal_account
CREATE TABLE personal_account (
    id int NOT NULL,
    bank_id int NOT NULL,
    client_id int NOT NULL,
    CONSTRAINT personal_account_pk PRIMARY KEY (id)
);

-- Table: transaction
CREATE TABLE transaction (
    id int NOT NULL,
    event varchar(60) NOT NULL,
    sum_in_dollars decimal(9,2) NOT NULL,
    bank_account_seller_id int NOT NULL,
    bank_account_buyer_id int NOT NULL,
    CONSTRAINT transaction_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: account_client (table: bank_account)
ALTER TABLE bank_account ADD CONSTRAINT account_client FOREIGN KEY account_client (client_id)
    REFERENCES client (id);

-- Reference: account_person_type (table: bank_account)
ALTER TABLE bank_account ADD CONSTRAINT account_person_type FOREIGN KEY account_person_type (person_type_id)
    REFERENCES person_type (id);

-- Reference: bank_account_bank (table: bank_account)
ALTER TABLE bank_account ADD CONSTRAINT bank_account_bank FOREIGN KEY bank_account_bank (bank_id)
    REFERENCES bank (id);

-- Reference: bank_client_bank (table: bank_client)
ALTER TABLE bank_client ADD CONSTRAINT bank_client_bank FOREIGN KEY bank_client_bank (bank_id)
    REFERENCES bank (id);

-- Reference: bank_client_client (table: bank_client)
ALTER TABLE bank_client ADD CONSTRAINT bank_client_client FOREIGN KEY bank_client_client (client_id)
    REFERENCES client (id);

-- Reference: bank_country (table: bank)
ALTER TABLE bank ADD CONSTRAINT bank_country FOREIGN KEY bank_country (country_id)
    REFERENCES country (id);

-- Reference: bank_department_bank (table: bank_department)
ALTER TABLE bank_department ADD CONSTRAINT bank_department_bank FOREIGN KEY bank_department_bank (bank_id)
    REFERENCES bank (id);

-- Reference: bank_department_city (table: bank_department)
ALTER TABLE bank_department ADD CONSTRAINT bank_department_city FOREIGN KEY bank_department_city (city_id)
    REFERENCES city (id);

-- Reference: bank_operator_bank (table: bank_operator)
ALTER TABLE bank_operator ADD CONSTRAINT bank_operator_bank FOREIGN KEY bank_operator_bank (bank_id)
    REFERENCES bank (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: client_country (table: client)
ALTER TABLE client ADD CONSTRAINT client_country FOREIGN KEY client_country (country_id)
    REFERENCES country (id);

-- Reference: personal_account_bank (table: personal_account)
ALTER TABLE personal_account ADD CONSTRAINT personal_account_bank FOREIGN KEY personal_account_bank (bank_id)
    REFERENCES bank (id);

-- Reference: personal_account_client (table: personal_account)
ALTER TABLE personal_account ADD CONSTRAINT personal_account_client FOREIGN KEY personal_account_client (client_id)
    REFERENCES client (id);

-- Reference: transaction_account (table: transaction)
ALTER TABLE transaction ADD CONSTRAINT transaction_account FOREIGN KEY transaction_account (bank_account_seller_id)
    REFERENCES bank_account (id);

-- Reference: transaction_bank_account (table: transaction)
ALTER TABLE transaction ADD CONSTRAINT transaction_bank_account FOREIGN KEY transaction_bank_account (bank_account_buyer_id)
    REFERENCES bank_account (id);

-- End of file.

