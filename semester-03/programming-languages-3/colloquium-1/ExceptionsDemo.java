public class ExceptionsDemo {
    static int parsePositive(String input) {
        int value = Integer.parseInt(input);
        if (value <= 0) throw new IllegalArgumentException("Number must be positive");
        return value;
    }

    public static void main(String[] args) {
        for(String input : new String[]{"15", "-3", "abc"}) {
            try {
                System.out.println(parsePositive(input));
            } catch(NumberFormatException e) {
                System.out.println("Not an integer: " + input);
            } catch(IllegalArgumentException e) {
                System.out.println(e.getMessage());
            } finally {
                System.out.println("Finished " + input);
            }
        }
    }
}
