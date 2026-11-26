package study;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "authors")
public class Author {
    @Id @GeneratedValue
    private Long id;
    private String name;
    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<Book> books = new ArrayList<>();

    protected Author() {}
    public Author(String name) { this.name = name; }

    public void addBook(Book book) {
        books.add(book);
        book.setAuthor(this);
    }

    public String getName() { return name; }
    public List<Book> getBooks() { return books; }
}
