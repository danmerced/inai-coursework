import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

public class ResourceDemo {
    static class EmptyFileException extends IOException {
        EmptyFileException() { super("File has no content"); }
    }

    static String readFirstLine(Path file) throws IOException {
        try (BufferedReader reader = Files.newBufferedReader(file, StandardCharsets.UTF_8)) {
            String line = reader.readLine();
            if (line == null) throw new EmptyFileException();
            return line;
        }
    }

    public static void main(String[] args) throws IOException {
        Path file = Files.createTempFile("resource", ".txt");
        try {
            try { System.out.println(readFirstLine(file)); }
            catch (EmptyFileException e) { System.out.println(e.getMessage()); }
            Files.writeString(file, "Java I/O");
            System.out.println(readFirstLine(file));
        } finally {
            Files.deleteIfExists(file);
        }
    }
}
