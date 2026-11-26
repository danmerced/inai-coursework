import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class LibraryDemo {
    public static void main(String[] args) {
        Library library = new Library();
        library.add(new Book(1, "Java basics", "Demo author"));
        library.add(new Book(2, "Algorithms", "Demo author"));
        library.add(new Magazine(3, "Science", 12));
        System.out.println("Available:");
        library.available().forEach(System.out::println);
        library.borrow(2);
        try {
            library.borrow(2);
        } catch (IllegalStateException e) {
            System.out.println("Second checkout: " + e.getMessage());
        }
        System.out.println("After checkout:");
        library.available().forEach(System.out::println);
        library.giveBack(2);
        System.out.println("After return: " + library.available().size() + " available");
    }
}

abstract class Publication {
    private final int id;
    private final String title;
    private boolean borrowed;

    protected Publication(int id, String title) {
        if (id <= 0 || title.isBlank()) throw new IllegalArgumentException("Invalid publication");
        this.id = id;
        this.title = title;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public boolean isBorrowed() { return borrowed; }
    public abstract int loanDays();

    public void borrow() {
        if (borrowed) throw new IllegalStateException("Already borrowed");
        borrowed = true;
    }

    public void giveBack() {
        if (!borrowed) throw new IllegalStateException("Not borrowed");
        borrowed = false;
    }

    @Override
    public String toString() {
        return id + ": " + title + " (" + loanDays() + " days, "
                + (borrowed ? "borrowed" : "available") + ")";
    }
}

class Book extends Publication {
    private final String author;
    Book(int id, String title, String author) {
        super(id, title);
        this.author = author;
    }
    public String getAuthor() { return author; }
    @Override public int loanDays() { return 14; }
}

class Magazine extends Publication {
    private final int issue;
    Magazine(int id, String title, int issue) {
        super(id, title);
        if (issue <= 0) throw new IllegalArgumentException("Invalid issue");
        this.issue = issue;
    }
    public int getIssue() { return issue; }
    @Override public int loanDays() { return 7; }
}

interface Catalog {
    void add(Publication item);
    Optional<Publication> find(int id);
    List<Publication> available();
}

class Library implements Catalog {
    private final List<Publication> publications = new ArrayList<>();

    @Override
    public void add(Publication item) {
        if (find(item.getId()).isPresent()) throw new IllegalArgumentException("Duplicate ID");
        publications.add(item);
    }

    @Override
    public Optional<Publication> find(int id) {
        return publications.stream().filter(p -> p.getId() == id).findFirst();
    }

    @Override
    public List<Publication> available() {
        return publications.stream().filter(p -> !p.isBorrowed()).toList();
    }

    public void borrow(int id) { find(id).orElseThrow().borrow(); }
    public void giveBack(int id) { find(id).orElseThrow().giveBack(); }
}

