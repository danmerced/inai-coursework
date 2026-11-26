import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.concurrent.*;

public class NetworkDemo {
    public interface Catalog extends Remote { int stock(String product) throws RemoteException; }

    public static class CatalogService implements Catalog {
        public int stock(String product){return product.equals("P1")?30:0;}
    }

    public static void main(String[] args)throws Exception {
        try(var server=new ServerSocket(0,10,InetAddress.getLoopbackAddress());
            var pool=Executors.newSingleThreadExecutor()) {
            server.setSoTimeout(5000);
            var response=pool.submit(()->{
                try(var socket=server.accept();
                    var in=new BufferedReader(new InputStreamReader(socket.getInputStream(),StandardCharsets.UTF_8));
                    var out=new PrintWriter(socket.getOutputStream(),true,StandardCharsets.UTF_8)){
                    socket.setSoTimeout(5000);
                    String request=in.readLine();
                    out.println("P1".equals(request)?"stock=30":"unknown");
                }
                return null;
            });
            try(var socket=new Socket(InetAddress.getLoopbackAddress(),server.getLocalPort());
                var in=new BufferedReader(new InputStreamReader(socket.getInputStream(),StandardCharsets.UTF_8));
                var out=new PrintWriter(socket.getOutputStream(),true,StandardCharsets.UTF_8)){
                socket.setSoTimeout(5000);
                out.println("P1");System.out.println("TCP response: "+in.readLine());
            }
            response.get(5,TimeUnit.SECONDS);
        }
        // Single-host remote object exercise; no RMI registry needed to use its stub.
        var implementation=new CatalogService();
        var factory=new LoopbackFactory();
        Catalog stub=(Catalog)UnicastRemoteObject.exportObject(implementation,0,factory,factory);
        try{System.out.println("RMI response: "+stub.stock("P1"));}
        finally{UnicastRemoteObject.unexportObject(implementation,true);}
    }

    static final class LoopbackFactory implements java.rmi.server.RMIClientSocketFactory,
            java.rmi.server.RMIServerSocketFactory, Serializable {
        public Socket createSocket(String host,int port)throws IOException{return new Socket(InetAddress.getLoopbackAddress(),port);}
        public ServerSocket createServerSocket(int port)throws IOException{return new ServerSocket(port,10,InetAddress.getLoopbackAddress());}
    }
}
