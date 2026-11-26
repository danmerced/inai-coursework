import unittest
from main import Book, Reader, LibraryMember, Employee, Manager, Department


class OOPTest(unittest.TestCase):
    def setUp(self):
        self.book = Book("Python", "Author", 2024)
        self.reader = Reader("Reader", 1)

    def test_borrow(self):
        self.assertTrue(self.reader.borrow_book(self.book))
        self.assertFalse(self.book.available)
        self.assertEqual(self.reader.books, (self.book,))

    def test_unavailable(self):
        self.reader.borrow_book(self.book)
        self.assertFalse(Reader("Another", 2).borrow_book(self.book))

    def test_return(self):
        self.reader.borrow_book(self.book)
        other = Reader("Other", 2)
        self.assertFalse(other.return_book(self.book))
        self.assertTrue(self.reader.return_book(self.book))
        self.assertTrue(self.book.available)
        self.assertEqual(self.reader.books, ())

    def test_inheritance(self):
        self.assertIsInstance(self.reader, LibraryMember)
        self.assertIn("книг: 0", self.reader.get_info())

    def test_department(self):
        dept = Department("IT")
        dept.add_employee(Employee("A", "Dev", 100))
        dept.add_employee(Manager("B", "Manager", 200))
        self.assertIn("руководитель", dept.get_employees()[1])
        self.assertEqual(Department("Other").get_employees(), [])

    def test_validation(self):
        with self.assertRaises(ValueError):
            Employee("A", "Dev", -1)
        with self.assertRaises(TypeError):
            Department("IT").add_employee("A")


if __name__ == "__main__":
    unittest.main()
