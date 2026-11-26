public class Exercise07 {
    public static void main(String[] args) {
        int[][] matrix = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        int diagonal = 0;
        for (int i = 0; i < matrix.length; i++) {
            int rowSum = 0;
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
                rowSum += matrix[i][j];
            }
            diagonal += matrix[i][i];
            System.out.println("sum = " + rowSum);
        }
        System.out.println("Diagonal: " + diagonal);
        int[][] jagged = {{10, 20}, {30}, {40, 50, 60}};
        for (int[] row : jagged) {
            for (int number : row) System.out.print(number + " ");
            System.out.println();
        }
    }
}
