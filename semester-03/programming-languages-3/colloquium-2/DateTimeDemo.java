import java.time.*;
import java.time.format.DateTimeFormatter;

public class DateTimeDemo {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2025, 9, 1);
        LocalTime time = LocalTime.of(12, 30);
        ZonedDateTime bishkek = ZonedDateTime.of(date, time, ZoneId.of("Asia/Bishkek"));
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm z");
        System.out.println(bishkek.format(format));
        System.out.println(bishkek.withZoneSameInstant(ZoneId.of("Europe/Berlin")).format(format));
        System.out.println("Next week: " + date.plusWeeks(1));
        System.out.println("Instant: " + bishkek.toInstant());
        System.out.println("Lesson: " + Duration.between(time, time.plusMinutes(90)).toMinutes() + " min");
    }
}
