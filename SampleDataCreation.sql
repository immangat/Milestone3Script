
Use Milestone3;

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
(4, 'Mangat Toor', '2001-01-01', 'mangat.toor@example.com', '+1-999-333-3333', '7839 Oak St', 'Las Vegas', 'USA', 'Oak St', '789', '12345', 'Male', '2020-03-01', 12.00, NULL, 3, 2, 5.00, 2.50);



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
(4, 'Cocktail Glass', 2.99, 100, '12 oz cocktail glass', 'Glassware');

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
(1, 1, 2, '2023-01-15', 1, 'Late for shift'),
(2, 2, 3, '2023-02-15', 2, 'Customer complaint'),
(3, 3, 4, '2023-03-15', 1, 'Improper uniform'),
(4, 4, 1, '2023-04-15', 2, 'Absent without notice');

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

INSERT INTO Training (Training_ID, EMP_Trained, EMP_Trainer, Training_Date, Traning_Type, Cert_ID) VALUES
(1, 1, 2, '2023-01-10', 'On-the-job training', 1),
(2, 2, 3, '2023-02-10', 'Classroom training', 2),
(3, 3, 4, '2023-03-10', 'On-the-job training', 3),
(4, 4, 1, '2023-04-10', 'Classroom training', 4);
