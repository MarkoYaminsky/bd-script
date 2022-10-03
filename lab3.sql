CREATE DATABASE IF NOT EXISTS marko_yaminsky;
USE marko_yaminsky;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS bank;
DROP TABLE IF EXISTS bank_department;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS client_bank;
DROP TABLE IF EXISTS person_type;
DROP TABLE IF EXISTS bank_account;
DROP TABLE IF EXISTS personal_account;
DROP TABLE IF EXISTS transaction;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE bank (
    id int NOT NULL,
    name varchar(30) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT bank_pk PRIMARY KEY (id)
);

CREATE TABLE bank_account (
    id int NOT NULL,
    requisites varchar(40) NOT NULL,
    client_id int NOT NULL,
    person_type_id int NOT NULL,
    bank_id int NOT NULL,
    CONSTRAINT bank_account_pk PRIMARY KEY (id)
);

CREATE TABLE client_bank (
    client_id int NOT NULL,
    bank_id int NOT NULL,
    CONSTRAINT bank_client_pk PRIMARY KEY (client_id,bank_id)
);

CREATE TABLE bank_department (
    id int NOT NULL,
    street varchar(60) NOT NULL,
    bank_id int NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT bank_department_pk PRIMARY KEY (id)
);

CREATE TABLE city (
    id int NOT NULL,
    name varchar(20) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

CREATE TABLE client (
    id int NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);

CREATE TABLE country (
    id int NOT NULL,
    name varchar(25) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

CREATE TABLE person_type (
    id int NOT NULL,
    type varchar(10) NOT NULL,
    CONSTRAINT person_type_pk PRIMARY KEY (id)
);

CREATE TABLE personal_account (
    id int NOT NULL,
    bank_id int NOT NULL,
    client_id int NOT NULL,
    CONSTRAINT personal_account_pk PRIMARY KEY (id)
);

CREATE TABLE transaction (
    id int NOT NULL,
    event varchar(60) NOT NULL,
    sum_in_dollars decimal(9,2) NOT NULL,
    bank_account_seller_id int NOT NULL,
    bank_account_buyer_id int NOT NULL,
    CONSTRAINT transaction_pk PRIMARY KEY (id)
);

ALTER TABLE bank_account ADD CONSTRAINT account_client FOREIGN KEY (client_id)
    REFERENCES client (id);
    
ALTER TABLE bank_account ADD CONSTRAINT account_person_type FOREIGN KEY (person_type_id)
    REFERENCES person_type (id);

ALTER TABLE bank_account ADD CONSTRAINT bank_account_bank FOREIGN KEY (bank_id)
    REFERENCES bank (id);

ALTER TABLE client_bank ADD CONSTRAINT client_bank_bank FOREIGN KEY (bank_id)
    REFERENCES bank (id);

ALTER TABLE client_bank ADD CONSTRAINT client_bank_client FOREIGN KEY (client_id)
    REFERENCES client (id);

ALTER TABLE bank ADD CONSTRAINT bank_country FOREIGN KEY (country_id)
    REFERENCES country (id);
    
ALTER TABLE bank_department ADD CONSTRAINT bank_department_bank FOREIGN KEY (bank_id)
    REFERENCES bank (id);

ALTER TABLE bank_department ADD CONSTRAINT bank_department_city FOREIGN KEY (city_id)
    REFERENCES city (id);

ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY (country_id)
    REFERENCES country (id);

ALTER TABLE client ADD CONSTRAINT client_country FOREIGN KEY (country_id)
    REFERENCES country (id);

ALTER TABLE personal_account ADD CONSTRAINT personal_account_bank FOREIGN KEY (bank_id)
    REFERENCES bank (id);

ALTER TABLE personal_account ADD CONSTRAINT personal_account_client FOREIGN KEY (client_id)
    REFERENCES client (id);

ALTER TABLE transaction ADD CONSTRAINT transaction_account FOREIGN KEY (bank_account_seller_id)
    REFERENCES bank_account (id);

ALTER TABLE transaction ADD CONSTRAINT transaction_bank_account FOREIGN KEY (bank_account_buyer_id)
    REFERENCES bank_account (id);
    
CREATE INDEX IX_client_last_name
ON client (last_name);

CREATE INDEX IX_personal_account_client_id_bank_id
ON personal_account (client_id, bank_id);

INSERT INTO country (id, name) VALUES
('1', 'Ukraine'),
('2', 'USA'),
('3', 'England'),
('4', 'Poland'),
('5', 'Turkey'),
('6', 'Germany'),
('7', 'Italy'),
('8', 'India'),
('9', 'Sweden'),
('10', 'Norway');

INSERT INTO city (id, name, country_id) VALUES
('1', 'Lviv', '1'),
('2', 'Kyiv', '1'),
('3', 'New York', '2'),
('4', 'Warsaw', '4'),
('5', 'London', '3'),
('6', 'California', '2'),
('7', 'Krakow', '4'),
('8', 'Cambridge', '3'),
('9', 'Ankara', '5'),
('10', 'Istanbul', '5');

INSERT INTO bank (id, name, country_id) VALUES
('1', 'PrivatBank', '1'),
('2', 'OshchadBank', '1'),
('3', 'RaffeizenBank', '1'),
('4', 'Monobank', '1'),
('5', 'JP Morgan Chase', '2'),
('6', 'Bank of America', '2'),
('7', 'HSBC Holdings', '3'),
('8', 'Barclays', '3'),
('9', 'PKO BP', '4'),
('10', 'Bank of India', '8');

INSERT INTO bank_department (id, street, bank_id, city_id) VALUES
('1', 'Chornovola 97', '1', '1'),
('2', 'Khreshchatyk 5', '1', '2'),
('3', 'Stryiska 19', '1', '1'),
('4', 'Handalaers 6', '2', '3'),
('5', 'Knox 5', '2', '3'),
('6', 'Birch 6', '4', '4'),
('7', 'Customs street 45', '4', '4'),
('8', 'Trinity Lane 32', '7', '8'),
('9', 'Oxford 14', '7', '3'),
('10', 'Orchard Street 1', '7', '8');

INSERT INTO client (id, first_name, last_name, country_id) VALUES
('1', 'Marko', 'Yaminsky', '1'),
('2', 'Yulia', 'Shvets', '1'),
('3', 'Ruslan', 'Hursky', '1'),
('4', 'Iryna', 'Pistun', '1'),
('5', 'Vitaliy', 'Pashynsky', '1'),
('6', 'Bob', 'Marley', '2'),
('7', 'Ari', 'Gibson', '2'),
('8', 'Pedro', 'Russo', '7'),
('9', 'Serkan', 'Bolat', '5'),
('10', 'Paul', 'Schmidt', '6');

INSERT INTO client_bank (client_id, bank_id) VALUES
('1', '1'),
('2', '1'),
('1', '2'),
('5', '2'),
('8', '2'),
('1', '3'),
('4', '4'),
('4', '5'),
('5', '7'),
('1', '10');

INSERT INTO person_type (id, type) VALUES
('1', 'physical'),
('2', 'legal');

INSERT INTO bank_account (id, requisites, client_id, person_type_id, bank_id) VALUES
('1', 'UA372361532832619153846389844', '1', '1', '1'),
('2', 'UA194713461914711744776763462', '2', '1', '1'),
('3', 'UA172783384913549965251733334', '2', '2', '1'),
('4', 'UA694177987269867959249732816', '3', '1', '1'),
('5', 'UA429281496999898529547224158', '1', '2', '1'),
('6', 'GB49BARC20038452236829', '5', '2', '7'),
('7', 'GB60BARC20039539929738', '6', '2', '7'),
('8', 'PL87109024024187646958327632', '9', '1', '9'),
('9', 'UA722525449199265968315424929', '1', '1', '4'),
('10', 'GB44BARC20035351972971', '6', '2', '8');

INSERT INTO personal_account (id, bank_id, client_id) VALUES
('1', '1', '1'),
('2', '2', '1'),
('3', '1', '2'),
('4', '5', '2'),
('5', '8', '2'),
('6', '1', '3'),
('7', '4', '4'),
('8', '4', '5'),
('9', '5', '7'),
('10', '1', '10');

INSERT INTO transaction (id, event, sum_in_dollars, bank_account_seller_id, bank_account_buyer_id) VALUES
('1', 'Money transfer', '100.20', '1', '2'),
('2', 'Internet purchase on genshinimpact.com', '2.45', '3', '5'),
('3', 'Products purchase in Charka do Sviata', '81245.40', '2', '9'),
('4', 'Interet purchase on genshinimpact.com', '124.00', '1', '5'),
('5', 'Apartment bill', '13289.00', '5', '6'),
('6', 'Products purchase in Charka do Sviata', '123.00', '7', '9'),
('7', 'Money transfer', '1235.00', '2', '10'),
('8', 'Internet purchase on genshinimpact.com', '235.30', '4', '5'),
('9', 'Products purchase in Charka do Sviata', '235.50', '2', '9'),
('10', 'Money transfer', '5.60', '4', '7');