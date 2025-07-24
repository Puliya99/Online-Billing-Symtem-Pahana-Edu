CREATE DATABASE pahana_edu;
USE pahana_edu;

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE customers (
    account_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    telephone VARCHAR(15) NOT NULL,
    units_consumed INT NOT NULL
);

CREATE TABLE items (
    item_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL,
    qty INT NOT NULL
);

CREATE TABLE bills (
    bill_id VARCHAR(10) PRIMARY KEY,
    account_no VARCHAR(10),
    total_amount DOUBLE NOT NULL,
    bill_date DATE NOT NULL,
    FOREIGN KEY (account_no) REFERENCES customers(account_no)
);
