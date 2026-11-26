import java.util.Scanner;

public class Exercise03 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Name: ");
        String name = scanner.nextLine();
        System.out.print("Age: ");
        int age = scanner.nextInt();
        System.out.print("Average grade: ");
        double grade = scanner.nextDouble();
        System.out.println(name + ", " + age + ", grade: " + grade);
    }
}
