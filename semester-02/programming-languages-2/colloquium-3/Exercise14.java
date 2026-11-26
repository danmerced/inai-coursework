import java.util.ArrayList;

public class Exercise14 {
    static class Box<T> {
        private T value;
        Box(T value) { this.value = value; }
        T get() { return value; }
    }

    public static void main(String[] args) {
        Box<String> box = new Box<>("Java");
        System.out.println(box.get());
        ArrayList<Integer> grades = new ArrayList<>();
        grades.add(5);
        grades.add(4);
        grades.add(3);
        int sum = 0;
        for (Integer grade : grades) sum += grade;
        System.out.println("Average: " + (double) sum / grades.size());
    }
}
