import java.util.Arrays;

public class Exercise10 {
    public static void main(String[] args) {
        int[] values = {7, 2, 5, 1};
        Arrays.sort(values);
        StringBuilder builder = new StringBuilder();
        for (int value : values) {
            builder.append(value).append(" ");
        }
        System.out.println(builder.toString().trim());
        String formatted = String.format("Price: %.2f KGS", 125.5);
        System.out.println(formatted);
        System.out.println("Unicode: \u0416");
        System.out.println("Index: " + Arrays.binarySearch(values, 5));
    }
}
