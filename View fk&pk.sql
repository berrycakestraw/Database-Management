CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Teacher (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Age INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Management'),
(3, 'Engineering');

INSERT INTO Teacher VALUES
(101, 'Mr. Sharma', 1),
(102, 'Ms. Karki', 2),
(103, 'Mr. Rai', 3);

INSERT INTO Student VALUES
(1, 'Aayusha', 20, 1),
(2, 'Rohan', 21, 2),
(3, 'Sita', 19, 1),
(4, 'Ram', 22, 3),
(5, 'Gita', 20, 2);

--selecting from multiple tables
CREATE VIEW StudentDepartmentTeacher AS
SELECT 
    s.StudentID,
    s.StudentName,
    s.Age,
    d.DepartmentName,
    t.TeacherName
FROM Student s
INNER JOIN Department d 
    ON s.DepartmentID = d.DepartmentID
INNER JOIN Teacher t 
    ON d.DepartmentID = t.DepartmentID;


select * from StudentDepartmentTeacher;

insert into StudentDepartmentTeacher values 
(6, 'Hari', 21, 'Computer Science', 'Mr. Sharma');  --doesn't work

update StudentDepartmentTeacher set StudentName = 'Sunny' --works
where StudentID = 2;

delete from StudentDepartmentTeacher where StudentID = 3;  --doesn't work



--selecting from only one table
CREATE VIEW StudentDepartmentTeacher1 AS
SELECT 
    s.StudentID,
    s.StudentName,
    s.Age,
    s.DepartmentID
FROM Student s
INNER JOIN Department d 
    ON s.DepartmentID = d.DepartmentID
INNER JOIN Teacher t 
    ON d.DepartmentID = t.DepartmentID;


select * from StudentDepartmentTeacher1;

insert into StudentDepartmentTeacher1 values 
(6, 'Hari', 21, 3);  --works

update StudentDepartmentTeacher1 set StudentName = 'Jazzy' --works
where StudentID = 5;

delete from StudentDepartmentTeacher1 where StudentID = 3;  --doesn't work



--crud with group by view
create view DepartmentAge as
select 
d.DepartmentName,
MAX(s.Age) as MaxAge,
MIN(s.Age) as MinAge
from Student s
inner join Department d on s.DepartmentID = d.DepartmentID
group by d.DepartmentName;

select * from DepartmentAge;

insert into DepartmentAge values 
(Medicine, 22, 19);  --doesn't works

update DepartmentAge set MinAge = 18  --doesn't works
where DepartmentName = 'Engineering';

delete from DepartmentAge where DepartmentName = 'Engineering';  --doesn't work