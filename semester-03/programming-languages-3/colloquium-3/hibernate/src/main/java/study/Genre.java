package study;

import jakarta.persistence.*;

@Entity
@Table(name = "genres")
public class Genre {
    @Id @GeneratedValue
    private Long id;
    private String name;
    protected Genre() {}
    public Genre(String name) { this.name = name; }
    public String getName() { return name; }
}
