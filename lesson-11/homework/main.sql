--  EASY-LEVEL TASKS (10)

-- 1. List all students and their enrolled course names.
SELECT s.StudentName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- 2. Show all courses along with the department they belong to.
SELECT c.CourseName, d.DepartmentName
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID;

-- 3. Display all professors and the courses they teach.
SELECT p.ProfessorName, c.CourseName
FROM Professors p
JOIN Courses c ON p.ProfessorID = c.ProfessorID;

-- 4. Find all students who are enrolled in “Mathematics.”
SELECT s.StudentName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Mathematics';

-- 5. Show each course and the number of enrolled students.
SELECT c.CourseName, COUNT(e.StudentID) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- 6. List all students with their department names.
SELECT s.StudentName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;

-- 7. Show all professors along with the department they belong to.
SELECT p.ProfessorName, d.DepartmentName
FROM Professors p
JOIN Departments d ON p.DepartmentID = d.DepartmentID;

-- 8. Find all courses that are taught in the “A101” classroom.
SELECT c.CourseName
FROM Courses c
JOIN Classrooms cl ON c.ClassroomID = cl.ClassroomID
WHERE cl.RoomNumber = 'A101';

-- 9. Display students and their enrollment dates.
SELECT s.StudentName, e.EnrollmentDate
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID;

-- 10. Show all students who are not enrolled in any course.
SELECT s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL;



-- MEDIUM-LEVEL TASKS (5)

-- 11. List all courses and the names of students enrolled in each course.
SELECT c.CourseName, s.StudentName
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
LEFT JOIN Students s ON e.StudentID = s.StudentID
ORDER BY c.CourseName;

-- 12. Find the number of courses each professor teaches.
SELECT p.ProfessorName, COUNT(c.CourseID) AS CoursesTaught
FROM Professors p
LEFT JOIN Courses c ON p.ProfessorID = c.ProfessorID
GROUP BY p.ProfessorName;

-- 13. List all departments and the number of students in each.
SELECT d.DepartmentName, COUNT(s.StudentID) AS StudentCount
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

-- 14. Display students, their departments, and the courses they are enrolled in.
SELECT s.StudentName, d.DepartmentName, c.CourseName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentName;

-- 15. Show all professors who do not teach any course.
SELECT p.ProfessorName
FROM Professors p
LEFT JOIN Courses c ON p.ProfessorID = c.ProfessorID
WHERE c.CourseID IS NULL;



--  HARD-LEVEL TASKS (5)

-- 16. Find the department with the highest number of enrolled students.
SELECT TOP 1 d.DepartmentName, COUNT(e.StudentID) AS TotalStudents
FROM Departments d
JOIN Students s ON d.DepartmentID = s.DepartmentID
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY d.DepartmentName
ORDER BY TotalStudents DESC;

-- 17. Show the list of courses where more than 2 students are enrolled.
SELECT c.CourseName, COUNT(e.StudentID) AS StudentCount
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 2;

-- 18. Display all students along with their courses and professors’ names.
SELECT s.StudentName, c.CourseName, p.ProfessorName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Professors p ON c.ProfessorID = p.ProfessorID;

-- 19. Show each professor, their department, and the number of students they teach in total.
SELECT p.ProfessorName, d.DepartmentName, COUNT(e.StudentID) AS TotalStudents
FROM Professors p
JOIN Departments d ON p.DepartmentID = d.DepartmentID
LEFT JOIN Courses c ON p.ProfessorID = c.ProfessorID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY p.ProfessorName, d.DepartmentName;

-- 20. Find all students who are enrolled in all the courses offered by their department.
SELECT s.StudentName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE NOT EXISTS (
    SELECT c.CourseID
    FROM Courses c
    WHERE c.DepartmentID = d.DepartmentID
    AND c.CourseID NOT IN (
        SELECT e.CourseID
        FROM Enrollments e
        WHERE e.StudentID = s.StudentID
    )
);
