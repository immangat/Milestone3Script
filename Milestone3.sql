
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

--Redudant, we already drop database 'DatabaseName'
-- DROP TABLE IF EXISTS Department_History;
-- DROP TABLE IF EXISTS Inventory_Shift;
-- DROP TABLE IF EXISTS Training;
-- DROP TABLE IF EXISTS Certificates;
-- DROP TABLE IF EXISTS Type_Skill;
-- DROP TABLE IF EXISTS Warning;
-- DROP TABLE IF EXISTS Uniform;
-- DROP TABLE IF EXISTS TimeOff;
-- DROP TABLE IF EXISTS Shift;
-- DROP TABLE IF EXISTS Schedule;
-- DROP TABLE IF EXISTS Employee;
-- DROP TABLE IF EXISTS Inventory;
-- DROP TABLE IF EXISTS Section;
-- DROP TABLE IF EXISTS Skill;
-- DROP TABLE IF EXISTS Department;
-- DROP TABLE IF EXISTS Employee_Type;

CREATE TABLE Employee_Type (
    Type_ID INT PRIMARY KEY,
    Type_Title VARCHAR(50) NOT NULL,
    Type_Description VARCHAR(100)
);


CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Dept_Manager INT,
    Dept_Ph_Number VARCHAR(20)
);



CREATE TABLE Section (
    Section_ID INT PRIMARY KEY,
    Section_Description VARCHAR(100)
);

CREATE TABLE Skill (
    Skill_ID INT PRIMARY KEY,
    Skill_Des VARCHAR(100) NOT NULL,
	Section_ID INT,
	FOREIGN KEY (Section_ID) REFERENCES Section(Section_ID)
);

CREATE TABLE Employee (
  EMP_ID INT NOT NULL PRIMARY KEY,
  EMP_Name VARCHAR(255) NOT NULL,
  EMP_DOB DATE NOT NULL,
  EMP_Email VARCHAR(255) NOT NULL,
  EMP_Phone_Number VARCHAR(20) NOT NULL,
  EMP_Address VARCHAR(255) NOT NULL,
  EMP_City VARCHAR(255) NOT NULL,
  EMP_Country VARCHAR(255) NOT NULL, 
  EMP_Street VARCHAR(255) NOT NULL,
  EMP_House_Number VARCHAR(10) NOT NULL,
  EMP_Postal_Code VARCHAR(10) NOT NULL,
  EMP_Gender VARCHAR(10),
  EMP_Hire_Date DATE NOT NULL,
  EMP_Pay_Rate DECIMAL(10, 2) NOT NULL,
  EMP_Dismiss_Date DATE,
  DEPT_ID INT,
  EMP_TYPE_ID INT,
  EMP_Vacation_TimeOff DECIMAL(10, 2),
  EMP_Sick_TimeOff DECIMAL(10, 2),
  FOREIGN KEY (DEPT_ID) REFERENCES Department(Dept_ID),
  FOREIGN KEY (EMP_TYPE_ID) REFERENCES Employee_Type(Type_ID)
);

ALTER TABLE Department
ADD CONSTRAINT Dept_Manager
FOREIGN KEY (Dept_Manager)
REFERENCES Employee (EMP_ID);

CREATE TABLE Schedule (
  Schedule_ID INT PRIMARY KEY,
  Schedule_From DATE NOT NULL,
  Schedule_To DATE NOT NULL,
  Made_By INT NOT NULL,
  FOREIGN KEY (Made_By) REFERENCES Employee(EMP_ID)
);

CREATE TABLE Shift (
  Shift_ID INT PRIMARY KEY,
  Shift_Start DATETIME  NOT NULL,
  Shift_End DATETIME  NOT NULL,
  EMP_Working INT NOT NULL,
  EMP_Covering INT,
  Is_Breaker_Shift BIT NOT NULL,
  Schedule_ID INT NOT NULL,
  Section_ID INT NOT NULL,
  FOREIGN KEY (EMP_Working) REFERENCES Employee(EMP_ID),
  FOREIGN KEY (Schedule_ID) REFERENCES Schedule(Schedule_ID),
  FOREIGN KEY (Section_ID) REFERENCES Section(Section_ID),
  FOREIGN KEY (EMP_Covering) REFERENCES Employee(EMP_ID)
);



CREATE TABLE TimeOff (
  Time_ID INT PRIMARY KEY,
  EMP_ID INT NOT NULL,
  TimeOff_Type VARCHAR(50) NOT NULL,
  Time_Approval_Status VARCHAR(50) NOT NULL,
  TimeOff_Start_Date DATE NOT NULL,
  TimeOff_End_Date DATE NOT NULL,
  FOREIGN KEY (EMP_ID) REFERENCES Employee(EMP_ID),
);

CREATE TABLE Inventory (
  Inv_ID INT PRIMARY KEY,
  Inv_Name VARCHAR(255) NOT NULL,
  Inv_Price DECIMAL(10, 2) NOT NULL,
  Inv_Quantity INT NOT NULL,
  Inv_Description VARCHAR(255),
  Inventory_Type VARCHAR(50)
);

CREATE TABLE Inventory_Shift (
  Inventory_ID INT NOT NULL,
  Shift_ID INT NOT NULL,
  Inventory_Quantity INT NOT NULL,
  Inventory_Status VARCHAR(50) NOT NULL,
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
    Cert_Des VARCHAR(50) NOT NULL,
    Cert_Date_Issued DATE NOT NULL,
    Cert_Exp_Date DATE NOT NULL,
    Issuing_Auth VARCHAR(50) NOT NULL,
	Cert_Issued_To INT NOT NULL,
    FOREIGN KEY (Cert_Issued_To) REFERENCES Employee (EMP_ID)
);





CREATE TABLE Skill_Training (
    Training_ID INT PRIMARY KEY,
    EMP_Trained INT NOT NULL,
    EMP_Trainer INT NOT NULL,
    Training_Date DATE NOT NULL,
	Training_Exp DATE NOT NULL,
	Skill_ID INT NOT NULL,
    Type_ID INT NOT NULL,
	Need_Updating BIT NOT NULL,
    FOREIGN KEY (EMP_Trained) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (EMP_Trainer) REFERENCES Employee (EMP_ID),
   FOREIGN KEY (Skill_ID, Type_ID) REFERENCES Type_Skill (Type_ID, Skill_ID)
);

Use Casino;

INSERT INTO Employee_Type (Type_ID, Type_Title, Type_Description) VALUES
(1, 'Manager', 'Manages all departments'),
(2, 'Supervisor', 'Supervises employees in their respective departments'),
(3, 'Dealer', 'Operates games in the casino'),
(4, 'Security', 'Ensures safety and security of the casino'),
(5, 'Server', 'Serves food and beverages to casino guests'),
(6, 'Cleaner', 'Cleans and maintains the casino premises'),
(7, 'IT Support', 'Provides technical support to the casino'),
(8, 'Slot Attendant', 'Attendants to the Slot Machines');

INSERT INTO Department (Dept_ID, Dept_Name, Dept_Manager, Dept_Ph_Number) VALUES
(1, 'Operations', NULL, '+1-123-456-7890'),
(2, 'Security', NULL, '+1-234-567-8901'),
(3, 'Food and Beverage', NULL, '+1-345-678-9012'),
(4, 'Cleaning', NULL, '+1-456-789-0123');



INSERT INTO Section (Section_ID, Section_Description) VALUES
(1, 'Table Games'),
(2, 'Slot Machines'),
(3, 'Poker Room'),
(4, 'Restaurant'),
(5, 'Bar'),
(6, 'Kitchen'),
(7, 'Restrooms'),
(8, 'Lobby'),
(9, 'North'),
(10, 'South'),
(11, 'West'),
(12, 'East'),
(13, 'High Value');

INSERT INTO Skill (Skill_ID, Skill_Des, Section_ID) VALUES
(1, 'Shuffling Cards', 1),
(2, 'Food Safety', 6),
(3, 'Problem-solving', 3),
(4, 'Customer service', 8),
(5, 'Time management', 5);

INSERT INTO Employee (EMP_ID, EMP_Name, EMP_DOB, EMP_Email, EMP_Phone_Number, EMP_Address, EMP_City, EMP_Country, EMP_Street, EMP_House_Number, EMP_Postal_Code, EMP_Gender, EMP_Hire_Date, EMP_Pay_Rate, EMP_Dismiss_Date, DEPT_ID, EMP_TYPE_ID, EMP_Vacation_TimeOff, EMP_Sick_TimeOff) VALUES
(1, 'John Smith', '1980-01-01', 'john.smith@example.com', '+1-111-111-1111', '123 Main St', 'Las Vegas', 'USA', 'Main St', '123', '12345', 'Male', '2020-01-01', 20.00, NULL, 1, 1, 10.00, 5.00),
(2, 'Jane Doe', '1990-01-01', 'jane.doe@example.com', '+1-222-222-2222', '456 Elm St', 'Las Vegas', 'USA', 'Elm St', '456', '12345', 'Female', '2020-02-01', 15.00, NULL, 2, 2, 5.00, 2.50),
(3, 'Mike Johnson', '1985-01-01', 'mike.johnson@example.com', '+1-333-333-3333', '789 Oak St', 'Las Vegas', 'USA', 'Oak St', '789', '12345', 'Male', '2020-03-01', 12.00, NULL, 3, 2, 5.00, 2.50),
(4, 'Mangat Toor', '2001-01-01', 'mangat.toor@example.com', '+1-999-333-3333', '7839 Oak St', 'Las Vegas', 'USA', 'Oak St', '789', '12345', 'Male', '2020-03-01', 12.00, NULL, 3, 2, 5.00, 2.50),
(5, 'Sarah Lee', '1989-06-12', 'sarah.lee@example.com', '+1-444-444-4444', '123 Maple St', 'New York', 'USA', 'Maple St', '123', '10001', 'Female', '2021-01-01', 25.00, NULL, 2, 3, 10.00, 7.00),
(6, 'Adam Jones', '1995-09-22', 'adam.jones@example.com', '+1-555-555-5555', '456 Oak St', 'New York', 'USA', 'Oak St', '456', '10001', 'Male', '2021-02-01', 18.00, NULL, 1, 4, 5.00, 2.50),
(7, 'Jessica Smith', '1992-04-10', 'jessica.smith@example.com', '+1-666-666-6666', '789 Elm St', 'Los Angeles', 'USA', 'Elm St', '789', '90001', 'Female', '2021-03-01', 22.00, NULL, 4, 8, 7.00, 3.50),
(8, 'Michael Brown', '1987-11-15', 'michael.brown@example.com', '+1-777-777-7777', '123 Oak St', 'Los Angeles', 'USA', 'Oak St', '123', '90001', 'Male', '2021-04-01', 20.00, NULL, 3, 5, 6.00, 3.00),
(9, 'Emily Wilson', '1999-02-28', 'emily.wilson@example.com', '+1-888-888-8888', '456 Maple St', 'Chicago', 'USA', 'Maple St', '456', '60007', 'Female', '2021-05-01', 16.00, NULL, 1, 6, 4.00, 2.00),
(10, 'Robert Garcia', '1982-12-07', 'robert.garcia@example.com', '+1-999-999-9999', '789 Elm St', 'Chicago', 'USA', 'Elm St', '789', '60007', 'Male', '2021-06-01', 24.00, NULL, 2, 8, 8.00, 4.00);

UPDATE Department
SET Dept_Manager = 1
WHERE Dept_ID = 1;

INSERT INTO Schedule (Schedule_ID, Schedule_From, Schedule_To, Made_By) VALUES
(1, '2023-04-01', '2023-04-07', 1),
(2, '2023-04-08', '2023-04-14', 1),
(3, '2023-04-01', '2023-04-07', 2),
(4, '2023-04-08', '2023-04-14', 2),
(5, '2023-04-01', '2023-04-07', 3),
(6, '2023-04-08', '2023-04-14', 3);

INSERT INTO Shift (Shift_ID, Shift_Start, Shift_End, EMP_Working, EMP_Covering, Is_Breaker_Shift, Schedule_ID, Section_ID) VALUES
(1, '2023-04-01 09:00:00', '2023-04-01 13:00:00', 1, NULL, 0, 1, 1),
(2, '2023-04-01 13:00:00', '2023-04-01 17:00:00', 2, NULL, 0, 1, 2),
(3, '2023-04-01 17:00:00', '2023-04-01 21:00:00', 3, NULL, 0, 1, 3),
(4, '2023-04-02 09:00:00', '2023-04-02 13:00:00', 1, NULL, 0, 1, 1),
(5, '2023-04-02 13:00:00', '2023-04-02 17:00:00', 2, NULL, 0, 1, 2),
(6, '2023-04-02 17:00:00', '2023-04-02 21:00:00', 3, NULL, 0, 1, 3),
(7, '2023-04-01 09:00:00', '2023-04-01 13:00:00', 4, NULL, 0, 2, 4),
(8, '2023-04-01 13:00:00', '2023-04-01 17:00:00', 1, NULL, 0, 2, 5),
(9, '2023-04-01 17:00:00', '2023-04-01 21:00:00', 2, NULL, 0, 2, 6),
(10, '2023-04-02 09:00:00', '2023-04-02 13:00:00', 4, NULL, 0, 2, 4),
(11, '2023-04-02 13:00:00', '2023-04-02 17:00:00', 1, NULL, 0, 2, 5),
(12, '2023-04-02 17:00:00', '2023-04-02 21:00:00', 2, NULL, 0, 2, 6),
(13, '2023-04-01 09:45:00', '2023-04-01 10:00:00', 1, 2, 1, 1, 1),
(14, '2023-04-02 13:45:00', '2023-04-02 14:00:00', 1, 2, 1, 1, 1),
(15, '2023-04-01 6:00:00', '2023-04-02 14:00:00', 10, NULL, 0, 1, 1);


INSERT INTO TimeOff (Time_ID, EMP_ID, TimeOff_Type, Time_Approval_Status, TimeOff_Start_Date, TimeOff_End_Date) VALUES
(1, 1, 'Vacation', 'Approved', '2023-04-01', '2023-04-03'),
(2, 2, 'Sick', 'Approved', '2023-04-02', '2023-04-02'),
(3, 3, 'Vacation', 'Pending', '2023-04-05', '2023-04-06');

INSERT INTO Inventory (Inv_ID, Inv_Name, Inv_Price, Inv_Quantity, Inv_Description, Inventory_Type) VALUES
(1, 'Poker Chips', 1.99, 500, '500-count set of poker chips', 'Game Supplies'),
(2, 'Blackjack Table', 499.99, 1, 'Folding blackjack table', 'Furniture'),
(3, 'Bar Stool', 49.99, 10, 'Adjustable bar stool', 'Furniture'),
(4, 'Cocktail Glass', 2.99, 100, '12 oz cocktail glass', 'Glassware'),
(5, 'Uniforms-S',20, 40, 'Size S Uniforms for employees.', 'Clothes'),
(6, 'Uniforms-M',20, 40, 'Size M Uniforms for employees', 'Clothes'),
(7, 'Uniforms-L',20, 40, 'Size L Uniforms for employees', 'Clothes');

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


INSERT INTO Certificates (Cert_ID, Cert_Des, Cert_Date_Issued, Cert_Exp_Date, Issuing_Auth, Cert_Issued_To) VALUES
(1, 'CPR Certification', '2020-01-01', '2023-04-28', 'Red Cross', 1),
(2, 'First Aid Certification', '2020-02-01', '2025-02-01', 'Red Cross', 2),
(3, 'Card Dealing Certification', '2020-03-01', '2025-03-01', 'Casino Association', 3),
(4, 'Blackjack Strategy Certification', '2020-04-01', '2025-04-01', 'Casino Association', 4);

INSERT INTO Skill_Training (Training_ID, EMP_Trained, EMP_Trainer, Training_Date,Training_Exp, Skill_ID, Type_ID, Need_Updating) VALUES
(1, 1, 2, '2023-01-10','2023-01-25', 2, 1, 0),
(2, 2, 3, '2023-02-10', '2024-02-10',1, 2, 0),
(3, 3, 4, '2023-03-10', '2024-04-10',4, 3, 0),
(4, 4, 1, '2023-04-10', '2024-04-10',3, 4, 1);


USE Casino;

--Number of hours each employee worked per week?
SELECT EMP_Working, SUM(DATEDIFF(HOUR, Shift_Start, Shift_End)) AS Hours_Worked
FROM Shift
GROUP BY EMP_Working;

--Number of labor hours last week?
SELECT SUM(DATEDIFF(HOUR, Shift_Start, Shift_End)) AS Total_Hours_Worked
FROM Shift
WHERE Shift_Start >= DATEADD(WEEK, -1, GETDATE()) AND Shift_Start < GETDATE();

--List of which employees worked breaker shifts in the last month.
SELECT DISTINCT EMP_Working
FROM Shift
WHERE Is_Breaker_Shift = 1 AND Shift_Start >= DATEADD(MONTH, -1, GETDATE()) AND Shift_Start < GETDATE();


--How many breaker shifts are scheduled this week?
SELECT COUNT(*) AS Breaker_Scheduled
FROM Shift
WHERE Is_Breaker_Shift = 1 AND Shift_Start >= GETDATE() AND Shift_Start < DATEADD(WEEK, 1, GETDATE());


--How many Slot Attendants are scheduled today?
SELECT COUNT(*) AS Slot_Attendants_Scheduled_Today
FROM Shift
JOIN Employee ON Shift.EMP_Working = Employee.EMP_ID
WHERE EMP_TYPE_ID = (SELECT Type_ID FROM Employee_Type WHERE Type_Title = 'Slot Attendant') AND CONVERT(DATE, Shift_Start) = CONVERT(DATE, GETDATE());

--Any Slot Attendants who have not been assigned to Section NORTH in the last month?
SELECT EMP_ID
FROM Employee
WHERE EMP_TYPE_ID = (SELECT Type_ID FROM Employee_Type WHERE Type_Title = 'Slot Attendant') AND EMP_ID NOT IN (
    SELECT DISTINCT EMP_Working
    FROM Shift
    JOIN Section ON Shift.Section_ID = Section.Section_ID
    WHERE Section_Description = 'NORTH' AND Shift_Start >= DATEADD(MONTH, -1, GETDATE()) AND Shift_Start < GETDATE()
);
--Number of active Written Warning (WW) employee A has?
--Replace employee_id with the employee's ID.
SELECT COUNT(*) AS Active_Warnings
FROM Warning
WHERE Warn_Issued_To = 1 AND Warn_Level = 1;

--List of active WW sorted by date and employee?
SELECT *
FROM Warning
WHERE Warn_Level = 1
ORDER BY Warn_Issue_Date, Warn_Issued_To;

--A list of an employee's discipline/performance actions?
SELECT *
FROM Warning
WHERE Warn_Issued_To = 1;

--Number of sick days an employee has available?
SELECT EMP_Sick_TimeOff
FROM Employee
WHERE EMP_ID = 2;

--Number of vacation days an employee has available?
SELECT EMP_Vacation_TimeOff
FROM Employee
WHERE EMP_ID = 3;

--Statistics on Employees: Number of Female/Male employees, Average age of employees? Number of employees over 50? Under 30?
SELECT
    (SELECT COUNT(*) FROM Employee WHERE EMP_Gender = 'Male') AS Num_Male,
    (SELECT COUNT(*) FROM Employee WHERE EMP_Gender = 'Female') AS Num_Female,
    AVG(DATEDIFF(YEAR, EMP_DOB, GETDATE())) AS Average_Age,
    (SELECT COUNT(*) FROM Employee WHERE DATEDIFF(YEAR, EMP_DOB, GETDATE()) > 50) AS NumberOfEmployeesOver50,
    (SELECT COUNT(*) FROM Employee WHERE DATEDIFF(YEAR, EMP_DOB, GETDATE()) < 30) AS NumberOfEmployeesUnder30
FROM Employee;

-- List of employees who has the mandatory certification expiring in the next 6 weeks
SELECT EMP_ID, EMP_Name, Cert_Des , Cert_Exp_Date
FROM Employee
JOIN Certificates ON Employee.EMP_ID = Certificates.Cert_Issued_To
WHERE Cert_Exp_Date BETWEEN GETDATE() AND DATEADD(WEEK, 6, GETDATE());

-- List of employees who need updated in-house training
-- (Assuming a training table and considering training expiration)
SELECT EMP_ID, EMP_Name, Training_Exp
FROM Employee
JOIN Skill_Training ON Employee.EMP_ID = Skill_Training.EMP_Trained
WHERE Need_Updating = 1;

-- List of employees who have expired training
-- (Assuming a training table and considering training expiration)
SELECT EMP_ID, EMP_Name, Training_Exp
FROM Employee
JOIN Skill_Training ON Employee.EMP_ID = Skill_Training.EMP_Trained
WHERE Training_Exp < GETDATE();

-- How many uniforms remain un-allocated?
SELECT SUM(Inv_Quantity) AS Total_Quantity_Left
FROM Inventory
WHERE Inventory_Type = 'Clothes' AND Inv_Name LIKE 'Uniforms%';

