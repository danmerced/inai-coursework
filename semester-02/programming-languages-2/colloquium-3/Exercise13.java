public class Exercise13 {
    static abstract class Lesson {
        static int count = 0;
        String title;

        Lesson(String title) {
            this.title = title;
            count++;
        }

        abstract void printType();

        class Info {
            void print() { System.out.println(title); }
        }
    }

    static class Lecture extends Lesson {
        Lecture(String title) { super(title); }
        void printType() { System.out.println("Lecture"); }
    }

    public static void main(String[] args) {
        Lesson lesson = new Lecture("Java");
        Lesson.Info info = lesson.new Info();
        info.print();
        lesson.printType();
        System.out.println("Count: " + Lesson.count);
    }
}
