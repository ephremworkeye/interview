-- Create Table Departments
-- (
--      DepartmentID int primary key,
--      DepartmentName nvarchar(50)
-- )
-- GO

-- Create Table Employees
-- (
--      EmployeeID int primary key,
--      EmployeeName nvarchar(50),
--      DepartmentID int foreign key references Departments(DepartmentID)
-- )
-- GO

-- Insert into Departments values (1, 'IT')
-- Insert into Departments values (2, 'HR')
-- Insert into Departments values (3, 'Payroll')
-- GO

-- Insert into Employees values (1, 'Mark', 1)
-- Insert into Employees values (2, 'John', 1)
-- Insert into Employees values (3, 'Mike', 1)
-- Insert into Employees values (4, 'Mary', 2)
-- Insert into Employees values (5, 'Stacy', 3)

-- SELECT * FROM Departments;
-- SELECT * FROM Employees;

-- SELECT top 1 d.DepartmentName, COUNT(e.EmployeeID) as ct
-- FROM Departments as d
-- INNER JOIN Employees as e
-- ON d.DepartmentID = e.DepartmentID
-- GROUP BY d.DepartmentName
-- ORDER BY ct DESC



SELECT top 1 d.DepartmentName
FROM Departments as d
INNER JOIN Employees as e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY COUNT(*) DESC

