package ulitsa.raskolnikova;

import java.time.LocalDateTime;
import java.util.Locale;

public record Response(
        double x,
        double y,
        double radius,
        boolean hit,
        LocalDateTime currentTime,
        long executionTime
) {
    public String toJson() {
        return String.format(Locale.US,
                "{\"x\": %.2f, \"y\": %.2f, \"radius\": %.2f, " +
                        "\"hit\": %b, \"currentTime\": \"%s\", \"executionTime\": %d}",
                x, y, radius, hit, currentTime.toString(), executionTime
        );
    }
}
