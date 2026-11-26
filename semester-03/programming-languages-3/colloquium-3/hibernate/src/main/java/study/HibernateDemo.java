package study;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class HibernateDemo {
    public static void main(String[] args) {
        Configuration config = new Configuration()
            .addAnnotatedClass(Author.class).addAnnotatedClass(Book.class).addAnnotatedClass(Genre.class)
            .setProperty("hibernate.connection.url","jdbc:h2:mem:library;DB_CLOSE_DELAY=-1")
            .setProperty("hibernate.connection.driver_class","org.h2.Driver")
            .setProperty("hibernate.connection.username","sa")
            .setProperty("hibernate.hbm2ddl.auto","create-drop");
        try (SessionFactory factory = config.buildSessionFactory()) {
            try(Session session = factory.openSession()) {
                Transaction tx = session.beginTransaction();
                try {
                    Author author = new Author("Example author");
                    Genre genre = new Genre("Programming");
                    Book first = new Book("Java basics");
                    Book second = new Book("SQL basics");
                    first.addGenre(genre);
                    second.addGenre(genre);
                    author.addBook(first);
                    author.addBook(second);
                    session.persist(author);
                    tx.commit();
                } catch (RuntimeException e) {
                    if (tx.isActive()) tx.rollback();
                    throw e;
                }
            }
            try(Session session = factory.openSession()) {
                for(Author author : session.createQuery("from Author", Author.class).list()) {
                    System.out.println(author.getName());
                    for(Book book : author.getBooks()) {
                        System.out.println(book.getTitle());
                        for(Genre genre : book.getGenres()) System.out.println("  " + genre.getName());
                    }
                }
            }
        }
    }
}
