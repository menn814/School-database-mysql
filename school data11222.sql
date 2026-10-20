
CREATE DATABASE school8;
USE school8;
CREATE TABLE teachers (
    teacherID INT PRIMARY KEY UNIQUE,
    teacher_name VARCHAR(250) NOT NULL,
    phone VARCHAR(25),
    salary INT
);

CREATE TABLE Classes (
    Class_id INT PRIMARY KEY UNIQUE,
    class_name VARCHAR(10) NOT NULL,
    capacity INT,
    floor1 INT,
    teacherID INT,
    FOREIGN KEY (teacherID) REFERENCES teachers(teacherID)
);

CREATE TABLE students (
    Stud_ID INT PRIMARY KEY UNIQUE,
    stud_name VARCHAR(250) NOT NULL,
    age INT,
    grade VARCHAR(10),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES Classes(Class_id)
);

CREATE TABLE Subjects (
    subjectID INT PRIMARY KEY UNIQUE,
    subjectName VARCHAR(30) NOT NULL,
    teacherID INT,
    book_name VARCHAR(50),
    hoursPerWeek INT,
    FOREIGN KEY (teacherID) REFERENCES teachers(teacherID)
);

CREATE TABLE grades (
    grade_id INT PRIMARY KEY UNIQUE,
    score INT,
    exam_date DATE,
    Stud_ID INT,
    FOREIGN KEY (Stud_ID) REFERENCES students(Stud_ID),
    subjectID INT,
    FOREIGN KEY (subjectID) REFERENCES Subjects(subjectID)
);
CREATE TABLE attendance (
    attend_id INT PRIMARY KEY,
    attend_date DATE,
    Stud_ID INT,
    status ENUM('present', 'absent'),
    note VARCHAR(250),
    time1 TIME,
    FOREIGN KEY (Stud_ID) REFERENCES students(Stud_ID)
);
-- insert teacher
INSERT INTO teachers VALUES 
(1, 'Mohammed', '0102323', 2024),
(2, 'Esraa', '013242', 2040),
(3, 'Alaa', '043430', 2043),
(4, 'Sara', '03243', 4324),
(5, 'Hager', '434234', 6532),
(6, 'Aya', '1892781', 1227),
(7, 'Ahmed', '232211', 3213);

-- Insert classes
INSERT INTO Classes VALUES 
(99, 'A9', 20, 1, 1),
(100, 'A4', 20, 1, 2),
(101, 'B1', 20, 2, 3),
(102, 'B3', 20, 2, 4),
(103, 'C7', 20, 3, 5),
(104, 'C8', 20, 3, 6),
(105, 'C9', 20, 3, 7);

-- Insert students
INSERT INTO students VALUES 
(200, 'Mariem', 13, 'A+', 99),
(201, 'Menna', 12, 'A', 100),
(202, 'Karim', 13, 'A+', 101),
(203, 'Ibrahim', 14, 'A+', 102),
(204, 'Nada', 15, 'B+', 103),
(205, 'Mostafa', 16, 'C', 104),
(206, 'Atef', 15, 'A', 105);

-- Insert subjects
INSERT INTO Subjects VALUES 
(500, 'Arabic', 1, 'Arabic basics', 6),
(501, 'English', 2, 'English for beginners', 4),
(502, 'Science', 3, 'Science basics', 4),
(503, 'Maths', 4, 'Maths fundomentals', 5),
(504, 'Art', 6, 'Art skills guide', 2),
(505, 'Physics', 5, 'Physics principles', 4),
(506, 'Biology', 7, 'Biology essentials', 4);

-- Insert grades
INSERT INTO grades VALUES 
(1, 99, '2024-04-04', 200, 500),
(2, 89, '2024-04-05', 201, 501),
(3, 95, '2024-05-01', 202, 502),
(4, 85, '2024-04-23', 203, 503),
(5, 65, '2024-03-03', 204, 504),
(6, 90, '2024-04-05', 205, 505);

-- Insert attendance
INSERT INTO attendance VALUES 
(11, '2025-05-05', 200, 'present', 'good attendance', '08:00'),
(12, '2025-05-05', 201, 'absent', 'sick', '08:00'),
(13, '2025-05-05', 202, 'present', 'no uniform', '08:00'),
(14, '2025-05-05', 203, 'absent', 'with permission', '08:00'),
(15, '2025-05-05', 204, 'present', 'left early', '08:00'),
(16, '2025-05-05', 205, 'absent', 'sick', '08:00'),
(17, '2025-05-05', 206, 'present', 'late', '08:00');

---
-- 4. Updates & Deletes
UPDATE students SET stud_name = 'Eman' WHERE Stud_ID = 200;
UPDATE teachers SET salary = 4489 WHERE teacherID = 3;

DELETE FROM grades WHERE grade_id = 7;
DELETE FROM attendance WHERE attend_id = 11;

---
-- Retrieve data
SELECT * FROM teachers;
SELECT attend_id, attend_date FROM attendance;
SELECT class_name FROM Classes;

-- Filter with WHERE
SELECT * FROM students WHERE age > 11;
SELECT * FROM teachers WHERE salary > 2500;

-- LIKE
SELECT * FROM teachers WHERE teacher_name LIKE '%n%';
SELECT * FROM students WHERE stud_name LIKE 'm%';

-- BETWEEN
SELECT * FROM teachers WHERE salary BETWEEN 2000 AND 3000;
SELECT * FROM students WHERE age BETWEEN 10 AND 13;

-- ORDER BY
SELECT * FROM teachers ORDER BY salary;
SELECT * FROM students ORDER BY stud_name;

-- Aggregation functions
SELECT COUNT(salary) AS the_salary FROM teachers;
SELECT COUNT(*) AS total_records FROM teachers;
SELECT SUM(salary) AS total_salary FROM teachers;
SELECT SUM(capacity) AS total_seats FROM Classes;
SELECT AVG(salary) AS avg_salary FROM teachers;
SELECT AVG(capacity) AS avg_seat FROM Classes;
SELECT MIN(salary) AS low_salary FROM teachers;
SELECT MAX(salary) AS high_salary FROM teachers;
SELECT MIN(age) AS young_student FROM students;
SELECT MAX(age) AS older_student FROM students;
-- groub by
select subjectID, avg(score) as avg_score
from grades
group by subjectID;

select Class_id, count(*) as total_students
from students
group by Class_id;
-- inner
select s.stud_name, c.class_name
from students s
inner join Classes c
on s.Class_id = c.Class_id;


-- left join
select s.stud_name, c.class_name
from students s
left join Classes c
on s.Class_id = c.Class_id;
--
select s.stud_name, c.class_name, t.teacher_name
from students s
join Classes c on s.Class_id = c.Class_id
join teachers t on c.teacherID = t.teacherID;
--
select stud_name
from students
where Stud_ID in (
    select Stud_ID
    from grades
    where score > 90
);
--
select stud_name
from students
where Class_id in (99, 100);
--
select s.stud_name, g.score
from grades g
join students s on g.Stud_ID = s.Stud_ID
where g.score > (select avg(score) from grades);