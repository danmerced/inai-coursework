import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.*;
import java.nio.charset.StandardCharsets;

public class SelectorDemo {
    public static void main(String[] args) throws IOException {
        try (Selector selector = Selector.open();
             ServerSocketChannel server = ServerSocketChannel.open();
             SocketChannel client = SocketChannel.open()) {
            server.bind(new InetSocketAddress("127.0.0.1", 0));
            server.configureBlocking(false);
            server.register(selector, SelectionKey.OP_ACCEPT);
            client.connect(server.getLocalAddress());
            ByteBuffer sent = StandardCharsets.UTF_8.encode("Hello NIO");
            while (sent.hasRemaining()) client.write(sent);
            client.shutdownOutput();
            long end = System.currentTimeMillis() + 3000;
            boolean finished = false;
            try {
                while (!finished && System.currentTimeMillis() < end) {
                    selector.select(100);
                    var iterator = selector.selectedKeys().iterator();
                    while (iterator.hasNext()) {
                        SelectionKey key = iterator.next();
                        iterator.remove();
                        if (key.isAcceptable()) {
                            SocketChannel connection = server.accept();
                            if (connection != null) {
                                connection.configureBlocking(false);
                                connection.register(selector, SelectionKey.OP_READ);
                            }
                        } else if (key.isReadable()) {
                            SocketChannel connection = (SocketChannel) key.channel();
                            ByteBuffer buffer = ByteBuffer.allocate(32);
                            int count = connection.read(buffer);
                            if (count < 0) {
                                connection.close();
                                finished = true;
                            } else {
                                buffer.flip();
                                System.out.print(StandardCharsets.UTF_8.decode(buffer));
                            }
                        }
                    }
                }
                if (!finished) throw new IOException("Timeout");
                System.out.println();
            } finally {
                for (SelectionKey key : selector.keys()) key.channel().close();
            }
        }
    }
}
