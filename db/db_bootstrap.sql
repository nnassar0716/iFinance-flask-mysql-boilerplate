-- This file is to bootstrap a database for the CS3200 project.

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith
-- data source creation.
create database iFinance;

-- Via the Docker Compose file, a special user called webapp will
-- be created in MySQL. We are going to grant that user
-- all privilages to the new database we just created.
-- TODO: If you changed the name of the database above, you need
-- to change it here too.
grant all privileges on iFinance.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too.
use iFinance;

-- Put your DDL
DROP SCHEMA IF EXISTS `iFinance` ;
CREATE SCHEMA IF NOT EXISTS `iFinance` DEFAULT CHARACTER SET latin1 ;
USE `iFinance` ;

CREATE TABLE Users (
    user_id int PRIMARY KEY AUTO_INCREMENT,
    fName varchar(100),
    lName varchar(100),
    address varchar(100),
    city varchar(100),
    state varchar(100),
    country varchar(100)
    );

CREATE TABLE Dependents (
    dependent_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    fName varchar(100),
    lName varchar(100),
    age INT,
    PRIMARY KEY (dependent_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE Cards (
    cardNum INT PRIMARY KEY,
    secCode INT UNIQUE,
    zip INT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE
);

CREATE TABLE Mediums (
    medium_id INT AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(100),
    cardNum INT,
    PRIMARY KEY (medium_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (cardNum) REFERENCES Cards (cardNum) ON DELETE CASCADE
);

CREATE TABLE PersonalTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(200),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE RESTRICT,
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id) ON DELETE CASCADE
);

CREATE TABLE BusinessTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(200),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE RESTRICT,
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id) ON DELETE CASCADE
);

CREATE TABLE FamilyTransactions (
    user_id INT NOT NULL,
    amount DECIMAL(16, 2),
    description VARCHAR(200),
    category_id INT,
    debOrCred BOOLEAN,
    medium_id INT,
    dependent_id INT,
    recorded_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE RESTRICT,
    FOREIGN KEY (medium_id) REFERENCES Mediums (medium_id) ON DELETE CASCADE,
    FOREIGN KEY (dependent_id) REFERENCES Dependents (dependent_id) ON DELETE CASCADE
);




-- Add sample data.
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Thorny','Firpi','38 Dixon Lane','Dallas','Texas','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Ninon','Horley','5382 Hayes Drive','Brooklyn','New York','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Mala','Threadgould','0 Toban Alley','Los Angeles','California','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Yankee','Myott','559 Marcy Trail','Washington','District of Columbia','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Valentino','Housden','925 Eagle Crest Avenue','Denver','Colorado','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Mathew','Darrach','44330 Veith Plaza','Las Vegas','Nevada','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Cleo','Neward','56 Paget Lane','Pittsburgh','Pennsylvania','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Dmitri','Baskerfield','96389 Cascade Court','Durham','North Carolina','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Celestyn','Giberd','57732 Monument Way','El Paso','Texas','United States');
INSERT INTO Users(fName,lName,address,city,state,country) VALUES ('Redd','Rillstone','3 Goodland Pass','Youngstown','Ohio','United States');

INSERT INTO Categories(name) VALUES ('Drilled Shafts');
INSERT INTO Categories(name) VALUES ('Casework');
INSERT INTO Categories(name) VALUES ('Structural and Misc Steel (Fabrication)');
INSERT INTO Categories(name) VALUES ('Glass & Glazing');
INSERT INTO Categories(name) VALUES ('Ornamental Railings');
INSERT INTO Categories(name) VALUES ('Framing (Steel)');
INSERT INTO Categories(name) VALUES ('Granite Surfaces');
INSERT INTO Categories(name) VALUES ('Framing (Steel)');
INSERT INTO Categories(name) VALUES ('Electrical');
INSERT INTO Categories(name) VALUES ('Glass & Glazing');
INSERT INTO Categories(name) VALUES ('Rebar & Wire Mesh Install');
INSERT INTO Categories(name) VALUES ('Rebar & Wire Mesh Install');
INSERT INTO Categories(name) VALUES ('Termite Control');
INSERT INTO Categories(name) VALUES ('Temp Fencing, Decorative Fencing and Gates');
INSERT INTO Categories(name) VALUES ('Doors, Frames & Hardware');
INSERT INTO Categories(name) VALUES ('Construction Clean and Final Clean');
INSERT INTO Categories(name) VALUES ('Retaining Wall and Brick Pavers');
INSERT INTO Categories(name) VALUES ('Soft Flooring and Base');
INSERT INTO Categories(name) VALUES ('Landscaping & Irrigation');
INSERT INTO Categories(name) VALUES ('Site Furnishings');

INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9442,3456,24648,10);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (6556,3826,28367,4);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9823,8581,22045,9);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (2566,6692,69059,10);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9701,8015,13620,6);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (4930,1840,15736,4);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (6554,9001,26669,10);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (8625,7358,94595,8);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9552,8107,73867,4);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9334,6223,37765,8);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (6535,2005,17759,3);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (4183,5007,54601,10);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9364,1860,90400,5);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (8666,4833,15072,9);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (7088,5219,77184,10);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (4680,3238,53588,3);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (9626,7224,19412,6);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (7394,8837,23849,6);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (1430,7919,98346,1);
INSERT INTO Cards(cardNum,secCode,zip,user_id) VALUES (7301,7470,30402,5);

INSERT INTO Mediums(user_id,name,cardNum) VALUES (1,'jcb',6554);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (4,'mastercard',9442);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (3,'china-unionpay',6556);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (1,'mastercard',2566);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (4,'switch',8666);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (4,'visa-electron',8666);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (6,'instapayment',9552);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (3,'jcb',9701);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (5,'jcb',6535);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (9,'diners-club-enroute',9442);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (8,'jcb',9442);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (8,'jcb',6535);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (1,'jcb',9364);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (5,'diners-club-carte-blanche',6535);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (6,'jcb',6556);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (7,'mastercard',9334);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (8,'switch',9626);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (9,'bankcard',9552);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (10,'laser',7088);
INSERT INTO Mediums(user_id,name,cardNum) VALUES (7,'maestro',6554);

INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,6737.22,'n/a',5,TRUE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,8919.3,'EDP Services',16,TRUE,8);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,2864.6,'Electric Utilities: Central',11,TRUE,1);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,680.02,'Medical Specialities',6,TRUE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,9515.8,'Services-Misc. Amusement & Recreation',17,TRUE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,4364.94,'n/a',7,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,2966.49,'n/a',12,TRUE,16);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,237.55,'Property-Casualty Insurers',1,FALSE,8);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,9039.84,'Industrial Machinery/Components',16,FALSE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,1949.44,'Apparel',18,FALSE,17);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,4931.15,'Property-Casualty Insurers',2,TRUE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,2736.49,'n/a',1,TRUE,20);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,8211.73,'n/a',17,FALSE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,4040.34,'Apparel',15,FALSE,6);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,3597.68,'Electronic Components',7,FALSE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,6889.98,'Semiconductors',2,TRUE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,9058.79,'Business Services',1,FALSE,12);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,8758.89,'Oil & Gas Production',4,TRUE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,6843.44,'Semiconductors',14,TRUE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,1796.92,'n/a',7,TRUE,15);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,2396.61,'Oil & Gas Production',14,TRUE,16);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,2042.03,'n/a',2,TRUE,1);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,7260.57,'n/a',16,FALSE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,6522.74,'Biotechnology: Electromedical & Electrotherapeutic Apparatus',9,TRUE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,1300.14,'Major Pharmaceuticals',8,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,1107.22,'Automotive Aftermarket',13,TRUE,6);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,5868.62,'n/a',7,FALSE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,1682.72,'Engineering & Construction',18,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,9495.07,'Precious Metals',10,TRUE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,9732.64,'n/a',16,TRUE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,4909.7,'Plastic Products',10,TRUE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,9117.39,'Natural Gas Distribution',8,FALSE,8);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,2749.99,'Oil & Gas Production',7,TRUE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,8456.14,'n/a',11,TRUE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,9195.46,'Semiconductors',2,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,4698.55,'Biotechnology: Electromedical & Electrotherapeutic Apparatus',13,FALSE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,2491.63,'Medical/Dental Instruments',10,FALSE,11);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,5016.81,'Computer peripheral equipment',2,FALSE,17);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,7534.06,'Semiconductors',5,FALSE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,842.8,'Business Services',9,FALSE,20);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,8354.63,'Business Services',18,FALSE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,8746.08,'Broadcasting',12,TRUE,6);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,5208.37,'Auto Manufacturing',2,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,4938.93,'Medical/Dental Instruments',15,TRUE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,944.17,'Computer Software: Programming, Data Processing',11,FALSE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,8870.21,'Transportation Services',8,TRUE,6);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,967.09,'Investment Managers',15,FALSE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,315.46,'n/a',2,FALSE,11);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,1889.24,'Consumer Electronics/Appliances',18,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,7124.41,'Hotels/Resorts',12,FALSE,5);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,6476.31,'Business Services',12,TRUE,17);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,3204.83,'n/a',7,TRUE,15);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,5319.31,'Integrated oil Companies',5,FALSE,9);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,7449.83,'Agricultural Chemicals',14,TRUE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,7302.08,'n/a',15,FALSE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,7888.73,'Biotechnology: Biological Products (No Diagnostic Substances)',3,FALSE,9);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,8864.83,'Major Chemicals',1,TRUE,15);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,7275.87,'Electric Utilities: Central',4,FALSE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,8939.98,'Major Pharmaceuticals',18,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,4357.7,'Major Banks',14,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,7091.31,'n/a',6,FALSE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,291.61,'Diversified Commercial Services',1,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,2401.26,'n/a',16,FALSE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,3823.41,'Biotechnology: Commercial Physical & Biological Resarch',20,TRUE,11);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,3202.72,'Biotechnology: Electromedical & Electrotherapeutic Apparatus',4,TRUE,12);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,4354.77,'Real Estate Investment Trusts',2,FALSE,12);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,9298.21,'Industrial Machinery/Components',6,FALSE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,1651.37,'Miscellaneous manufacturing industries',14,TRUE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,6385.84,'Oil & Gas Production',19,TRUE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,4090.11,'n/a',8,TRUE,20);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,7903.17,'Multi-Sector Companies',18,TRUE,12);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,7309.48,'Semiconductors',3,FALSE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,6611.48,'Computer Software: Prepackaged Software',16,TRUE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,2015.46,'n/a',13,TRUE,5);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,9441.86,'Major Chemicals',5,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,9119.14,'Telecommunications Equipment',14,TRUE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,3627.81,'Metal Fabrications',1,FALSE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,4030.08,'Real Estate Investment Trusts',3,TRUE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,923.48,'Apparel',12,FALSE,1);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,798.4,'Hotels/Resorts',10,TRUE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,1704.32,'n/a',10,FALSE,10);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,5967.39,'n/a',16,TRUE,20);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,4140.76,'n/a',4,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,7772.31,'Food Chains',2,TRUE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,6814.49,'Major Banks',19,FALSE,16);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,1308.95,'Business Services',9,TRUE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,5979.63,'n/a',4,FALSE,4);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,8147.33,'n/a',20,FALSE,15);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,9851.73,'n/a',10,TRUE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,2520.03,'Electrical Products',19,TRUE,16);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,5496.44,'Air Freight/Delivery Services',14,FALSE,19);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,7262.82,'Major Pharmaceuticals',6,FALSE,17);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,2995.38,'Business Services',5,FALSE,2);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,174.39,'Savings Institutions',4,FALSE,18);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,2562.89,'Business Services',9,FALSE,15);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,2222.46,'Real Estate',10,FALSE,3);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,7900.51,'Aerospace',17,TRUE,13);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,2028.69,'Electric Utilities: Central',6,FALSE,7);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,4725.15,'Property-Casualty Insurers',13,TRUE,14);
INSERT INTO PersonalTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,9364.32,'n/a',19,FALSE,4);

INSERT INTO Dependents(user_id,fName,lName,age) VALUES (4,'Warden','Mc Carroll',3);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (2,'Gill','Lowdham',5);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (8,'Elsi','Huxley',2);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (5,'Andee','Perschke',14);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (5,'Blanche','Swatland',14);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (5,'Gillan','Harsnipe',4);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (10,'Christy','Pinnere',3);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (4,'Britney','Carley',2);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (7,'Joscelin','Gages',16);
INSERT INTO Dependents(user_id,fName,lName,age) VALUES (2,'Paco','Dobbison',14);

INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,3482.9,'Hospital/Nursing Management',12,TRUE,20,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,8157.84,'Real Estate Investment Trusts',14,FALSE,14,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,2857.42,'Homebuilding',6,FALSE,5,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,7946.64,'EDP Services',4,FALSE,8,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,7971.15,'Auto Manufacturing',17,FALSE,15,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,1609.85,'Major Banks',8,FALSE,15,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,5908.77,'EDP Services',2,FALSE,13,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,9301.33,'Investment Bankers/Brokers/Service',6,TRUE,19,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,6899.88,'Biotechnology: Biological Products (No Diagnostic Substances)',17,TRUE,14,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,1136.36,'Major Banks',9,FALSE,8,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,8855.19,'Major Banks',15,TRUE,18,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,2010.46,'n/a',12,TRUE,15,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,6760.24,'Major Pharmaceuticals',13,FALSE,4,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,9475.8,'Major Banks',20,FALSE,5,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,991.95,'Consumer Electronics/Appliances',9,FALSE,14,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,883.75,'Oil & Gas Production',3,FALSE,19,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,3963.32,'Industrial Specialties',17,TRUE,1,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,4168.44,'Major Banks',16,TRUE,14,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,3877.92,'Savings Institutions',7,TRUE,10,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,1469.64,'Medical/Dental Instruments',10,TRUE,13,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,5381.28,'Semiconductors',19,FALSE,7,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,2061.46,'Homebuilding',10,FALSE,11,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,2707.59,'Computer Software: Prepackaged Software',6,TRUE,4,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,9390.29,'n/a',12,TRUE,6,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,5466.41,'Marine Transportation',4,TRUE,14,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,1967.77,'n/a',15,FALSE,10,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,423.22,'Major Pharmaceuticals',13,TRUE,17,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,4284.56,'Biotechnology: Biological Products (No Diagnostic Substances)',9,TRUE,5,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,1953.77,'n/a',10,TRUE,7,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,2535.31,'Farming/Seeds/Milling',16,FALSE,11,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,4490.37,'Major Pharmaceuticals',14,TRUE,6,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,8712.82,'Business Services',17,FALSE,14,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,3240.51,'Electric Utilities: Central',3,TRUE,4,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,2440.76,'Major Chemicals',5,TRUE,13,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,3399.5,'General Bldg Contractors - Nonresidential Bldgs',20,FALSE,10,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,4131.36,'n/a',8,FALSE,13,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,2144.81,'Environmental Services',5,TRUE,8,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,6221.86,'Real Estate Investment Trusts',17,TRUE,2,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,5748.24,'Semiconductors',10,TRUE,4,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,6985.05,'Property-Casualty Insurers',19,FALSE,7,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,7825.91,'Metal Fabrications',7,FALSE,10,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,6016.38,'Major Pharmaceuticals',18,FALSE,2,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,763.7,'Major Banks',1,FALSE,6,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,7408.07,'Multi-Sector Companies',11,FALSE,14,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,7930.07,'Television Services',5,TRUE,19,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,7820.61,'n/a',3,TRUE,15,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,5095.92,'n/a',16,TRUE,4,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,5886.08,'Hospital/Nursing Management',6,FALSE,16,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,7727.28,'n/a',7,FALSE,5,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,2107.25,'Finance/Investors Services',4,TRUE,10,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,5309.7,'Major Banks',1,FALSE,11,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,3310.56,'Computer Software: Programming, Data Processing',10,FALSE,10,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,8932.43,'Transportation Services',19,FALSE,5,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,1112.88,'Real Estate',18,TRUE,19,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,9248.31,'Biotechnology: Commercial Physical & Biological Resarch',3,TRUE,9,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,3167.95,'Specialty Chemicals',18,TRUE,9,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,2257.27,'n/a',13,TRUE,13,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,798.44,'Commercial Banks',12,FALSE,1,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,3534.84,'Television Services',3,FALSE,7,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,3159.35,'Packaged Foods',9,TRUE,8,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,1736.04,'n/a',1,TRUE,4,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,4556.23,'Electric Utilities: Central',6,TRUE,12,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,434.38,'Other Specialty Stores',5,FALSE,15,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,5837.05,'n/a',19,TRUE,7,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,7909.67,'Biotechnology: Biological Products (No Diagnostic Substances)',15,FALSE,3,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,1899.55,'Textiles',5,FALSE,18,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,5188.24,'Natural Gas Distribution',12,FALSE,6,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,8523.3,'Major Pharmaceuticals',2,TRUE,11,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,7590.17,'Air Freight/Delivery Services',6,FALSE,2,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,6555.97,'n/a',20,TRUE,8,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,9566.12,'Major Pharmaceuticals',18,TRUE,7,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,9383.96,'n/a',14,FALSE,11,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,9212.17,'Biotechnology: Biological Products (No Diagnostic Substances)',1,FALSE,13,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,1746.56,'Biotechnology: Electromedical & Electrotherapeutic Apparatus',7,FALSE,3,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,5396.26,'EDP Services',9,FALSE,6,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,8635.02,'n/a',12,FALSE,4,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,5911.27,'Oil & Gas Production',10,TRUE,2,2);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,8819.58,'n/a',18,FALSE,13,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,821.65,'Metal Fabrications',3,TRUE,18,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,1843.29,'n/a',20,FALSE,3,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,3761.3,'Military/Government/Technical',15,TRUE,17,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (10,187.01,'Telecommunications Equipment',7,FALSE,10,9);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,5700.28,'Savings Institutions',11,FALSE,3,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,8695.29,'Military/Government/Technical',4,TRUE,11,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,1280.81,'n/a',14,FALSE,8,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,9317,'Newspapers/Magazines',14,FALSE,8,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,3441.14,'Catalog/Specialty Distribution',1,FALSE,3,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (1,8061.57,'Medical/Dental Instruments',7,TRUE,6,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,3624.97,'Real Estate Investment Trusts',15,FALSE,12,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,2621.91,'Integrated oil Companies',12,FALSE,18,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (3,7025.95,'n/a',2,TRUE,12,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (7,648.01,'Computer Software: Programming, Data Processing',17,TRUE,11,5);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,6054.48,'n/a',16,FALSE,18,3);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (2,786,'Electrical Products',12,TRUE,3,7);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,2299.57,'Business Services',15,TRUE,17,1);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (9,4486.39,'Computer Software: Prepackaged Software',11,TRUE,17,10);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (5,4807.77,'Electrical Products',1,FALSE,8,6);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (8,8357.51,'Computer Software: Programming, Data Processing',3,TRUE,9,4);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (4,9202.78,'Marine Transportation',8,TRUE,10,8);
INSERT INTO FamilyTransactions(user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES (6,9983.84,'Computer Software: Prepackaged Software',5,FALSE,20,3);

INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,7983.3,'Steel/Iron Ore',11,FALSE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,269.08,'Medical/Dental Instruments',16,TRUE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,4951.62,'n/a',2,FALSE,11);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,9097.16,'Industrial Machinery/Components',17,TRUE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,8863.56,'Investment Bankers/Brokers/Service',9,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,8385.55,'Home Furnishings',12,FALSE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,6602.49,'Major Banks',16,TRUE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,5725.07,'Semiconductors',14,TRUE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,3667.28,'Major Pharmaceuticals',8,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,1915.91,'Restaurants',10,TRUE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,4048.76,'Medical Specialities',13,TRUE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,9378.84,'Industrial Machinery/Components',11,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,5373.4,'Clothing/Shoe/Accessory Stores',12,TRUE,15);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,7548.1,'Biotechnology: Biological Products (No Diagnostic Substances)',4,TRUE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,5479.04,'n/a',15,TRUE,8);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,1765.35,'n/a',19,FALSE,10);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,7016.46,'Real Estate',5,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,8613.81,'n/a',1,TRUE,11);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,5149.81,'Real Estate Investment Trusts',18,TRUE,5);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,6100.23,'Electronic Components',4,TRUE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,2745.88,'Water Supply',3,FALSE,18);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,1282.99,'n/a',5,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,8426.24,'Railroads',1,FALSE,20);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,5723.66,'Other Consumer Services',9,TRUE,6);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,5143.51,'Electrical Products',6,FALSE,9);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,9551.36,'Major Banks',18,FALSE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,4184.41,'n/a',8,TRUE,9);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,7412.48,'Business Services',4,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,8106.4,'Business Services',1,TRUE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,9365.68,'Miscellaneous manufacturing industries',6,TRUE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,2465.43,'Specialty Insurers',2,TRUE,15);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,157.69,'Major Banks',19,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,674.45,'Major Chemicals',11,TRUE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,3871.82,'n/a',3,FALSE,6);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,6774.01,'Metal Fabrications',7,TRUE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,3032.85,'n/a',9,TRUE,10);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,1641.04,'Major Banks',1,FALSE,18);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,5588.71,'Metal Fabrications',3,TRUE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,2341.62,'Medical/Nursing Services',16,TRUE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,8708.72,'Investment Managers',13,FALSE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,241.89,'n/a',15,FALSE,18);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,6378.86,'Major Pharmaceuticals',17,TRUE,5);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,6714.14,'Major Banks',18,FALSE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,7776.6,'Biotechnology: Biological Products (No Diagnostic Substances)',16,TRUE,8);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,9115.61,'n/a',12,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,5212.85,'n/a',11,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,631.41,'n/a',20,FALSE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,9243.79,'Real Estate Investment Trusts',8,TRUE,2);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,9500.92,'Electrical Products',13,FALSE,10);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,8693.93,'Commercial Banks',5,FALSE,13);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,5866.71,'Real Estate Investment Trusts',18,TRUE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,827,'Diversified Commercial Services',16,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,2814.15,'Specialty Chemicals',14,TRUE,9);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,1701.71,'Telecommunications Equipment',10,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,439.83,'Major Pharmaceuticals',6,TRUE,2);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,2929.96,'Finance/Investors Services',10,FALSE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,5097.38,'Real Estate',2,TRUE,2);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,8825.23,'Electric Utilities: Central',9,FALSE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,6961.06,'n/a',6,FALSE,15);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,298.82,'Biotechnology: In Vitro & In Vivo Diagnostic Substances',3,FALSE,8);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,8729.5,'Major Pharmaceuticals',7,FALSE,20);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,499.9,'Biotechnology: Electromedical & Electrotherapeutic Apparatus',10,FALSE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,165.26,'n/a',1,FALSE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,5757.63,'n/a',8,TRUE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,5924.5,'Industrial Specialties',19,TRUE,11);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,1144.12,'Business Services',17,FALSE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,5637.56,'n/a',6,FALSE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,155.51,'Telecommunications Equipment',15,TRUE,10);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,6740.76,'Electrical Products',5,TRUE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,1064.3,'Natural Gas Distribution',16,TRUE,2);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,2678.34,'Major Banks',9,TRUE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,5915.6,'Television Services',6,TRUE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,3902.02,'n/a',2,FALSE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (4,2482.29,'Biotechnology: Commercial Physical & Biological Resarch',12,FALSE,15);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,1108.15,'Specialty Insurers',20,TRUE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (3,3674.35,'Electrical Products',4,TRUE,12);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,2812,'Precious Metals',10,FALSE,20);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (9,216.31,'Medical/Dental Instruments',13,FALSE,19);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,9671.4,'Major Pharmaceuticals',16,TRUE,6);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,4072.85,'Major Chemicals',2,TRUE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,177.68,'Major Pharmaceuticals',10,TRUE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,9915.73,'n/a',6,TRUE,6);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,5490.94,'Food Distributors',7,TRUE,16);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,9454.63,'n/a',3,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,5622.63,'Industrial Machinery/Components',15,TRUE,14);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,2141.17,'n/a',9,FALSE,9);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,4592.25,'Restaurants',6,FALSE,15);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,6724.35,'Investment Managers',1,TRUE,20);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (7,1170.25,'n/a',12,FALSE,17);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,3716.93,'Containers/Packaging',20,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,4696.44,'n/a',14,TRUE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,2772.99,'n/a',10,TRUE,20);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,2385.5,'Computer Software: Prepackaged Software',3,TRUE,1);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,9829.46,'Railroads',5,TRUE,10);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (2,1648.45,'Major Banks',9,FALSE,7);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (10,5114.94,'Containers/Packaging',16,TRUE,3);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (8,7220.47,'n/a',9,FALSE,4);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (1,9372.9,'Investment Bankers/Brokers/Service',8,TRUE,5);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (6,8323.68,'Major Banks',17,FALSE,9);
INSERT INTO BusinessTransactions(user_id,amount,description,category_id,debOrCred,medium_id) VALUES (5,8012.06,'Construction/Ag Equipment/Trucks',10,TRUE,14);
