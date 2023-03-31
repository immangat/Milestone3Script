
-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
DROP DATABASE IF EXISTS Casino;
GO
CREATE DATABASE Casino;
GO
USE Casino;
Go

DROP TABLE IF EXISTS Department_History;
DROP TABLE IF EXISTS Inventory_Shift;
DROP TABLE IF EXISTS Training;
DROP TABLE IF EXISTS Certificates;
DROP TABLE IF EXISTS Type_Skill;
DROP TABLE IF EXISTS Warning;
DROP TABLE IF EXISTS Uniform;
DROP TABLE IF EXISTS TimeOff;
DROP TABLE IF EXISTS Shift;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee_Type;

CREATE TABLE Employee_Type (
    Type_ID INT PRIMARY KEY,
    Type_Title VARCHAR(50) NOT NULL,
    Type_Description VARCHAR(100) NOT NULL
);


CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Dept_Manager INT,
    Dept_Ph_Number VARCHAR(20) NOT NULL,
);

CREATE TABLE Skill (
    Skill_ID INT PRIMARY KEY,
    Skill_Des VARCHAR(100) NOT NULL
);

CREATE TABLE Section (
    Section_ID INT PRIMARY KEY,
    Section_Description VARCHAR(100) NOT NULL
);




CREATE TABLE Employee (
  EMP_ID INT NOT NULL PRIMARY KEY,
  EMP_Name VARCHAR(255),
  EMP_DOB DATE,
  EMP_Email VARCHAR(255),
  EMP_Phone_Number VARCHAR(20),
  EMP_Address VARCHAR(255),
  EMP_City VARCHAR(255),
  EMP_Country VARCHAR(255),
  EMP_Street VARCHAR(255),
  EMP_House_Number VARCHAR(10),
  EMP_Postal_Code VARCHAR(10),
  EMP_Gender VARCHAR(10),
  EMP_Hire_Date DATE,
  EMP_Pay_Rate DECIMAL(10, 2),
  EMP_Dismiss_Date DATE,
  DEPT_ID INT,
  EMP_TYPE_ID INT,
  EMP_Vacation_TimeOff DECIMAL(10, 2),
  EMP_Sick_TimeOff DECIMAL(10, 2),
  FOREIGN KEY (DEPT_ID) REFERENCES Department(Dept_ID),
  FOREIGN KEY (EMP_TYPE_ID) REFERENCES Employee_Type(Type_ID)
);

CREATE TABLE Schedule (
  Schedule_ID INT PRIMARY KEY,
  Schedule_From DATE,
  Schedule_To DATE,
  Made_By INT
  FOREIGN KEY (Made_By) REFERENCES Employee(EMP_ID)
);

CREATE TABLE Shift (
  Shift_ID INT PRIMARY KEY,
  Shift_Type VARCHAR(50),
  Shift_Start TIME,
  Shift_End TIME,
  Shift_Date DATE,
  EMP_Working INT,
  Schedule_ID INT,
  Section_ID INT,
  FOREIGN KEY (EMP_Working) REFERENCES Employee(EMP_ID),
  FOREIGN KEY (Schedule_ID) REFERENCES Schedule(Schedule_ID),
  FOREIGN KEY (Section_ID) REFERENCES Section(Section_ID)

);



CREATE TABLE TimeOff (
  Time_ID INT PRIMARY KEY,
  EMP_ID INT,
  TimeOff_Type VARCHAR(50),
  Time_Approval_Status VARCHAR(50),
  TimeOff_Start_Date DATE,
  TimeOff_End_Date DATE
  FOREIGN KEY (EMP_ID) REFERENCES Employee(EMP_ID),
);

CREATE TABLE Inventory (
  Inv_ID INT PRIMARY KEY,
  Inv_Name VARCHAR(255),
  Inv_Price DECIMAL(10, 2),
  Inv_Quantity INT,
  Inv_Description VARCHAR(255),
  Inventory_Type VARCHAR(50)
);

CREATE TABLE Inventory_Shift (
  Inventory_ID INT,
  Shift_ID INT,
  Inventory_Quantity INT,
  Inventory_Status VARCHAR(50),
  PRIMARY KEY (Shift_ID, Inventory_ID),
  FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inv_ID),
  FOREIGN KEY (Shift_ID) REFERENCES Shift(Shift_ID)
);




 CREATE TABLE Department_History (
    EMP_ID INT NOT NULL,
    Dept_ID INT NOT NULL,
    Type_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NULL,
    PRIMARY KEY (EMP_ID, Dept_ID, Type_ID, Start_Date),
    FOREIGN KEY (EMP_ID) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID),
    FOREIGN KEY (Type_ID) REFERENCES Employee_Type (Type_ID)
);




CREATE TABLE Uniform (
    Uni_ID INT PRIMARY KEY,
    Uni_Issued_To INT NOT NULL,
    Uniform_Status VARCHAR(20) NOT NULL,
    Uniform_Size VARCHAR(20) NOT NULL,
    Issued_Date DATE NOT NULL,
    FOREIGN KEY (Uni_Issued_To) REFERENCES Employee (EMP_ID)
);

CREATE TABLE Warning (
    Warn_ID INT PRIMARY KEY,
    Warn_Issued_To INT NOT NULL,
    Warn_Issued_By INT NOT NULL,
    Warn_Issue_Date DATE NOT NULL,
    Warn_Level INT NOT NULL,
    Warn_Details VARCHAR(100) NOT NULL,
    FOREIGN KEY (Warn_Issued_To) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (Warn_Issued_By) REFERENCES Employee (EMP_ID)
);

CREATE TABLE Type_Skill (
    Type_ID INT NOT NULL,
    Skill_ID INT NOT NULL,
    PRIMARY KEY (Type_ID, Skill_ID),
    FOREIGN KEY (Type_ID) REFERENCES Employee_Type (Type_ID),
    FOREIGN KEY (Skill_ID) REFERENCES Skill (Skill_ID)
);



CREATE TABLE Certificates (
    Cert_ID INT PRIMARY KEY,
    Cert_Type VARCHAR(50) NOT NULL,
    Cert_Date_Issued DATE NOT NULL,
    Cert_Exp_Date DATE NOT NULL,
    Issuing_Auth VARCHAR(50) NOT NULL,
    Skill_ID INT NOT NULL,
    Type_ID INT NOT NULL,
    Cert_Issued_To INT NOT NULL,
    FOREIGN KEY (Skill_ID, Type_ID) REFERENCES Type_Skill (Type_ID, Skill_ID),
    FOREIGN KEY (Cert_Issued_To) REFERENCES Employee (EMP_ID)
);





CREATE TABLE Training (
    Training_ID INT PRIMARY KEY,
    EMP_Trained INT NOT NULL,
    EMP_Trainer INT NOT NULL,
    Training_Date DATE NOT NULL,
    Training_Type VARCHAR(50) NOT NULL,
    Cert_ID INT NOT NULL,
    FOREIGN KEY (EMP_Trained) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (EMP_Trainer) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (Cert_ID) REFERENCES Certificates (Cert_ID)
);

Use Casino;

INSERT INTO Employee_Type (Type_ID, Type_Title, Type_Description) VALUES
(1, 'Manager', 'Manages all departments'),
(2, 'Supervisor', 'Supervises employees in their respective departments'),
(3, 'Dealer', 'Operates games in the casino'),
(4, 'Security', 'Ensures safety and security of the casino'),
(5, 'Server', 'Serves food and beverages to casino guests'),
(6, 'Cleaner', 'Cleans and maintains the casino premises'),
(7, 'IT Support', 'Provides technical support to the casino');

INSERT INTO Department (Dept_ID, Dept_Name, Dept_Manager, Dept_Ph_Number) VALUES
(1, 'Operations', NULL, '+1-123-456-7890'),
(2, 'Security', NULL, '+1-234-567-8901'),
(3, 'Food and Beverage', NULL, '+1-345-678-9012'),
(4, 'Cleaning', NULL, '+1-456-789-0123');

INSERT INTO Skill (Skill_ID, Skill_Des) VALUES
(1, 'Communication'),
(2, 'Leadership'),
(3, 'Problem-solving'),
(4, 'Customer service'),
(5, 'Time management');

INSERT INTO Section (Section_ID, Section_Description) VALUES
(1, 'Table Games'),
(2, 'Slot Machines'),
(3, 'Poker Room'),
(4, 'Restaurant'),
(5, 'Bar'),
(6, 'Kitchen'),
(7, 'Restrooms'),
(8, 'Lobby');

INSERT INTO Employee (EMP_ID, EMP_Name, EMP_DOB, EMP_Email, EMP_Phone_Number, EMP_Address, EMP_City, EMP_Country, EMP_Street, EMP_House_Number, EMP_Postal_Code, EMP_Gender, EMP_Hire_Date, EMP_Pay_Rate, EMP_Dismiss_Date, DEPT_ID, EMP_TYPE_ID, EMP_Vacation_TimeOff, EMP_Sick_TimeOff) VALUES
(1, 'John Smith', '1980-01-01', 'john.smith@example.com', '+1-111-111-1111', '123 Main St', 'Las Vegas', 'USA', 'Main St', '123', '12345', 'Male', '2020-01-01', 20.00, NULL, 1, 1, 10.00, 5.00),
(2, 'Jane Doe', '1990-01-01', 'jane.doe@example.com', '+1-222-222-2222', '456 Elm St', 'Las Vegas', 'USA', 'Elm St', '456', '12345', 'Female', '2020-02-01', 15.00, NULL, 2, 2, 5.00, 2.50),
(3, 'Mike Johnson', '1985-01-01', 'mike.johnson@example.com', '+1-333-333-3333', '789 Oak St', 'Las Vegas', 'USA', 'Oak St', '789', '12345', 'Male', '2020-03-01', 12.00, NULL, 3, 2, 5.00, 2.50),
(4, 'Mangat Toor', '2001-01-01', 'mangat.toor@example.com', '+1-999-333-3333', '7839 Oak St', 'Las Vegas', 'USA', 'Oak St', '789', '12345', 'Male', '2020-03-01', 12.00, NULL, 3, 2, 5.00, 2.50),
(5, 'Sarah Lee', '1989-06-12', 'sarah.lee@example.com', '+1-444-444-4444', '123 Maple St', 'New York', 'USA', 'Maple St', '123', '10001', 'Female', '2021-01-01', 25.00, NULL, 2, 3, 10.00, 7.00),
(6, 'Adam Jones', '1995-09-22', 'adam.jones@example.com', '+1-555-555-5555', '456 Oak St', 'New York', 'USA', 'Oak St', '456', '10001', 'Male', '2021-02-01', 18.00, NULL, 1, 4, 5.00, 2.50),
(7, 'Jessica Smith', '1992-04-10', 'jessica.smith@example.com', '+1-666-666-6666', '789 Elm St', 'Los Angeles', 'USA', 'Elm St', '789', '90001', 'Female', '2021-03-01', 22.00, NULL, 4, 2, 7.00, 3.50),
(8, 'Michael Brown', '1987-11-15', 'michael.brown@example.com', '+1-777-777-7777', '123 Oak St', 'Los Angeles', 'USA', 'Oak St', '123', '90001', 'Male', '2021-04-01', 20.00, NULL, 3, 5, 6.00, 3.00),
(9, 'Emily Wilson', '1999-02-28', 'emily.wilson@example.com', '+1-888-888-8888', '456 Maple St', 'Chicago', 'USA', 'Maple St', '456', '60007', 'Female', '2021-05-01', 16.00, NULL, 1, 6, 4.00, 2.00),
(10, 'Robert Garcia', '1982-12-07', 'robert.garcia@example.com', '+1-999-999-9999', '789 Elm St', 'Chicago', 'USA', 'Elm St', '789', '60007', 'Male', '2021-06-01', 24.00, NULL, 2, 7, 8.00, 4.00);



INSERT INTO Schedule (Schedule_ID, Schedule_From, Schedule_To, Made_By) VALUES
(1, '2023-04-01', '2023-04-07', 1),
(2, '2023-04-08', '2023-04-14', 1),
(3, '2023-04-01', '2023-04-07', 2),
(4, '2023-04-08', '2023-04-14', 2),
(5, '2023-04-01', '2023-04-07', 3),
(6, '2023-04-08', '2023-04-14', 3);

INSERT INTO Shift (Shift_ID, Shift_Type, Shift_Start, Shift_End, Shift_Date, EMP_Working, Schedule_ID, Section_ID) VALUES
(1, 'Morning', '09:00:00', '13:00:00', '2023-04-01', 1, 1, 1),
(2, 'Evening', '13:00:00', '17:00:00', '2023-04-01', 2, 1, 2),
(3, 'Night', '17:00:00', '21:00:00', '2023-04-01', 3, 1, 3),
(4, 'Morning', '09:00:00', '13:00:00', '2023-04-02', 1, 1, 1),
(5, 'Evening', '13:00:00', '17:00:00', '2023-04-02', 2, 1, 2),
(6, 'Night', '17:00:00', '21:00:00', '2023-04-02', 3, 1, 3),
(7, 'Morning', '09:00:00', '13:00:00', '2023-04-01', 4, 2, 4),
(8, 'Evening', '13:00:00', '17:00:00', '2023-04-01', 1, 2, 5),
(9, 'Night', '17:00:00', '21:00:00', '2023-04-01', 2, 2, 6),
(10, 'Morning', '09:00:00', '13:00:00', '2023-04-02', 4, 2, 4),
(11, 'Evening', '13:00:00', '17:00:00', '2023-04-02', 1, 2, 5),
(12, 'Night', '17:00:00', '21:00:00', '2023-04-02', 2, 2, 6);

INSERT INTO TimeOff (Time_ID, EMP_ID, TimeOff_Type, Time_Approval_Status, TimeOff_Start_Date, TimeOff_End_Date) VALUES
(1, 1, 'Vacation', 'Approved', '2023-04-01', '2023-04-03'),
(2, 2, 'Sick', 'Approved', '2023-04-02', '2023-04-02'),
(3, 3, 'Vacation', 'Pending', '2023-04-05', '2023-04-06');

INSERT INTO Inventory (Inv_ID, Inv_Name, Inv_Price, Inv_Quantity, Inv_Description, Inventory_Type) VALUES
(1, 'Poker Chips', 1.99, 500, '500-count set of poker chips', 'Game Supplies'),
(2, 'Blackjack Table', 499.99, 1, 'Folding blackjack table', 'Furniture'),
(3, 'Bar Stool', 49.99, 10, 'Adjustable bar stool', 'Furniture'),
(4, 'Cocktail Glass', 2.99, 100, '12 oz cocktail glass', 'Glassware'),
(5, 'Uniforms',20, 40, 'Uniforms for employees', 'Clothes');

INSERT INTO Inventory_Shift (Inventory_ID, Shift_ID, Inventory_Quantity, Inventory_Status) VALUES
(1, 1, 100, 'In Use'),
(2, 2, 1, 'In Use'),
(3, 3, 2, 'In Use'),
(4, 7, 5, 'In Use'),
(1, 4, 100, 'In Use'),
(2, 5, 1, 'In Use'),
(3, 6, 2, 'In Use'),
(4, 8, 5, 'In Use');

INSERT INTO Department_History (EMP_ID, Dept_ID, Type_ID, Start_Date, End_Date) VALUES
(1, 1, 1, '2020-01-01', NULL),
(2, 2, 2, '2020-02-01', NULL),
(3, 3, 2, '2020-03-01', NULL),
(4, 4, 2, '2020-04-01', NULL),
(1, 3, 2, '2023-01-01', NULL),
(2, 3, 2, '2023-02-01', NULL),
(3, 1, 2, '2023-03-01', NULL),
(4, 2, 2, '2023-04-01', NULL);

INSERT INTO Uniform (Uni_ID, Uni_Issued_To, Uniform_Status, Uniform_Size, Issued_Date) VALUES
(1, 1, 'Issued', 'M', '2023-01-01'),
(2, 2, 'Issued', 'S', '2023-02-01'),
(3, 3, 'Issued', 'L', '2023-03-01'),
(4, 4, 'Issued', 'XL', '2023-04-01');

INSERT INTO Warning (Warn_ID, Warn_Issued_To, Warn_Issued_By, Warn_Issue_Date, Warn_Level, Warn_Details) VALUES
(1, 1, 4, '2023-01-15', 1, 'Late for shift'),
(2, 2, 4, '2023-02-15', 1, 'Customer complaint'),
(3, 3, 4, '2023-03-15', 1, 'Improper uniform'),
(4, 3, 4, '2023-04-15', 2, 'Absent without notice');

INSERT INTO Type_Skill (Type_ID, Skill_ID) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 4),
(3, 5),
(4, 3),
(5, 4),
(6, 5),
(7, 1);


INSERT INTO Certificates (Cert_ID, Cert_Type, Cert_Date_Issued, Cert_Exp_Date, Issuing_Auth, Skill_ID, Type_ID, Cert_Issued_To) VALUES
(1, 'CPR Certification', '2020-01-01', '2025-01-01', 'Red Cross', 2, 1, 1),
(2, 'First Aid Certification', '2020-02-01', '2025-02-01', 'Red Cross', 1, 2, 2),
(3, 'Card Dealing Certification', '2020-03-01', '2025-03-01', 'Casino Association', 4, 3, 3),
(4, 'Blackjack Strategy Certification', '2020-04-01', '2025-04-01', 'Casino Association', 3, 4, 4);

INSERT INTO Training (Training_ID, EMP_Trained, EMP_Trainer, Training_Date, Training_Type, Cert_ID) VALUES
(1, 1, 2, '2023-01-10', 'On-the-job training', 1),
(2, 2, 3, '2023-02-10', 'Classroom training', 2),
(3, 3, 4, '2023-03-10', 'On-the-job training', 3),
(4, 4, 1, '2023-04-10', 'Classroom training', 4);

Select * from Employee;
