public class Exercise02 {
    public static void main(String[] args) {
        int count = 5;
        int price = 120;
        System.out.println("Total: " + count * price);
        count++;
        String result = String.valueOf(count);
        int number = Integer.parseInt(result);
        System.out.println("Quantity: " + number);
    }
}
