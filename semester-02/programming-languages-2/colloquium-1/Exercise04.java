import java.util.Scanner;

public class Exercise04 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Score (0-100): ");
        int score = scanner.nextInt();
        if (score < 0 || score > 100) {
            System.out.println("Invalid score");
        } else {
            String grade;
            if (score >= 90) grade = "A";
            else if (score >= 75) grade = "B";
            else if (score >= 60) grade = "C";
            else grade = "F";
            System.out.println("Grade: " + grade);
            System.out.println(score >= 60 ? "Passed" : "Failed");
        }
    }
}
