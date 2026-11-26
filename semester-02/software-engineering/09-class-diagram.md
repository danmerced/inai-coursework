# UML — диаграмма классов

![Классы библиотечной системы](uml/class-diagram.svg)

[Исходник DOT](uml/class-diagram.dot)

```mermaid
classDiagram
    class Account {
        -int id
        -String name
        -String email
        -String passwordHash
        -Role role
        -boolean active
    }
    class Book {
        -int id
        -String isbn
        -String title
        -String author
        -String genre
        -int publicationYear
        -int totalCopies
        -int availableCopies
    }
    class Loan {
        -int id
        -LocalDate issuedAt
        -LocalDate dueAt
        -LocalDate returnedAt
        +isOverdue(date) boolean
    }
    class AuthService {
        +register(name,email,password)
        +login(email,password) Account
        +resetPassword(token,password)
        +logout()
    }
    class CatalogService {
        +search(query,sort) List
        +add(actor,book)
        +update(actor,book)
    }
    class LoanService {
        +issue(actor,readerId,bookId,dueAt) Loan
        +returnBook(actor,loanId)
        +history(actor) List
    }
    class AdminService {
        +block(actor,accountId)
        +deactivate(actor,accountId)
        +overdue(actor) List
        +notifyReader(actor,loanId)
        +report(actor,period,genre)
    }
    class BackupService {
        +createBackup(actor)
        +scheduleBackup(actor,schedule)
        +restore(actor,backup)
    }
    class LibraryRepository {
        +findBook(id) Book
        +findAccount(id) Account
        +findLoan(id) Loan
        +saveBook(book)
        +saveLoan(loan)
    }
    Account "1" -- "0..*" Loan : reader
    Book "1" -- "0..*" Loan : book
    AuthService ..> LibraryRepository
    CatalogService ..> LibraryRepository
    LoanService ..> LibraryRepository
    AdminService ..> LibraryRepository
    BackupService ..> LibraryRepository
    LibraryRepository ..> Account
    LibraryRepository ..> Book
    LibraryRepository ..> Loan
```

Account содержит роль и статус аккаунта; Book хранит данные фонда; Loan связывает читателя с конкретной книгой и датами выдачи и возврата. Сервисы проверяют права пользователя, применяют бизнес-правила и обращаются к хранилищу. Операции выдачи и возврата выполняются в транзакции.
