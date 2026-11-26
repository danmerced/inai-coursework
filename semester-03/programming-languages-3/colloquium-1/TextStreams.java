import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

public class TextStreams {
    public static void main(String[] args) throws IOException {
        Path file = Files.createTempFile("notes", ".txt");
        try {
            try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                    Files.newOutputStream(file), StandardCharsets.UTF_8))) {
                writer.write("Java");
                writer.newLine();
                writer.write("Потоки");
            }
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                    Files.newInputStream(file), StandardCharsets.UTF_8))) {
                String line;
                int count = 0;
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                    count++;
                }
                System.out.println("Lines: " + count);
            }
        } finally { Files.deleteIfExists(file); }
    }
}
