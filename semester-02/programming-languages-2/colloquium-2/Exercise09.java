public class Exercise09 {
    private static final int MAX_LENGTH = 20;
    private String text = "Java";

    public void printText(String text) {
        System.out.println("Field: " + this.text);
        if (text.length() <= MAX_LENGTH) {
            System.out.println(text.trim().toUpperCase());
        }
    }

    public static void main(String[] args) {
        Exercise09 example = new Exercise09();
        example.printText("  hello world  ");
        String word = "programming";
        System.out.println(word.substring(0, 7));
        System.out.println(word.contains("gram"));
    }
}
