package ulitsa.raskolnikova;

import com.fastcgi.*;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Set;

public class Main {
    // Допустимые значения для X и R
    private static final Set<Double> VALID_X_VALUES = Set.of(-5.0, -4.0, -3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0);
    private static final Set<Double> VALID_R_VALUES = Set.of(1.0, 1.5, 2.0, 2.5, 3.0);

    public static void main(String[] args) {
        while (new FCGIInterface().FCGIaccept() >= 0) {
            String errorMessage = null;
            String query;
            try {
                query = readRequestQuery();
            } catch(Exception e) {
                sendError(e.getMessage());
                continue;
            }

            // Инициализация переменных
            Double x = null, y = null, radius = null;

            try {
                x = parseAndValidateX(query);
            } catch (Exception e) {
                sendError(e.getMessage());
                continue;
            }

            try {
                y = parseAndValidateY(query);
            } catch (Exception e) {
                sendError(e.getMessage());
                continue;
            }

            try {
                radius = parseAndValidateR(query);
            } catch (Exception e) {
                sendError(e.getMessage());
                continue;
            }

            // Расчёт попадания и времени выполнения
            long startTime = System.nanoTime();
            boolean hit = checkHit(x, y, radius);
            long executionTime = System.nanoTime() - startTime;

            // Формирование успешного ответа
            Response response = new Response(x, y, radius, hit, LocalDateTime.now(), executionTime);
            sendHttpResponse(200, response.toJson());
        }
    }

    private static void sendError(String errorMessage) {
        sendHttpResponse(400, "{\"error\": \"" + errorMessage + "\"}");
    }

    private static String readRequestQuery() {
        String query = FCGIInterface.request.params.getProperty("QUERY_STRING");
        if (query == null || query.isEmpty()) {
            throw new IllegalArgumentException("Отсутствует строка запроса.");
        }
        return query;
    }

    private static double parseAndValidateX(String query) {
        String xValue = getParameter(query, "x");
        if (xValue == null) {
            throw new IllegalArgumentException("Параметр x отсутствует.");
        }

        try {
            double x = Double.parseDouble(xValue);
            if (!VALID_X_VALUES.contains(x)) {
                throw new IllegalArgumentException("Параметр x должен быть одним из: " + VALID_X_VALUES);
            }
            return x;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Параметр x должен быть числом.");
        }
    }

    private static double parseAndValidateY(String query) {
        String yValue = getParameter(query, "y");
        if (yValue == null) {
            throw new IllegalArgumentException("Параметр y отсутствует.");
        }

        try {
            double y = Double.parseDouble(yValue);
            if (y < -5 || y > 3) {
                throw new IllegalArgumentException("Параметр y должен быть в диапазоне от -5 до 3.");
            }
            return y;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Параметр y должен быть числом.");
        }
    }

    private static double parseAndValidateR(String query) {
        String rValue = getParameter(query, "radius");
        if (rValue == null) {
            throw new IllegalArgumentException("Параметр radius отсутствует.");
        }

        try {
            double r = Double.parseDouble(rValue);
            if (!VALID_R_VALUES.contains(r)) {
                throw new IllegalArgumentException("Параметр radius должен быть одним из: " + VALID_R_VALUES);
            }
            return r;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Параметр radius должен быть числом.");
        }
    }

    private static String getParameter(String query, String paramName) {
        String[] pairs = query.split("&");
        for (String pair : pairs) {
            String[] keyValue = pair.split("=");
            if (keyValue.length == 2 && keyValue[0].equals(paramName)) {
                return keyValue[1];
            }
        }
        return null;
    }

    private static void sendHttpResponse(int statusCode, String body) {
        String statusMessage = switch (statusCode) {
            case 200 -> "OK";
            case 400 -> "Bad Request";
            case 500 -> "Internal Server Error";
            default -> "Unknown Status";
        };

        String httpResponse = """
        HTTP/1.1 %d %s
        Content-Type: application/json
        Content-Length: %d
        Access-Control-Allow-Origin: *
        
        %s
        """.formatted(statusCode, statusMessage, body.getBytes(StandardCharsets.UTF_8).length, body);

        System.out.println(httpResponse);
    }

    private static boolean checkHit(double x, double y, double r) {
        return (x >= 0 && y <= 0 && x * x + y * y <= r * r) ||
                (x <= 0 && y <= 0 && x >= -r && y >= -r / 2) ||
                (x >= 0 && y >= 0 && y >= -0.5 * x + r / 2);
    }
}
