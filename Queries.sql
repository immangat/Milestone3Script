USE Master;

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