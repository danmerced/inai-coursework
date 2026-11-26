import java.io.*;

public class BinaryStreams {
    public static void main(String[] args) throws IOException {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        try (DataOutputStream out = new DataOutputStream(new BufferedOutputStream(bytes))) {
            out.writeInt(24);
            out.writeUTF("AIN");
            out.writeDouble(4.5);
        }
        try (DataInputStream in = new DataInputStream(new ByteArrayInputStream(bytes.toByteArray()))) {
            System.out.println(in.readInt());
            System.out.println(in.readUTF());
            System.out.println(in.readDouble());
        }
    }
}
