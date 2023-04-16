DROP SCHEMA IF EXISTS `iFinance` ;
CREATE SCHEMA IF NOT EXISTS `iFinance` DEFAULT CHARACTER SET latin1 ;
USE `iFinance` ;

CREATE TABLE Users (
    user_id int PRIMARY KEY,
    fName varchar(40),
    lName varchar(40),
    address varchar(50),
    city varchar(40),
    state varchar(40),
    country varchar(40)
    );

CREATE TABLE Dependents (
    dependent_id INT,
    user_id INT NOT NULL,
    fName varchar(40),
    lName varchar(40),
    age INT,
    PRIMARY KEY (dependent_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(40)
);

CREATE TABLE Cards (
    cardNum INT PRIMARY KEY,
    secCode INT UNIQUE,
    zip INT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

CREATE TABLE Mediums (
    medium_id INT,
    user_id INT,
    name VARCHAR(40),
    cardNum INT,
    PRIMARY KEY (medium_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (cardNum) REFERENCES Cards (cardNum)
);

CREATE TABLE PersonalTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(150),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (category_id) REFERENCES Categories (category_id),
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id)
);

CREATE TABLE BusinessTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(150),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (category_id) REFERENCES Categories (category_id),
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id)
);

CREATE TABLE FamilyTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(150),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    dependent_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (category_id) REFERENCES Categories (category_id),
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id),
    FOREIGN KEY (dependent_id) REFERENCES Dependents (dependent_id)
);


INSERT INTO Users (user_id, fName, lName, address, city, state, country)
VALUES (1, 'John', 'Kraunelis', '26 Sandwich Street', 'Braintree', 'MA', 'United States');

INSERT INTO Mediums (medium_id, user_id, name, cardNum)
VALUES (1, 1, 'Cash', null);

INSERT INTO Cards (cardNum, secCode, zip, user_id)
VALUES (198204, 777, 02184, 1);

INSERT INTO Mediums (medium_id, user_id, name, cardNum)
VALUES (2, 1, 'Debit Card', 198204);

INSERT INTO Dependents (dependent_id, user_id, fName, lName, age)
VALUES (1, 1, 'Jim', 'Kraunelis', 12);

INSERT INTO Categories (category_id, name)
VALUES (1, 'FOOD');

INSERT INTO Categories (category_id, name)
VALUES (2, 'GAS');

INSERT INTO Categories (category_id, name)
VALUES (3, 'JOB');

INSERT INTO FamilyTransactions (user_id, amount, description, category_id, debOrCred, medium_id, dependent_id)
VALUES (1, 42.50, 'Chick-Fil-A', 1, FALSE, 1, 1);

INSERT INTO PersonalTransactions (user_id, amount, description, category_id, debOrCred, medium_id)
VALUES (1, 19.20, 'Quick fill up at the gas station', 2, FALSE, 1);

INSERT INTO BusinessTransactions (user_id, amount, description, category_id, debOrCred, medium_id)
VALUES (1, 3420.60, 'Payment from EXP', 3, TRUE, 1);


