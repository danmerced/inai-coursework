package study;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "books")
public class Book {
    @Id @GeneratedValue
    private Long id;
    private String title;
    @ManyToOne(optional = false)
    private Author author;
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "book_genre", joinColumns = @JoinColumn(name = "book_id"), inverseJoinColumns = @JoinColumn(name = "genre_id"))
    private Set<Genre> genres = new HashSet<>();
    protected Book() {}
    public Book(String title) { this.title = title; }
    public void setAuthor(Author author) { this.author = author; }
    public void addGenre(Genre genre) { genres.add(genre); }
    public String getTitle() { return title; }
    public Set<Genre> getGenres() { return genres; }
}
