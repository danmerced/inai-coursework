import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;

public class NioDemo {
    public static void main(String[] args) throws IOException {
        Path directory = Files.createTempDirectory("nio-demo");
        Path source = directory.resolve("source.txt");
        Path copy = directory.resolve("copy.txt");
        try {
            try (FileChannel channel = FileChannel.open(source, StandardOpenOption.CREATE_NEW, StandardOpenOption.WRITE)) {
                ByteBuffer data = StandardCharsets.UTF_8.encode("NIO FileChannel");
                while (data.hasRemaining()) channel.write(data);
            }
            Files.copy(source, copy);
            System.out.println("Bytes: " + Files.size(copy));
            System.out.println(Files.readString(copy));
        } finally {
            Files.deleteIfExists(copy);
            Files.deleteIfExists(source);
            Files.deleteIfExists(directory);
        }
    }
}
