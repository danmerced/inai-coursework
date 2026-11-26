SELECT * FROM student ORDER BY name;
SELECT s.name,g.subject,g.points FROM student s JOIN grade g ON s.id=g.student_id WHERE g.points>=80;
SELECT sg.name, AVG(g.points) AS average_points, COUNT(*) AS grade_count
FROM student_group sg JOIN student s ON s.group_id=sg.id JOIN grade g ON g.student_id=s.id GROUP BY sg.id,sg.name;
SELECT name FROM student WHERE id IN (SELECT student_id FROM grade WHERE points>=90);
UPDATE grade SET points=80 WHERE id=2;
INSERT INTO grade VALUES (5,2,'SQL',84);
DELETE FROM grade WHERE id=5;
