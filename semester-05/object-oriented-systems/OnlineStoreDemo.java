import java.io.*;
import java.math.BigDecimal;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.*;
import javax.swing.*;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.SchemaFactory;
import org.w3c.dom.*;

public class OnlineStoreDemo {
    public static void main(String[] args) throws Exception {
        if (args.length > 0 && args[0].equals("--gui")) {
            SwingUtilities.invokeLater(OnlineStoreDemo::showGui);
            return;
        }
        Path target = args.length > 0 ? Path.of(args[0]) : Path.of("output/orders.xml");
        Path schema = Path.of("orders.xsd");
        OnlineStore store = sampleStore(new XmlOrderRepository(target, schema));
        store.addListener(order -> System.out.println("Order event: " + order.id() + " " + order.status()));
        Cart cart = new Cart();
        cart.add(store.product("P1"), 2);
        cart.add(store.product("P2"), 1);
        Order order = store.placeOrder(new Customer("C1","Demo customer"), cart,
                subtotal -> subtotal.multiply(new BigDecimal("0.90")));
        System.out.println("Items: " + order.items());
        System.out.println("Subtotal: " + order.subtotal() + ", paid: " + order.payment().amount());
        System.out.println("Stock P1: " + store.available("P1"));
        try {
            Cart impossible = new Cart();
            impossible.add(store.product("P1"), 100);
            store.placeOrder(new Customer("C2","Demo"), impossible, amount -> amount);
        } catch (IllegalStateException e) {
            System.out.println("Unavailable stock: rejected");
        }
        System.out.println("XML read-back: " + store.repository().readIds());
        try (var pool = Executors.newFixedThreadPool(2)) {
            var a = pool.submit(() -> store.available("P1"));
            var b = pool.submit(() -> store.available("P2"));
            System.out.println("Parallel availability requests: " + a.get() + ", " + b.get());
        }
    }

    static OnlineStore sampleStore(OrderRepository repository) {
        return new OnlineStore(List.of(new Product("P1","Notebook",new BigDecimal("120.00")),
                new Product("P2","Pen",new BigDecimal("35.00"))),Map.of("P1",30,"P2",80),
                repository, new DemoPaymentGateway());
    }

    static void showGui() {
        OnlineStore store=sampleStore(new MemoryOrderRepository());
        JFrame frame=new JFrame("Online Store — order processing demo");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        var panel=new JPanel();
        var combo=new JComboBox<String>(new String[]{"P1 — Notebook","P2 — Pen"});
        var quantity=new JSpinner(new SpinnerNumberModel(1,1,30,1));
        var orderButton=new JButton("Place order");
        var text=new JTextArea(9,48);text.setEditable(false);
        panel.add(combo);panel.add(quantity);panel.add(orderButton);
        frame.add(panel,java.awt.BorderLayout.NORTH);
        frame.add(new JScrollPane(text),java.awt.BorderLayout.CENTER);
        orderButton.addActionListener(e -> {
            try {
                String id=combo.getSelectedIndex()==0?"P1":"P2";
                Cart cart=new Cart();
                cart.add(store.product(id),(int)quantity.getValue());
                Order order=store.placeOrder(new Customer("DEMO","Demo customer"),cart,amount->amount);
                text.append(order.id()+": "+order.payment().amount()+" / stock "+store.available(id)+"\n");
            } catch(Exception failure){text.append(failure.getMessage()+"\n");}
        });
        frame.pack();frame.setLocationRelativeTo(null);frame.setVisible(true);
    }
}

record Customer(String id,String name){}
record Product(String id,String name,BigDecimal price) {
    Product {
        Objects.requireNonNull(price);
        if(price.signum()<0)throw new IllegalArgumentException("Negative price");
        price=price.setScale(2,java.math.RoundingMode.HALF_UP);
    }
}
record CartItem(Product product,int quantity) {
    CartItem { if(quantity<=0)throw new IllegalArgumentException("Quantity must be positive"); }
}
final class Cart {
    private final Map<String,CartItem> items=new LinkedHashMap<>();
    void add(Product product,int quantity) {
        if(quantity<=0)throw new IllegalArgumentException("Quantity must be positive");
        items.compute(product.id(),(key,old)->new CartItem(product,old==null?quantity:Math.addExact(old.quantity(),quantity)));
    }
    List<CartItem> items(){return List.copyOf(items.values());}
}
record OrderItem(String productId,String name,int quantity,BigDecimal unitPrice) {
    BigDecimal total(){return unitPrice.multiply(BigDecimal.valueOf(quantity));}
}
record Payment(String reference,BigDecimal amount){}
enum OrderStatus { PAID }
record Order(String id,Customer customer,List<OrderItem> items,Payment payment,OrderStatus status) {
    Order { items=List.copyOf(items); }
    BigDecimal subtotal(){return items.stream().map(OrderItem::total).reduce(BigDecimal.ZERO,BigDecimal::add);}
}
interface DiscountPolicy { BigDecimal apply(BigDecimal subtotal); }
interface PaymentGateway { Payment authorize(BigDecimal amount); }
final class DemoPaymentGateway implements PaymentGateway {
    // Simulation only. No network or real card data.
    public Payment authorize(BigDecimal amount){return new Payment("DEMO-"+UUID.randomUUID(),amount);}
}
interface OrderListener {void created(Order order);}
interface OrderRepository {
    void save(Order order) throws Exception;
    List<String> readIds() throws Exception;
}
final class MemoryOrderRepository implements OrderRepository {
    private final List<Order> orders=new ArrayList<>();
    public void save(Order order){orders.add(order);}
    public List<String> readIds(){return orders.stream().map(Order::id).toList();}
}
final class OnlineStore {
    private final Map<String,Product> catalog=new HashMap<>();
    private final Map<String,Integer> stock;
    private final OrderRepository repository;
    private final PaymentGateway gateway;
    private final List<OrderListener> listeners=new ArrayList<>();

    OnlineStore(List<Product> products,Map<String,Integer> stock,OrderRepository repository,PaymentGateway gateway){
        for(Product p:products)catalog.put(p.id(),p);
        this.stock=new HashMap<>(stock);
        this.repository=repository;this.gateway=gateway;
    }
    synchronized Product product(String id){
        return Optional.ofNullable(catalog.get(id)).orElseThrow(()->new IllegalArgumentException("Unknown product"));
    }
    synchronized int available(String id){return stock.getOrDefault(id,0);}
    synchronized void addListener(OrderListener listener){listeners.add(listener);}
    OrderRepository repository(){return repository;}

    synchronized Order placeOrder(Customer customer,Cart cart,DiscountPolicy policy) throws Exception {
        if(cart.items().isEmpty())throw new IllegalArgumentException("Cart is empty");
        List<OrderItem> items=new ArrayList<>();
        for(CartItem row:cart.items()){
            Product current=product(row.product().id());
            if(available(current.id())<row.quantity())throw new IllegalStateException("Not enough stock: "+current.id());
            items.add(new OrderItem(current.id(),current.name(),row.quantity(),current.price()));
        }
        BigDecimal subtotal=items.stream().map(OrderItem::total).reduce(BigDecimal.ZERO,BigDecimal::add);
        BigDecimal total=Objects.requireNonNull(policy.apply(subtotal)).setScale(2,java.math.RoundingMode.HALF_UP);
        if(total.signum()<0||total.compareTo(subtotal)>0)throw new IllegalArgumentException("Invalid discount");
        Payment payment=gateway.authorize(total);
        Order order=new Order(UUID.randomUUID().toString(),customer,items,payment,OrderStatus.PAID);
        // XML save must succeed before inventory is updated. Payment is a simulation.
        repository.save(order);
        for(OrderItem item:items)stock.merge(item.productId(),-item.quantity(),Integer::sum);
        for(OrderListener listener:listeners){
            try{listener.created(order);}catch(RuntimeException ignored){/* notifications do not roll back a saved order */}
        }
        return order;
    }
}
final class XmlOrderRepository implements OrderRepository {
    private final Path file,schema;
    XmlOrderRepository(Path file,Path schema){this.file=file.toAbsolutePath();this.schema=schema.toAbsolutePath();}
    private Document load() throws Exception {
        var factory=DocumentBuilderFactory.newInstance();
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl",true);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD,"");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA,"");
        var builder=factory.newDocumentBuilder();
        if(Files.exists(file)){
            validate(file);
            return builder.parse(file.toFile());
        }
        var doc=builder.newDocument();doc.appendChild(doc.createElement("orders"));return doc;
    }
    private void validate(Path path)throws Exception{
        var factory=SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        factory.setProperty(XMLConstants.ACCESS_EXTERNAL_DTD,"");
        factory.setProperty(XMLConstants.ACCESS_EXTERNAL_SCHEMA,"");
        factory.newSchema(schema.toFile()).newValidator().validate(new StreamSource(path.toFile()));
    }
    private static Element element(Document doc,Element parent,String name){
        Element e=doc.createElement(name);parent.appendChild(e);return e;
    }
    public synchronized void save(Order order)throws Exception {
        var doc=load();var node=element(doc,doc.getDocumentElement(),"order");
        node.setAttribute("id",order.id());node.setAttribute("customerId",order.customer().id());
        node.setAttribute("status",order.status().name());node.setAttribute("total",order.payment().amount().toPlainString());
        for(OrderItem item:order.items()){
            var row=element(doc,node,"item");row.setAttribute("productId",item.productId());
            row.setAttribute("quantity",Integer.toString(item.quantity()));row.setAttribute("price",item.unitPrice().toPlainString());
        }
        Files.createDirectories(file.getParent());
        Path tmp=Files.createTempFile(file.getParent(),"orders-",".tmp");
        try{
            var factory=TransformerFactory.newInstance();
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD,"");
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET,"");
            var transformer=factory.newTransformer();transformer.setOutputProperty(OutputKeys.INDENT,"yes");
            transformer.transform(new DOMSource(doc),new StreamResult(tmp.toFile()));
            validate(tmp);
            try{Files.move(tmp,file,StandardCopyOption.ATOMIC_MOVE,StandardCopyOption.REPLACE_EXISTING);}
            catch(AtomicMoveNotSupportedException e){Files.move(tmp,file,StandardCopyOption.REPLACE_EXISTING);}
        }finally{Files.deleteIfExists(tmp);}
    }
    public synchronized List<String> readIds()throws Exception {
        var nodes=load().getElementsByTagName("order");
        List<String> ids=new ArrayList<>();
        for(int i=0;i<nodes.getLength();i++)ids.add(((Element)nodes.item(i)).getAttribute("id"));
        return ids;
    }
}
