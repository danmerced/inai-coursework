public class Exercise06 {
    public static void main(String[] args) {
        int[] numbers = {5, 12, 2, 9, 7};
        int sum = 0;
        int min = numbers[0];
        int max = numbers[0];
        for (int number : numbers) {
            sum += number;
            if (number < min) min = number;
            if (number > max) max = number;
        }
        System.out.println("Sum: " + sum);
        System.out.println("Min: " + min + ", max: " + max);
        System.out.println("Average: " + (double) sum / numbers.length);
    }
}
