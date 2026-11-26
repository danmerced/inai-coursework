import java.util.Scanner;

public class Exercise05 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a positive number: ");
        int n = scanner.nextInt();
        while (n <= 0) {
            System.out.print("Try again: ");
            n = scanner.nextInt();
        }
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (i % 2 != 0) continue;
            sum += i;
        }
        System.out.println("Sum of even numbers: " + sum);
        int i = 0;
        do {
            i++;
            if (i > 5) break;
            System.out.print(i + " ");
        } while (i < n);
        System.out.println();
    }
}
