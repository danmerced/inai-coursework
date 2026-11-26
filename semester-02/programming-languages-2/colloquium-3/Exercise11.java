public class Exercise11 {
    static class Person {
        String name;
        Person(String name) {
            this.name = name;
        }
        void describe() {
            System.out.println(name);
        }
    }

    static class Student extends Person {
        String group;
        Student(String name, String group) {
            super(name);
            this.group = group;
        }
        @Override
        void describe() {
            System.out.println(name + " - " + group);
        }
    }

    public static void main(String[] args) {
        Person person = new Student("Ali", "AIN");
        person.describe();
        if (person instanceof Student) {
            Student student = (Student) person;
            System.out.println(student.group);
        }
        double value = 8.9;
        int number = (int) value;
        System.out.println(number);
    }
}
