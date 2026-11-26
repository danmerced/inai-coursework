import java.util.Objects;

public class Exercise12 {
    static class Student {
        private int id;
        private String name;

        Student(int id, String name) {
            this.id = id;
            this.name = name;
        }

        int getId() { return id; }
        String getName() { return name; }
        void setName(String name) { this.name = name; }

        @Override
        public boolean equals(Object other) {
            if (this == other) return true;
            if (!(other instanceof Student)) return false;
            Student student = (Student) other;
            return id == student.id;
        }

        @Override
        public int hashCode() {
            return Objects.hash(id);
        }
    }

    public static void main(String[] args) {
        Student a = new Student(1, "Ali");
        Student b = new Student(1, "Ali");
        a.setName("Alan");
        System.out.println(a.getId() + " " + a.getName());
        System.out.println(a.equals(b));
        System.out.println(a.hashCode() == b.hashCode());
    }
}
