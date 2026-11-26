CREATE TABLE IF NOT EXISTS student_group (
    id INT PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS student (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES student_group(id)
);
CREATE TABLE IF NOT EXISTS grade (
    id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR(80) NOT NULL,
    points INT NOT NULL CHECK(points BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES student(id)
);
CREATE INDEX grade_student ON grade(student_id);
INSERT INTO student_group VALUES (1, 'AIN-1'), (2, 'AIN-2');
INSERT INTO student VALUES (1,'Anna',1),(2,'Ivan',1),(3,'Maria',2);
INSERT INTO grade VALUES (1,1,'Java',88),(2,2,'Java',76),(3,1,'SQL',95),(4,3,'SQL',81);
