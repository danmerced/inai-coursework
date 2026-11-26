SELECT * FROM address ORDER BY last_name,first_name;
SELECT * FROM address WHERE city='Бишкек';
SELECT s.full_name,s.class,g.credit1,g.credit2,g.credit3,ROUND((g.credit1+g.credit2+g.credit3)/3.0,2) AS average_score,g.credit1+g.credit2+g.credit3 AS total_score
FROM students s JOIN grades g ON s.id=g.student_id ORDER BY s.class,s.full_name;
SELECT s.full_name,b.title,l.issued_on,l.returned_on
FROM readers r JOIN students s ON r.student_id=s.id JOIN loans l ON r.id=l.reader_id JOIN books b ON l.book_id=b.id ORDER BY s.full_name,l.issued_on;
