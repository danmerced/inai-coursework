from dataclasses import dataclass, field


@dataclass(eq=False)
class Book:
    title: str
    author: str
    year: int
    available: bool = True

    def borrow(self):
        if not self.available:
            return False
        self.available = False
        return True

    def return_book(self):
        self.available = True


class LibraryMember:
    def __init__(self, name, member_id):
        self.name = name
        self.member_id = member_id

    def get_info(self):
        return f"{self.member_id}: {self.name}"


class Reader(LibraryMember):
    def __init__(self, name, member_id):
        super().__init__(name, member_id)
        self._books = []

    @property
    def books(self):
        return tuple(self._books)

    def borrow_book(self, book):
        if book.borrow():
            self._books.append(book)
            return True
        return False

    def return_book(self, book):
        if book not in self._books:
            return False
        self._books.remove(book)
        book.return_book()
        return True

    def get_info(self):
        return f"{super().get_info()} — книг: {len(self._books)}"


@dataclass
class Employee:
    name: str
    position: str
    salary: float

    def __post_init__(self):
        if self.salary < 0:
            raise ValueError("Зарплата не может быть отрицательной")

    def get_info(self):
        return f"{self.name} ({self.position}): {self.salary:.2f}"


class Manager(Employee):
    def get_info(self):
        return f"{super().get_info()} — руководитель"


@dataclass
class Department:
    name: str
    employees: list = field(default_factory=list)

    def add_employee(self, employee):
        if not isinstance(employee, Employee):
            raise TypeError("Ожидается Employee")
        self.employees.append(employee)

    def get_employees(self):
        return [employee.get_info() for employee in self.employees]


if __name__ == "__main__":
    book = Book("Введение в Python", "Учебный пример", 2024)
    reader = Reader("Читатель", 1)
    reader.borrow_book(book)
    print(reader.get_info(), book.available)
    reader.return_book(book)
    department = Department("ИТ")
    department.add_employee(Employee("Сотрудник", "разработчик", 45000))
    department.add_employee(Manager("Руководитель", "менеджер", 60000))
    print(*department.get_employees(), sep="\n")
