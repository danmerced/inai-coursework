import java.lang.ref.*;
import java.util.WeakHashMap;

public class ReferencesDemo {
    public static void main(String[] args) {
        Object value = new Object();
        WeakReference<Object> weak = new WeakReference<>(value);
        SoftReference<Object> soft = new SoftReference<>(value);
        ReferenceQueue<Object> queue = new ReferenceQueue<>();
        PhantomReference<Object> phantom = new PhantomReference<>(value, queue);

        System.out.println("Strong: " + (value != null));
        System.out.println("Weak: " + (weak.get() != null));
        System.out.println("Soft: " + (soft.get() != null));
        System.out.println("Phantom get: " + phantom.get());

        WeakHashMap<Object, String> cache = new WeakHashMap<>();
        cache.put(value, "cached data");
        System.out.println(cache.get(value));
        value = null;
        System.gc(); // GC is a request, not a guarantee.
        System.out.println("Weak still available: " + (weak.get() != null));
        System.out.println("Queue: " + queue.poll());
    }
}
