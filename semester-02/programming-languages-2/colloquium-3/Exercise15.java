import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class Exercise15 {
    public static void main(String[] args) {
        Set<String> groups = new HashSet<>();
        groups.add("AIN-1");
        groups.add("AIN-2");
        groups.add("AIN-1");
        System.out.println(groups);

        Map<String, Integer> grades = new HashMap<>();
        grades.put("Ali", 5);
        grades.put("Dana", 3);
        grades.put("Sam", 4);
        Iterator<Map.Entry<String, Integer>> iterator = grades.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, Integer> entry = iterator.next();
            if (entry.getValue() < 4) iterator.remove();
        }
        System.out.println(grades);
    }
}
