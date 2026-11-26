public class Exercise08 {
    public static double rectangleArea(double width, double height) {
        return width * height;
    }

    private static double perimeter(double width, double height) {
        return 2 * (width + height);
    }

    public static void printRectangle(double width, double height) {
        System.out.println("Area: " + rectangleArea(width, height));
        System.out.println("Perimeter: " + perimeter(width, height));
    }

    public static void main(String[] args) {
        printRectangle(4, 6);
    }
}
