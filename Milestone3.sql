
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
    Dept_Manager VARCHAR(50) NOT NULL,
    Dept_Ph_Number VARCHAR(20) NOT NULL
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
  FOREIGN KEY (Made_By) REFERENCES Employee(EMP_ID),

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
    End_Date DATE NOT NULL,
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
    Traning_Type VARCHAR(50) NOT NULL,
    Cert_ID INT NOT NULL,
    FOREIGN KEY (EMP_Trained) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (EMP_Trainer) REFERENCES Employee (EMP_ID),
    FOREIGN KEY (Cert_ID) REFERENCES Certificates (Cert_ID)
);
