drop table if exists Student;

Create table Student(
StudentID int primary key,
FullName varchar(50) not null,
Email varchar(50) unique,
DOB varchar(20),
Gender varchar(10)
);

Create table Courses(
CourseID int primary key,
CourseName varchar(20) not null,
CreditHours int default 3
);

Create table Enrollments(
EnrollmentID int primary key,
StudentID int,
CourseID int,
EnrollDate varchar(20),
Constraint fk_Enroll_Student
foreign key (StudentID) references Student(StudentID),
Constraint fk_Enroll_Courses
foreign key (CourseID) references Courses(CourseID)
);

Insert into Student values
(1, 'Anne Rai', 'anne@gmail.com', '2002-01-12', 'Female'),
(2, 'Ram Bahadur', 'ram@gmail.com', '2002-08-20', 'Male'),
(3, 'Jake Brigherton', 'bri@gmail.com', '2000-04-24', 'Male'),
(4, 'Penny Troy', 'pen@gmail.com', '2004-05-04', 'Female'),
(5, 'Kori Kim', 'kor@gmail.com', '2005-09-18', 'Female');

Insert into Courses values
(1, 'Math', 5),
(2, 'Science', 7),
(3, 'Art', 4);

Insert into Enrollments values
(1, 1, 2, '2025-02-06'),
(2, 3, 2, '2025-02-06'),
(3, 5, 1, '2025-02-06');

Select * from Student;
Select * from Courses;
Select * from Enrollments;

update Student set email = 'jake@gmail.com' where StudentID = 3;

delete from Enrollments where EnrollmentID = 2;